import 'package:bloc/bloc.dart';

import 'package:academe_x/lib.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(NavigationIndex.community);



  void changePage(int index) => emit(index);
}
