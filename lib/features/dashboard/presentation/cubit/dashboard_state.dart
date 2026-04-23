import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product.dart';

/// DashboardState - Holds all data for the dashboard screen.
///
/// Properties:
/// - page: Current page number (for pagination)
/// - totalProducts: Total number of products available from API
/// - limit: How many products to load at once (default 10)
/// - message: Error or info message
/// - isLoading: True when loading first page
/// - isLoadingMore: True when loading additional pages
/// - isFailure: True when an error occurred
/// - isSuccess: True when data loaded successfully
/// - hasMore: True if there are more products to load
/// - products: List of loaded products
class DashboardState extends Equatable {
  final int page;
  final int totalProducts;
  final int limit;
  final String message;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFailure;
  final bool isSuccess;
  final bool hasMore;
  final List<Product>? products;

  /// Constructor with default values
  const DashboardState({
    this.page = 0,
    this.totalProducts = 0,
    this.limit = 10,
    this.message = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.hasMore = true,
    this.products,
  });

  /// Creates a new state with some values changed.
  ///
  /// Example:
  /// state.copyWith(isLoading: true, products: newList)
  /// This keeps all other values but updates isLoading and products.
  DashboardState copyWith({
    int? page,
    int? totalProducts,
    int? limit,
    String? message,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFailure,
    bool? isSuccess,
    bool? hasMore,
    List<Product>? products,
  }) {
    return DashboardState(
      page: page ?? this.page,
      totalProducts: totalProducts ?? this.totalProducts,
      limit: limit ?? this.limit,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      hasMore: hasMore ?? this.hasMore,
      products: products ?? this.products,
    );
  }

  /// List of properties to compare for equality
  @override
  List<Object?> get props => [
        page,
        totalProducts,
        limit,
        message,
        isLoading,
        isLoadingMore,
        isFailure,
        isSuccess,
        hasMore,
        products,
      ];
}
