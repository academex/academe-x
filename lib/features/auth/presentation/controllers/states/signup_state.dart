import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SignupState extends Equatable {
  GlobalKey? formKey;
  bool? showEducationInfo;

  // Controllers for text fields
  TextEditingController? nameController ;
  TextEditingController? emailController ;
  TextEditingController? passwordController;
  TextEditingController? phoneController;
  TextEditingController? confirmPasswordController ;

  SignupState(
      {this.showEducationInfo,
      this.formKey,
      this.emailController,
      this.passwordController,
      this.confirmPasswordController,
      this.nameController,
      this.phoneController});

  SignupState copyWith({
    GlobalKey? formKey,
    bool? showEducationInfo,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? phoneController,
    TextEditingController? confirmPasswordController,
  }) {
    return SignupState(
      showEducationInfo: showEducationInfo ?? this.showEducationInfo,
      confirmPasswordController:confirmPasswordController ?? this.confirmPasswordController,
      nameController:nameController ?? this.nameController,
      passwordController:passwordController ?? this.passwordController,
      emailController:emailController ?? this.emailController,
      formKey:formKey ?? this.formKey,
      // showEducationInfo: this.showEducationInfo,
      phoneController:phoneController ?? this.phoneController,
    );
  }

  @override
  List<Object?> get props => [
        showEducationInfo,
        formKey,
        emailController,
        passwordController,
        confirmPasswordController,
        nameController,
        phoneController
      ];
}
