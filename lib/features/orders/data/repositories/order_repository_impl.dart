import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_request.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_list_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_request.dart';
import 'package:bloc_advanced/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, OrderListResponse>> getOrders({
    OrderRequest? request,
  }) {
    return remoteDataSource.getOrders(request: request ?? const OrderRequest());
  }

  @override
  Future<Either<AppException, OrderDetailResponse>> getOrderDetail(
    OrderDetailRequest request,
  ) {
    return remoteDataSource.getOrderDetail(request);
  }
}
