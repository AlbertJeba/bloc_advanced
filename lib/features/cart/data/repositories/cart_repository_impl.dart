import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/cart_response.dart';
import 'package:bloc_advanced/features/cart/data/models/remove_from_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/update_cart_request.dart';
import 'package:bloc_advanced/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, CartResponse>> getCart() {
    return remoteDataSource.getCart();
  }

  @override
  Future<Either<AppException, CartResponse>> addItem(AddToCartRequest request) {
    return remoteDataSource.addItem(request);
  }

  @override
  Future<Either<AppException, CartResponse>> updateQuantity(
    UpdateCartRequest request,
  ) {
    return remoteDataSource.updateQuantity(request);
  }

  @override
  Future<Either<AppException, CartResponse>> removeItem(
    RemoveFromCartRequest request,
  ) {
    return remoteDataSource.removeItem(request);
  }

  @override
  Future<Either<AppException, CartResponse>> clearCart() {
    return remoteDataSource.clearCart();
  }
}
