import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_response.dart';
import 'package:bloc_advanced/features/grocery/domain/use_case/get_product_detail_use_case.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase _getProductDetailUseCase;

  ProductDetailCubit(this._getProductDetailUseCase)
    : super(const ProductDetailState());

  Future<void> fetchProductDetail(ProductDetailRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final result = await _getProductDetailUseCase.execute(request);

    result.fold(
      (error) {
        ErrorLogger.log('ProductDetailCubit.fetchProductDetail', error.message);
        emit(state.copyWith(isLoading: false, errorMessage: error.message));
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            product: response.data,
            selectedImageIndex: 0,
          ),
        );
      },
    );
  }

  void selectImage(int index) {
    emit(state.copyWith(selectedImageIndex: index));
  }

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}
