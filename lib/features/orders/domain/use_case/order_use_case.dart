import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_request.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_list_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_request.dart';
import 'package:bloc_advanced/features/orders/domain/repositories/order_repository.dart';

class OrderUseCase {
  final OrderRepository repository;

  OrderUseCase(this.repository);

  Future<Either<AppException, OrderListResponse>> getOrders({
    OrderRequest? request,
  }) {
    return repository.getOrders(request: request ?? const OrderRequest());
  }

  Future<Either<AppException, OrderDetailResponse>> getOrderDetail(
    OrderDetailRequest request,
  ) {
    return repository.getOrderDetail(request);
  }
}
