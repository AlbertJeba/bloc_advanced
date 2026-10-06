import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_request.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_response.dart';
import 'package:bloc_advanced/features/wishlist/data/models/wishlist_response.dart';

abstract class WishlistRepository {
  Future<Either<AppException, WishlistResponse>> getWishlist();

  Future<Either<AppException, ToggleWishlistResponse>> toggleWishlist(
    ToggleWishlistRequest request,
  );
}
