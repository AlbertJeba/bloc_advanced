import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/cart_response.dart';
import 'package:bloc_advanced/features/cart/data/models/remove_from_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/update_cart_request.dart';

abstract class CartRemoteDataSource {
  Future<Either<AppException, CartResponse>> getCart();

  Future<Either<AppException, CartResponse>> addItem(AddToCartRequest request);

  Future<Either<AppException, CartResponse>> updateQuantity(
    UpdateCartRequest request,
  );

  Future<Either<AppException, CartResponse>> removeItem(
    RemoveFromCartRequest request,
  );

  Future<Either<AppException, CartResponse>> clearCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final NetworkService networkService;

  CartRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, CartResponse>> getCart() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.cart);
      return eitherType.fold((exception) => Left(exception), (response) {
        CartResponse res = CartResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(e, 'CartRemoteDataSource.getCart');
    }
  }

  @override
  Future<Either<AppException, CartResponse>> addItem(
    AddToCartRequest request,
  ) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.cartItems,
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        CartResponse res = CartResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(e, 'CartRemoteDataSource.addItem');
    }
  }

  @override
  Future<Either<AppException, CartResponse>> updateQuantity(
    UpdateCartRequest request,
  ) async {
    try {
      Either eitherType = await networkService.put(
        '${ApiEndpoint.cartItems}/${request.productId}',
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        CartResponse res = CartResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'CartRemoteDataSource.updateQuantity',
      );
    }
  }

  @override
  Future<Either<AppException, CartResponse>> removeItem(
    RemoveFromCartRequest request,
  ) async {
    try {
      Either eitherType = await networkService.delete(
        '${ApiEndpoint.cartItems}/${request.productId}',
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        CartResponse res = CartResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(e, 'CartRemoteDataSource.removeItem');
    }
  }

  @override
  Future<Either<AppException, CartResponse>> clearCart() async {
    try {
      Either eitherType = await networkService.delete(ApiEndpoint.cart);
      return eitherType.fold((exception) => Left(exception), (response) {
        CartResponse res = CartResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(e, 'CartRemoteDataSource.clearCart');
    }
  }
}
