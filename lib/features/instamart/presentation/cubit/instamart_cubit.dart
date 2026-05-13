import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/features/instamart/domain/use_case/get_instamart_items_usecase.dart';
import 'package:bloc_advanced/features/instamart/data/models/instamart_model.dart';
import 'package:bloc_advanced/features/instamart/data/models/category_model.dart';

part 'instamart_state.dart';

class InstamartCubit extends Cubit<InstamartState> {
  final GetInstamartItemsUseCase _getInstamartItemsUseCase;

  InstamartCubit(this._getInstamartItemsUseCase) : super(const InstamartState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    final categoriesResult = await _getInstamartItemsUseCase.getCategories();
    final itemsResult = await _getInstamartItemsUseCase.execute();

    categoriesResult.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (categories) {
        // Here we keep the full CategoryModel objects
        final allCategories = categories; 
        
        itemsResult.fold(
          (error) => emit(state.copyWith(isLoading: false, errorMessage: error.message)),
          (items) => emit(state.copyWith(
            isLoading: false,
            categories: allCategories,
            allItems: items,
            items: items,
          )),
        );
      },
    );
  }

  void selectCategory(String categoryName) {
    if (state.selectedCategory == categoryName) return;
    
    if (categoryName == 'All') {
      emit(state.copyWith(
        selectedCategory: categoryName,
        items: state.allItems,
      ));
    } else {
      // Logic split-up: Use the category name (or slug) to filter from the full list
      final category = state.categories.firstWhere((e) => e.name == categoryName);
      final filteredItems = state.allItems.where((item) {
        final itemCat = item.category?.toLowerCase() ?? '';
        final targetCat = category.slug.toLowerCase();
        return itemCat == targetCat;
      }).toList();
      
      emit(state.copyWith(
        selectedCategory: categoryName,
        items: filteredItems,
      ));
    }
  }
}
