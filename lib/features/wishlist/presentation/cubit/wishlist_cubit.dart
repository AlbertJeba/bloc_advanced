import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_model.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_request.dart';
import 'package:bloc_advanced/features/wishlist/domain/use_case/wishlist_use_case.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistUseCase _wishlistUseCase;

  WishlistCubit(this._wishlistUseCase) : super(const WishlistState());

  Future<void> fetchWishlist() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final result = await _wishlistUseCase.getWishlist();

    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (response) {
        final products = response.data?.products ?? [];
        final ids = products
            .map((p) => p.id ?? '')
            .where((id) => id.isNotEmpty)
            .toSet();

        emit(
          state.copyWith(isLoading: false, items: products, wishlistIds: ids),
        );
      },
    );
  }

  Future<void> toggleWishlist(ProductModel product) async {
    final productId = product.id ?? '';
    if (productId.isEmpty) return;

    final wasInWishlist = state.isInWishlist(productId);
    final updatedIds = Set<String>.from(state.wishlistIds);

    if (wasInWishlist) {
      updatedIds.remove(productId);
    } else {
      updatedIds.add(productId);
    }

    // Optimistic UI update
    emit(state.copyWith(wishlistIds: updatedIds, togglingId: productId));

    final result = await _wishlistUseCase.toggleWishlist(
      ToggleWishlistRequest(productId: productId),
    );

    result.fold(
      (error) {
        // Revert on error
        final revertedIds = Set<String>.from(state.wishlistIds);
        if (wasInWishlist) {
          revertedIds.add(productId);
        } else {
          revertedIds.remove(productId);
        }
        emit(
          state.copyWith(
            wishlistIds: revertedIds,
            togglingId: null,
            errorMessage: error.message,
          ),
        );
      },
      (response) {
        final inWishlist = response.data?.inWishlist ?? false;
        final syncedIds = Set<String>.from(state.wishlistIds);
        List<ProductModel> updatedItems = List.from(state.items);

        if (inWishlist) {
          syncedIds.add(productId);
          if (!updatedItems.any((p) => p.id == productId)) {
            updatedItems.add(product);
          }
        } else {
          syncedIds.remove(productId);
          updatedItems.removeWhere((p) => p.id == productId);
        }

        emit(
          state.copyWith(
            wishlistIds: syncedIds,
            items: updatedItems,
            togglingId: null,
          ),
        );
      },
    );
  }
}
