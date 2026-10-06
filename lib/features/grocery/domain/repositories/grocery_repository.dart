import 'package:bloc_advanced/core/exceptions/http_exception.dart';
import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/features/grocery/data/models/category_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_response.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_response.dart';

abstract class GroceryRepository {
  Future<Either<AppException, ProductResponse>> getGroceryItems({
    ProductRequest? request,
  });

  Future<Either<AppException, CategoryResponse>> getCategories();

  Future<Either<AppException, ProductDetailResponse>> getProductDetail(
    ProductDetailRequest request,
  );
}
