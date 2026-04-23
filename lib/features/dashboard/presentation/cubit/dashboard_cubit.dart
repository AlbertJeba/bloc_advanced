import 'package:bloc_advanced/core/network/model/either.dart';
import 'package:bloc_advanced/core/utils/error_logger.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product_request.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product.dart';
import 'package:bloc_advanced/features/dashboard/data/models/products_response.dart';
import 'package:bloc_advanced/features/dashboard/domain/use_case/get_products_usecase.dart';
import 'package:bloc/bloc.dart';
import 'dashboard_state.dart';

/// DashboardCubit - Handles loading and managing product data.
///
/// What this cubit does:
/// 1. Loads the first page of products from API
/// 2. Loads more products when user scrolls to bottom (pagination)
/// 3. Refreshes the list when user pulls down
///
/// Pagination explained:
/// - We don't load all products at once (too slow and uses too much memory)
/// - Instead, we load 10 at a time (called "limit")
/// - "skip" tells the API how many products to skip (so we get the next page)
class DashboardCubit extends Cubit<DashboardState> {
  final GetProductsUseCase _getProductsUseCase;

  /// Constructor - Takes the use case that calls the API
  DashboardCubit(this._getProductsUseCase) : super(const DashboardState());

  /// Loads the first page of products.
  ///
  /// Parameters:
  /// - isRefresh: If true, clears existing products first (for pull-to-refresh)
  Future<void> getProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      // Clear old products and reset to first page
      emit(state.copyWith(
        isLoading: true,
        page: 0,
        products: [],
        hasMore: true,
      ));
    } else {
      emit(state.copyWith(isLoading: true));
    }

    // Call API to get products (skip 0 = start from beginning)
    Either result = await _getProductsUseCase(
      request: ProductRequest(
        limit: state.limit,
        skip: 0,
      ),
    );

    result.fold(
      // Error handler
      (error) {
        ErrorLogger.log('DashboardCubit.getProducts', error.identifier);
        emit(state.copyWith(
          message: error.message,
          isFailure: true,
          isLoading: false,
        ));
      },
      // Success handler
      (response) {
        ProductsResponse productsResponse = response as ProductsResponse;
        List<Product> productList = productsResponse.products ?? [];
        int total = productsResponse.total ?? 0;

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          products: productList,
          page: 1,
          totalProducts: total,
          hasMore: productList.length < total, // More to load if not all loaded
        ));
      },
    );
  }

  /// Loads the next page of products (called when scrolling to bottom).
  ///
  /// How pagination works:
  /// 1. Check if already loading or no more products -> stop
  /// 2. Calculate how many products to skip (already loaded count)
  /// 3. Call API with skip value
  /// 4. Add new products to existing list
  Future<void> loadMoreProducts() async {
    // Don't load more if already loading or no more data
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    // Skip the products we already have
    int skip = state.products?.length ?? 0;

    Either result = await _getProductsUseCase(
      request: ProductRequest(
        limit: state.limit,
        skip: skip,
      ),
    );

    result.fold(
      (error) {
        ErrorLogger.log('DashboardCubit.loadMoreProducts', error.identifier);
        emit(state.copyWith(
          message: error.message,
          isFailure: true,
          isLoadingMore: false,
        ));
      },
      (response) {
        ProductsResponse productsResponse = response as ProductsResponse;
        List<Product> newProducts = productsResponse.products ?? [];

        // Combine old products + new products
        List<Product> allProducts = [...(state.products ?? []), ...newProducts];

        emit(state.copyWith(
          isLoadingMore: false,
          isSuccess: true,
          isFailure: false,
          products: allProducts,
          page: state.page + 1,
          hasMore: allProducts.length < (productsResponse.total ?? 0),
        ));
      },
    );
  }

  /// Clears all state values
  void clearState() {
    emit(state.copyWith(
      message: '',
      isFailure: false,
      isLoading: false,
      isSuccess: false,
    ));
  }

  /// Refreshes the product list (clears and reloads)
  void refresh() {
    getProducts(isRefresh: true);
  }
}
