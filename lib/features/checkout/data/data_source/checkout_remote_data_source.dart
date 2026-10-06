import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/checkout/data/models/address_list_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_address_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_order_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/order_response.dart';

abstract class CheckoutRemoteDataSource {
  Future<Either<AppException, AddressListResponse>> getAddresses();

  Future<Either<AppException, AddressListResponse>> createAddress(
    CreateAddressRequest request,
  );

  Future<Either<AppException, CheckoutSummaryResponse>> getCheckoutSummary(
    CheckoutSummaryRequest request,
  );

  Future<Either<AppException, OrderResponse>> placeOrder(
    CreateOrderRequest request,
  );
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final NetworkService networkService;

  CheckoutRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, AddressListResponse>> getAddresses() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.addresses);
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = AddressListResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'CheckoutRemoteDataSource.getAddresses',
      );
    }
  }

  @override
  Future<Either<AppException, AddressListResponse>> createAddress(
    CreateAddressRequest request,
  ) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.addresses,
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) async {
        // Re-fetch addresses list after creation
        return getAddresses();
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'CheckoutRemoteDataSource.createAddress',
      );
    }
  }

  @override
  Future<Either<AppException, CheckoutSummaryResponse>> getCheckoutSummary(
    CheckoutSummaryRequest request,
  ) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.checkoutSummary,
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = CheckoutSummaryResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'CheckoutRemoteDataSource.getCheckoutSummary',
      );
    }
  }

  @override
  Future<Either<AppException, OrderResponse>> placeOrder(
    CreateOrderRequest request,
  ) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.orders,
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = OrderResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'CheckoutRemoteDataSource.placeOrder',
      );
    }
  }
}
