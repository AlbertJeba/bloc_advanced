part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final ProductDetailModel? product;
  final bool isLoading;
  final String errorMessage;
  final int selectedImageIndex;
  final int quantity;

  const ProductDetailState({
    this.product,
    this.isLoading = false,
    this.errorMessage = '',
    this.selectedImageIndex = 0,
    this.quantity = 1,
  });

  ProductDetailState copyWith({
    ProductDetailModel? product,
    bool? isLoading,
    String? errorMessage,
    int? selectedImageIndex,
    int? quantity,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
    product,
    isLoading,
    errorMessage,
    selectedImageIndex,
    quantity,
  ];
}
