import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/grocery/data/data_source/grocery_remote_data_source.dart';
import 'package:bloc_advanced/features/grocery/data/models/category_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_response.dart';
import 'package:bloc_advanced/features/grocery/domain/repositories/grocery_repository.dart';

class GroceryRepositoryImpl implements GroceryRepository {
  final GroceryRemoteDataSource remoteDataSource;

  GroceryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, ProductResponse>> getGroceryItems({
    ProductRequest? request,
  }) {
    return remoteDataSource.getGroceryItems(request: request);
  }

  @override
  Future<Either<AppException, CategoryResponse>> getCategories() {
    return remoteDataSource.getCategories();
  }

  @override
  Future<Either<AppException, ProductDetailResponse>> getProductDetail(
    ProductDetailRequest request,
  ) {
    return remoteDataSource.getProductDetail(request);
  }
}
