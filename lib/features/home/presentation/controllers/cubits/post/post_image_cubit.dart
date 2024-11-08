import 'package:flutter_bloc/flutter_bloc.dart';

// This Cubit will manage the selected category index
class PostImageCubit extends Cubit<int> {
  PostImageCubit() : super(0); // Initial state: first category selected

  // Change the selected index
  void changeImageIndex(int index) => emit(index);
}
