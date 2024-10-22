import 'package:flutter_bloc/flutter_bloc.dart';

// This Cubit will manage the selected category index
class CategoryCubit extends Cubit<int> {
  CategoryCubit() : super(0); // Initial state: first category selected

  // Change the selected index
  void selectCategory(int index) => emit(index);
}
