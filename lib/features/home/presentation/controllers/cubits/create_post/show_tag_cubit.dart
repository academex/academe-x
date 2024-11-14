import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTagCubit extends Cubit<bool> {
  ShowTagCubit(super.initialState);
  changeState() {
    emit(!state);
  }
}
