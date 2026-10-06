import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_request.dart';
import 'package:bloc_advanced/features/wishlist/data/models/toggle_wishlist_response.dart';
import 'package:bloc_advanced/features/wishlist/data/models/wishlist_response.dart';

abstract class WishlistRemoteDataSource {
  Future<Either<AppException, WishlistResponse>> getWishlist();

  Future<Either<AppException, ToggleWishlistResponse>> toggleWishlist(
    ToggleWishlistRequest request,
  );
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final NetworkService networkService;

  WishlistRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, WishlistResponse>> getWishlist() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.wishlist);
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = WishlistResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'WishlistRemoteDataSource.getWishlist',
      );
    }
  }

  @override
  Future<Either<AppException, ToggleWishlistResponse>> toggleWishlist(
    ToggleWishlistRequest request,
  ) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.wishlistToggle,
        data: request.toJson(),
      );
      return eitherType.fold((exception) => Left(exception), (response) {
        final res = ToggleWishlistResponse.fromJson(response.data);
        return Right(res);
      });
    } catch (e) {
      return ErrorLogger.handleException(
        e,
        'WishlistRemoteDataSource.toggleWishlist',
      );
    }
  }
}
