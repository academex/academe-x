import 'package:academe_x/features/home/presentation/controllers/states/create_post/poll_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollCubit extends Cubit<PollState> {
  PollCubit(super.initialState);

  onChanges({required int index, required String content}) {
    if (state.optionContent == null) {
      state.copyWith(
          optionContent:[content]
      );
    }else if(state.optionContent!.length < index){
      state.optionContent![index] = content;
      state.copyWith(
          optionContent:state.optionContent,
      );
    }else if(state.optionContent!.length >= index){
      state.optionContent!.add(content);
      state.copyWith(
        optionContent:state.optionContent,
      );
    }

  }
}