import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_request.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_list_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_request.dart';

abstract class OrderRepository {
  Future<Either<AppException, OrderListResponse>> getOrders({
    OrderRequest? request,
  });

  Future<Either<AppException, OrderDetailResponse>> getOrderDetail(
    OrderDetailRequest request,
  );
}
