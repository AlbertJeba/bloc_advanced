part of 'cart_cubit.dart';

class CartState extends Equatable {
  final CartData? cartData;
  final bool isLoading;
  final String errorMessage;
  final String? updatingProductId;

  const CartState({
    this.cartData,
    this.isLoading = false,
    this.errorMessage = '',
    this.updatingProductId,
  });

  CartState copyWith({
    CartData? cartData,
    bool? isLoading,
    String? errorMessage,
    String? updatingProductId,
    bool clearUpdatingProduct = false,
  }) {
    return CartState(
      cartData: cartData ?? this.cartData,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      updatingProductId: clearUpdatingProduct
          ? null
          : (updatingProductId ?? this.updatingProductId),
    );
  }

  @override
  List<Object?> get props => [
    cartData,
    isLoading,
    errorMessage,
    updatingProductId,
  ];
}
