import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/features/instamart/data/models/instamart_model.dart';
import 'package:bloc_advanced/features/instamart/data/models/category_model.dart';
import 'package:bloc_advanced/features/instamart/domain/repositories/instamart_repository.dart';
import 'package:bloc_advanced/features/instamart/data/datasource/instamart_remote_data_source.dart';

class InstamartRepositoryImpl implements InstamartRepository {
  final InstamartRemoteDataSource _remoteDataSource;

  InstamartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AppException, List<InstamartModel>>> getInstamartItems() async {
    return await _remoteDataSource.getInstamartItems();
  }

  @override
  Future<Either<AppException, List<CategoryModel>>> getCategories() async {
    return await _remoteDataSource.getCategories();
  }
}
