import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev_rider/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(
          CategoryState(selectedCategory: 0),
        );

  void categoryChanged({required int selectedCategoryIndex}) {
    emit(
      CategoryState(selectedCategory: selectedCategoryIndex),
    );
  }
}
