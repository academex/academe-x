import 'package:bloc/bloc.dart';

import '../../../../../../core/constants/navigation_constants.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(NavigationIndex.community);



  void changePage(int index) => emit(index);
}
