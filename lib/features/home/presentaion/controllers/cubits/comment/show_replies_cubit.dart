import 'package:academe_x/features/home/presentaion/controllers/states/comment/show_replyes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowRepliesCubit extends Cubit<ShowReplyesState>{
  ShowRepliesCubit(super.initialState);
  
  change({required int postIndex}){
    emit(ShowReplyesState(show: !state.show, index: postIndex));
  }
}