import 'package:academe_x/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super( SignupState());

  void initData() {
    emit(state.copyWith(
      showEducationInfo: false,
      confirmPasswordController: TextEditingController(),
      phoneController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      nameController: TextEditingController(),
      formKey:GlobalKey<FormState>(),
    ));
  }

  void showEduInfo(bool showEducationInfo){
    emit(state.copyWith(
      showEducationInfo: !showEducationInfo
    ));
  }




}