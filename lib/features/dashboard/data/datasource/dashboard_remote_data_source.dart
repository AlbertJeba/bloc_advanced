import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product_request.dart';
import 'package:bloc_advanced/features/dashboard/data/models/products_response.dart';

abstract class DashboardRemoteDataSource {
  Future<Either<AppException, ProductsResponse>> getProducts({
    required ProductRequest request,
  });
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final NetworkService networkService;

  DashboardRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, ProductsResponse>> getProducts({
    required ProductRequest request,
  }) async {
    try {
      Either eitherType = await networkService.get(
        ApiEndpoint.products,
        queryParameters: request.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          ProductsResponse productsResponse =
              ProductsResponse.fromJson(response.data);
          return Right(productsResponse);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(
          e, 'DashboardRemoteDataSource.getProducts');
    }
  }
}
