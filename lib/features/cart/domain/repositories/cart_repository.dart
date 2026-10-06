import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/cart_response.dart';
import 'package:bloc_advanced/features/cart/data/models/remove_from_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/update_cart_request.dart';

abstract class CartRepository {
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
