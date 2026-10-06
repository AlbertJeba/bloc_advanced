import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_request.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_list_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_request.dart';

abstract class OrderRemoteDataSource {
  Future<Either<AppException, OrderListResponse>> getOrders({
    OrderRequest? request,
  });

  Future<Either<AppException, OrderDetailResponse>> getOrderDetail(
    OrderDetailRequest request,
  );
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final NetworkService networkService;

  OrderRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, OrderListResponse>> getOrders({
    OrderRequest? request,
  }) async {
    try {
      final req = request ?? const OrderRequest();
      Either eitherType = await networkService.get(
        ApiEndpoint.orders,
        queryParameters: req.toQueryParams(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = OrderListResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(e, 'OrderRemoteDataSource.getOrders');
    }
  }

  @override
  Future<Either<AppException, OrderDetailResponse>> getOrderDetail(
    OrderDetailRequest request,
  ) async {
    try {
      Either eitherType = await networkService.get(
        '${ApiEndpoint.orders}/${request.orderId}',
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = OrderDetailResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'OrderRemoteDataSource.getOrderDetail',
      );
    }
  }
}
