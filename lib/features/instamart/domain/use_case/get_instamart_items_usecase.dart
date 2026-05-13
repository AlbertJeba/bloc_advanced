import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/features/instamart/data/models/instamart_model.dart';
import 'package:bloc_advanced/features/instamart/data/models/category_model.dart';
import 'package:bloc_advanced/features/instamart/domain/repositories/instamart_repository.dart';

class GetInstamartItemsUseCase {
  final InstamartRepository _repository;

  GetInstamartItemsUseCase(this._repository);

  Future<Either<AppException, List<InstamartModel>>> execute() {
    return _repository.getInstamartItems();
  }

  Future<Either<AppException, List<CategoryModel>>> getCategories() {
    return _repository.getCategories();
  }
}
