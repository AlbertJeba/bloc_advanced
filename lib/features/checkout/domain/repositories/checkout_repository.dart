import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/checkout/data/models/address_list_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_address_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_order_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/order_response.dart';

abstract class CheckoutRepository {
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
