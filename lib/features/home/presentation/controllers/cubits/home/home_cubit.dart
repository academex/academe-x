import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<bool> {
  HomeCubit() : super(false);

  // Change the selected index
  void expandText(bool isExpanded) => emit(isExpanded);
}
