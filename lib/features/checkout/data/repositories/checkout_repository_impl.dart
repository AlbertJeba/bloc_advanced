import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/checkout/data/data_source/checkout_remote_data_source.dart';
import 'package:bloc_advanced/features/checkout/data/models/address_list_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_address_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_order_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/order_response.dart';
import 'package:bloc_advanced/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, AddressListResponse>> getAddresses() {
    return remoteDataSource.getAddresses();
  }

  @override
  Future<Either<AppException, AddressListResponse>> createAddress(
    CreateAddressRequest request,
  ) {
    return remoteDataSource.createAddress(request);
  }

  @override
  Future<Either<AppException, CheckoutSummaryResponse>> getCheckoutSummary(
    CheckoutSummaryRequest request,
  ) {
    return remoteDataSource.getCheckoutSummary(request);
  }

  @override
  Future<Either<AppException, OrderResponse>> placeOrder(
    CreateOrderRequest request,
  ) {
    return remoteDataSource.placeOrder(request);
  }
}
