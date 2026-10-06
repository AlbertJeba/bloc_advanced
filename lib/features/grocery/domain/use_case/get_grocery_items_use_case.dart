import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/grocery/data/models/category_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_response.dart';
import 'package:bloc_advanced/features/grocery/domain/repositories/grocery_repository.dart';

class GetGroceryItemsUseCase {
  final GroceryRepository repository;

  GetGroceryItemsUseCase(this.repository);

  Future<Either<AppException, ProductResponse>> execute({
    ProductRequest? request,
  }) {
    return repository.getGroceryItems(request: request);
  }

  Future<Either<AppException, CategoryResponse>> getCategories() {
    return repository.getCategories();
  }
}
