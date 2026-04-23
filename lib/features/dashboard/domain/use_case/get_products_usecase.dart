import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product_request.dart';
import 'package:bloc_advanced/features/dashboard/data/models/products_response.dart';
import 'package:bloc_advanced/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetProductsUseCase {
  final DashboardRepository _dashboardRepository;

  const GetProductsUseCase(this._dashboardRepository);

  Future<Either<AppException, ProductsResponse>> call({
    required ProductRequest request,
  }) async {
    return _dashboardRepository.getProducts(request: request);
  }
}
