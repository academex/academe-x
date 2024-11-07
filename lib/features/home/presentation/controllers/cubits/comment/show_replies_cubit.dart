import 'package:academe_x/features/home/presentation/controllers/states/comment/show_replyes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowRepliesCubit extends Cubit<ShowReplyesState>{
  ShowRepliesCubit(super.initialState);
  
  change({required int postIndex,required bool visibility}){
    emit(ShowReplyesState(show: visibility, index: postIndex));
  }
}
