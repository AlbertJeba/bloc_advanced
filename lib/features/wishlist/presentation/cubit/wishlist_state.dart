part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  final List<ProductModel> items;
  final Set<String> wishlistIds;
  final bool isLoading;
  final String? togglingId;
  final String errorMessage;

  const WishlistState({
    this.items = const [],
    this.wishlistIds = const {},
    this.isLoading = false,
    this.togglingId,
    this.errorMessage = '',
  });

  WishlistState copyWith({
    List<ProductModel>? items,
    Set<String>? wishlistIds,
    bool? isLoading,
    String? togglingId,
    String? errorMessage,
  }) {
    return WishlistState(
      items: items ?? this.items,
      wishlistIds: wishlistIds ?? this.wishlistIds,
      isLoading: isLoading ?? this.isLoading,
      togglingId: togglingId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isInWishlist(String? productId) {
    if (productId == null) return false;
    return wishlistIds.contains(productId);
  }

  @override
  List<Object?> get props => [
    items,
    wishlistIds,
    isLoading,
    togglingId,
    errorMessage,
  ];
}
