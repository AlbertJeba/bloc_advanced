import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_request.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_response.dart';
import 'package:bloc_advanced/features/wishlist/data/models/wishlist_response.dart';
import 'package:bloc_advanced/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistUseCase {
  final WishlistRepository repository;

  WishlistUseCase(this.repository);

  Future<Either<AppException, WishlistResponse>> getWishlist() {
    return repository.getWishlist();
  }

  Future<Either<AppException, ToggleWishlistResponse>> toggleWishlist(
    ToggleWishlistRequest request,
  ) {
    return repository.toggleWishlist(request);
  }
}
