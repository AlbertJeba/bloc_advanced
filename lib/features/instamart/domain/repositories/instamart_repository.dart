import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/features/instamart/data/models/instamart_model.dart';
import 'package:bloc_advanced/features/instamart/data/models/category_model.dart';

abstract class InstamartRepository {
  Future<Either<AppException, List<InstamartModel>>> getInstamartItems();
  Future<Either<AppException, List<CategoryModel>>> getCategories();
}
