import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_response.dart';
import 'package:bloc_advanced/features/grocery/domain/repositories/grocery_repository.dart';

class GetProductDetailUseCase {
  final GroceryRepository _repository;

  GetProductDetailUseCase(this._repository);

  Future<Either<AppException, ProductDetailResponse>> execute(
    ProductDetailRequest request,
  ) {
    return _repository.getProductDetail(request);
  }
}
