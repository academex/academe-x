import 'package:flutter_bloc/flutter_bloc.dart';

// This Cubit will manage the selected category index
class ActionPostCubit extends Cubit<bool> {
  ActionPostCubit() : super(false); // Initial state: first category selected

  // Change the selected index
  void performAction(bool isLike) => emit(isLike);
}
