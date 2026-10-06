import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/grocery/data/models/category_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_response.dart';

abstract class GroceryRemoteDataSource {
  Future<Either<AppException, ProductResponse>> getGroceryItems({
    ProductRequest? request,
  });

  Future<Either<AppException, CategoryResponse>> getCategories();

  Future<Either<AppException, ProductDetailResponse>> getProductDetail(
    ProductDetailRequest request,
  );
}

class GroceryRemoteDataSourceImpl implements GroceryRemoteDataSource {
  final NetworkService networkService;

  GroceryRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, ProductResponse>> getGroceryItems({
    ProductRequest? request,
  }) async {
    try {
      Either eitherType = await networkService.get(
        ApiEndpoint.products,
        queryParameters: request?.toQueryParams(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          ProductResponse res = ProductResponse.fromJson(response.data);
          return Right(res);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'GroceryRemoteDataSource.getGroceryItems',
      );
    }
  }

  @override
  Future<Either<AppException, CategoryResponse>> getCategories() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.categories);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          CategoryResponse res = CategoryResponse.fromJson(response.data);
          return Right(res);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'GroceryRemoteDataSource.getCategories',
      );
    }
  }

  @override
  Future<Either<AppException, ProductDetailResponse>> getProductDetail(
    ProductDetailRequest request,
  ) async {
    try {
      Either eitherType = await networkService.get(
        '${ApiEndpoint.products}/${request.id}',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          ProductDetailResponse res = ProductDetailResponse.fromJson(
            response.data,
          );
          return Right(res);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'GroceryRemoteDataSource.getProductDetail',
      );
    }
  }
}
