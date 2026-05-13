import 'package:bloc_advanced/core/network/network_service.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/constants/endpoints.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/instamart/data/models/instamart_model.dart';
import 'package:bloc_advanced/features/instamart/data/models/category_model.dart';

abstract class InstamartRemoteDataSource {
  Future<Either<AppException, List<InstamartModel>>> getInstamartItems();
  Future<Either<AppException, List<CategoryModel>>> getCategories();
}

class InstamartRemoteDataSourceImpl implements InstamartRemoteDataSource {
  final NetworkService networkService;

  InstamartRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, List<InstamartModel>>> getInstamartItems() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.products, queryParameters: {'limit': 100});
      return eitherType.fold(
        (exception) => Left(exception),
        (response) {
          final List data = response.data['products'];
          final items = data.map((e) => InstamartModel.fromJson(e)).toList();
          return Right(items);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(e, 'InstamartRemoteDataSource.getInstamartItems');
    }
  }

  @override
  Future<Either<AppException, List<CategoryModel>>> getCategories() async {
    try {
      Either eitherType = await networkService.get(ApiEndpoint.categories);
      return eitherType.fold(
        (exception) => Left(exception),
        (response) {
          final List data = response.data;
          final categories = data.map((e) => CategoryModel.fromJson(e)).toList();
          return Right(categories);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(e, 'InstamartRemoteDataSource.getCategories');
    }
  }
}
