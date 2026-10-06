import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/cart_response.dart';
import 'package:bloc_advanced/features/cart/data/models/remove_from_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/update_cart_request.dart';
import 'package:bloc_advanced/features/cart/domain/use_case/cart_use_case.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartUseCase _cartUseCase;

  CartCubit(this._cartUseCase) : super(const CartState());

  Future<void> fetchCart({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(isLoading: true, errorMessage: ''));
    }

    final result = await _cartUseCase.getCart();

    result.fold(
      (error) {
        ErrorLogger.log('CartCubit.fetchCart', error.message);
        emit(state.copyWith(isLoading: false, errorMessage: error.message));
      },
      (response) {
        emit(state.copyWith(isLoading: false, cartData: response.data));
      },
    );
  }

  Future<bool> addToCart(String productId, {int quantity = 1}) async {
    final request = AddToCartRequest(productId: productId, quantity: quantity);
    final result = await _cartUseCase.addItem(request);

    return result.fold(
      (error) {
        ErrorLogger.log('CartCubit.addToCart', error.message);
        emit(state.copyWith(errorMessage: error.message));
        return false;
      },
      (response) {
        emit(state.copyWith(cartData: response.data));
        return true;
      },
    );
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(productId);
      return;
    }

    emit(state.copyWith(updatingProductId: productId));

    final request = UpdateCartRequest(
      productId: productId,
      quantity: newQuantity,
    );
    final result = await _cartUseCase.updateQuantity(request);

    result.fold(
      (error) {
        ErrorLogger.log('CartCubit.updateQuantity', error.message);
        emit(
          state.copyWith(
            clearUpdatingProduct: true,
            errorMessage: error.message,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(clearUpdatingProduct: true, cartData: response.data),
        );
      },
    );
  }

  Future<void> removeItem(String productId) async {
    emit(state.copyWith(updatingProductId: productId));

    final request = RemoveFromCartRequest(productId: productId);
    final result = await _cartUseCase.removeItem(request);

    result.fold(
      (error) {
        ErrorLogger.log('CartCubit.removeItem', error.message);
        emit(
          state.copyWith(
            clearUpdatingProduct: true,
            errorMessage: error.message,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(clearUpdatingProduct: true, cartData: response.data),
        );
      },
    );
  }

  Future<void> clearCart() async {
    emit(state.copyWith(isLoading: true));

    final result = await _cartUseCase.clearCart();

    result.fold(
      (error) {
        ErrorLogger.log('CartCubit.clearCart', error.message);
        emit(state.copyWith(isLoading: false, errorMessage: error.message));
      },
      (response) {
        emit(state.copyWith(isLoading: false, cartData: response.data));
      },
    );
  }
}
