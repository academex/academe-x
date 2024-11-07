import 'package:academe_x/features/home/presentation/controllers/states/comment/reply_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplyCubit extends Cubit<ReplySatae> {
  ReplyCubit(super.initialState);

  reply({required String commenter}){
    emit(state.copyWith(commenter: commenter));
  }
}