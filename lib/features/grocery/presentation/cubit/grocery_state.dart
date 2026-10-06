part of 'grocery_cubit.dart';

class GroceryState extends Equatable {
  final List<ProductModel> allItems;
  final List<ProductModel> items;
  final List<CategoryModel> categories;
  final String selectedCategory;
  final String? selectedCategoryId;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;
  final String errorMessage;

  const GroceryState({
    this.allItems = const [],
    this.items = const [],
    this.categories = const [],
    this.selectedCategory = 'All',
    this.selectedCategoryId,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });

  GroceryState copyWith({
    List<ProductModel>? allItems,
    List<ProductModel>? items,
    List<CategoryModel>? categories,
    String? selectedCategory,
    String? selectedCategoryId,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GroceryState(
      allItems: allItems ?? this.allItems,
      items: items ?? this.items,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    allItems,
    items,
    categories,
    selectedCategory,
    selectedCategoryId,
    isLoading,
    isLoadingMore,
    currentPage,
    totalPages,
    hasReachedMax,
    errorMessage,
  ];
}
