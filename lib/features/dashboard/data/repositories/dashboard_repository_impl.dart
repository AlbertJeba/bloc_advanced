import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product_request.dart';
import 'package:bloc_advanced/features/dashboard/data/models/products_response.dart';
import 'package:bloc_advanced/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardRemoteDataSource _dashboardDataSource;

  DashboardRepositoryImpl(this._dashboardDataSource);

  @override
  Future<Either<AppException, ProductsResponse>> getProducts({
    required ProductRequest request,
  }) {
    return _dashboardDataSource.getProducts(request: request);
  }
}
