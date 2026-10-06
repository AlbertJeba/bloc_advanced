import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/cart_response.dart';
import 'package:bloc_advanced/features/cart/data/models/remove_from_cart_request.dart';
import 'package:bloc_advanced/features/cart/data/models/update_cart_request.dart';
import 'package:bloc_advanced/features/cart/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository _repository;

  CartUseCase(this._repository);

  Future<Either<AppException, CartResponse>> getCart() {
    return _repository.getCart();
  }

  Future<Either<AppException, CartResponse>> addItem(AddToCartRequest request) {
    return _repository.addItem(request);
  }

  Future<Either<AppException, CartResponse>> updateQuantity(
    UpdateCartRequest request,
  ) {
    return _repository.updateQuantity(request);
  }

  Future<Either<AppException, CartResponse>> removeItem(
    RemoveFromCartRequest request,
  ) {
    return _repository.removeItem(request);
  }

  Future<Either<AppException, CartResponse>> clearCart() {
    return _repository.clearCart();
  }
}
