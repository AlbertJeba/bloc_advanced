part of 'instamart_cubit.dart';

class InstamartState extends Equatable {
  final List<InstamartModel> allItems;
  final List<InstamartModel> items;
  final List<CategoryModel> categories;
  final String selectedCategory;
  final bool isLoading;
  final String errorMessage;

  const InstamartState({
    this.allItems = const [],
    this.items = const [],
    this.categories = const [],
    this.selectedCategory = 'All',
    this.isLoading = false,
    this.errorMessage = '',
  });

  InstamartState copyWith({
    List<InstamartModel>? allItems,
    List<InstamartModel>? items,
    List<CategoryModel>? categories,
    String? selectedCategory,
    bool? isLoading,
    String? errorMessage,
  }) {
    return InstamartState(
      allItems: allItems ?? this.allItems,
      items: items ?? this.items,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [allItems, items, categories, selectedCategory, isLoading, errorMessage];
}
