import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product_request.dart';
import 'package:bloc_advanced/features/dashboard/data/models/products_response.dart';

abstract class DashboardRepository {
  Future<Either<AppException, ProductsResponse>> getProducts({
    required ProductRequest request,
  });
}
