import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/wishlist/data/data_source/wishlist_remote_data_source.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_request.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_response.dart';
import 'package:bloc_advanced/features/wishlist/data/models/wishlist_response.dart';
import 'package:bloc_advanced/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, WishlistResponse>> getWishlist() {
    return remoteDataSource.getWishlist();
  }

  @override
  Future<Either<AppException, ToggleWishlistResponse>> toggleWishlist(
    ToggleWishlistRequest request,
  ) {
    return remoteDataSource.toggleWishlist(request);
  }
}
