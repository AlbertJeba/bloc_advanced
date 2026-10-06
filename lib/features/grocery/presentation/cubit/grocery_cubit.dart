import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/core/constants/constant.dart';
import 'package:bloc_advanced/features/grocery/domain/use_case/get_grocery_items_use_case.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_request.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_model.dart';
import 'package:bloc_advanced/features/grocery/data/models/category_model.dart';

part 'grocery_state.dart';

class GroceryCubit extends Cubit<GroceryState> {
  final GetGroceryItemsUseCase _getGroceryItemsUseCase;

  GroceryCubit(this._getGroceryItemsUseCase) : super(const GroceryState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final categoriesResult = await _getGroceryItemsUseCase.getCategories();
    final itemsResult = await _getGroceryItemsUseCase.execute(
      request: const ProductRequest(page: 1, limit: pageLimit),
    );

    categoriesResult.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (categoryResponse) {
        final allCategories = categoryResponse.data?.items ?? [];

        itemsResult.fold(
          (error) => emit(
            state.copyWith(isLoading: false, errorMessage: error.message),
          ),
          (productResponse) {
            final items = productResponse.data?.items ?? [];
            final totalPages = productResponse.data?.pageMeta?.totalPages ?? 1;

            emit(
              state.copyWith(
                isLoading: false,
                categories: allCategories,
                allItems: items,
                items: items,
                selectedCategory: 'All',
                selectedCategoryId: null,
                currentPage: 1,
                totalPages: totalPages,
                hasReachedMax: 1 >= totalPages,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> selectCategory(String categoryName) async {
    if (state.selectedCategory == categoryName && !state.isLoading) return;

    String? targetCategoryId;
    if (categoryName != 'All') {
      final category = state.categories
          .where((e) => e.name == categoryName)
          .firstOrNull;
      targetCategoryId = category?.id;
    }

    emit(
      state.copyWith(
        isLoading: true,
        selectedCategory: categoryName,
        selectedCategoryId: targetCategoryId,
        items: [],
        currentPage: 1,
        hasReachedMax: false,
        errorMessage: '',
      ),
    );

    final result = await _getGroceryItemsUseCase.execute(
      request: ProductRequest(
        page: 1,
        limit: pageLimit,
        categoryId: targetCategoryId,
      ),
    );

    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (productResponse) {
        final items = productResponse.data?.items ?? [];
        final totalPages = productResponse.data?.pageMeta?.totalPages ?? 1;

        emit(
          state.copyWith(
            isLoading: false,
            items: items,
            allItems: items,
            currentPage: 1,
            totalPages: totalPages,
            hasReachedMax: 1 >= totalPages,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || state.hasReachedMax) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;
    final result = await _getGroceryItemsUseCase.execute(
      request: ProductRequest(
        page: nextPage,
        limit: pageLimit,
        categoryId: state.selectedCategoryId,
      ),
    );

    result.fold(
      (error) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: error.message),
      ),
      (productResponse) {
        final newItems = productResponse.data?.items ?? [];
        final totalPages =
            productResponse.data?.pageMeta?.totalPages ?? state.totalPages;
        final updatedItems = [...state.items, ...newItems];
        final hasReachedMax = nextPage >= totalPages || newItems.isEmpty;

        emit(
          state.copyWith(
            isLoadingMore: false,
            items: updatedItems,
            allItems: updatedItems,
            currentPage: nextPage,
            totalPages: totalPages,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }
}
