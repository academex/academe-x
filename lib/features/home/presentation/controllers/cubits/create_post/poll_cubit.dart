import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/poll_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PollCubit extends Cubit<PollState> {
  PollCubit(super.initialState);

  deleteOptionAt(int index) {
    state.optionContent!.removeAt(index);
    emit(state.copyWith(
      optionContent: state.optionContent!,
    ));
  }

  addChoice() {
    state.optionContent!.add('');
    emit(state.copyWith(
      optionContent: state.optionContent,
    ));
  }

  changeEndPoll({TimeOfDay? time, DateTime? date}) {
    DateTime dateTime;
    if (time == null) {
      dateTime = DateTime.utc(date!.year, date.month, date.day,
          state.endPoll.hour, state.endPoll.minute);
    } else {
      dateTime = DateTime.utc(state.endPoll.year, state.endPoll.month,
          state.endPoll.day, time.hour, time.minute);
    }
    Logger().d('${dateTime.year}/${dateTime.month}/${dateTime.day}  ${dateTime.hour}:${dateTime.minute}',);
    emit(state.copyWith(
      endPoll: dateTime,
    ));
  }

  clear() {
    state.deleteDateTime();
    emit(state.copyWith(
      optionContent: ['', ''],
      question: '',
    ));
  }

  validate() {
    if (state.question != null && state.question!.isNotEmpty) {
      if (state.optionContent == null) {
        throw ValidationException(
            messages: ['يرجى اضافة 2 من الاجابات للتصويت على الأقل']);
      } else if (state.optionContent!.length < 2) {
        throw ValidationException(
            messages: ['يرجى اضافة 2 من الاجابات للتصويت على الأقل']);
      }else if (state.optionContent!.length == 2) {
        if(state.optionContent![0] == '') {
          throw ValidationException(
              messages: ['يرجى كتابة اجابة أطول في الخيار الأول']);
        }
        else if(state.optionContent![1] == '') {
          throw ValidationException(
              messages: ['يرجى كتابة اجابة أطول في الخيار الثاني']);
        }
      }
    }
  }

  addQuestionTitle(String title) {
    emit(state.copyWith(question: title));
  }

  onChanges({required int index, required String content}) {
    Logger().d('$content : $index : ${state.optionContent?.length}');
    if (state.optionContent == null) {
      emit(state.copyWith(optionContent: [content]));
    } else if (state.optionContent!.length > index) {
      state.optionContent![index] = content;
      emit(state.copyWith(
        optionContent: state.optionContent,
      ));
    } else if (state.optionContent!.length <= index) {
      state.optionContent!.add(content);
      emit(state.copyWith(
        optionContent:state.optionContent,
      ));
    }
    Logger().d(state.optionContent.toString());
  }

// bool isEmpty() {
//   if(state.optionContent != null &&
//       state.optionContent!.isNotEmpty){
//     if(state.optionContent!.length == 2){
//       return state.optionContent!.first == '' &&
//           state.optionContent![1] == '';
//     }else if(state.optionContent!.length > 2){
//       return false;
//     }
//
//
//   }
//   return true;
// }
}