import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'college_state.dart';

class AuthState extends Equatable {
  // Common fields for auth
  final bool isLoading;
  final bool isRememberMe;
  final List<String>? errorMessage;
  final bool isAuthenticated;

  // College-related fields
  final bool isExpanded;
  final String? selectedCollege;
  final int? selectedMajorIndex;
  final int? selectedSemesterIndex;
  final String? collegeAndMajor;
  final Map<String, CollegeData> collegesData;
  final SelectionType? selectionType;

  // Signup fields
  final int? selectedGenderIndex;
  final TextEditingController? firstNameController;
  final TextEditingController? lastNameController;
  final TextEditingController? userNameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final bool? showEducationInfo;
  final GlobalKey<FormState>? formKey;
  final bool isPasswordVisible;

  const AuthState({
    this.isLoading = false,
    this.isRememberMe = false,
    this.errorMessage,
    this.isAuthenticated = false,
    // College fields
    this.isExpanded = false,
    this.selectedCollege,
    this.selectedMajorIndex,
    this.selectedSemesterIndex,
    this.collegeAndMajor,
    this.selectionType,
    Map<String, CollegeData>? collegesData,
    // Signup fields
    this.selectedGenderIndex,
    this.firstNameController,
    this.lastNameController,
    this.userNameController,
    this.emailController,
    this.phoneController,
    this.passwordController,
    this.confirmPasswordController,
    this.showEducationInfo = false,
    this.formKey,
    this.isPasswordVisible = false,
  }) : collegesData = collegesData ?? const {
    'كلية الطب': CollegeData(
      icon: '👨‍⚕️',
      majors: ['طب عام', 'طب أسنان',],
    ),
    'كلية الهندسة': CollegeData(
      icon: '👷',
      majors: ['صناعي', 'مدني', 'معماري', 'كهربائي'],
    ),
    // ... other colleges
  };

  factory AuthState.initial() {
    return AuthState(
      formKey: GlobalKey<FormState>(),
      isLoading: false,
      isRememberMe: false,
      errorMessage: null,
    );
  }

  factory AuthState.initialSignup() {
    return AuthState(
      isLoading: false,
      selectedGenderIndex: 0,
      firstNameController: TextEditingController(),
      lastNameController: TextEditingController(),
      userNameController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
      formKey: GlobalKey<FormState>(),
      showEducationInfo: false,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isRememberMe,
    List<String>? errorMessage,
    bool? isAuthenticated,
    // College fields
    bool? isExpanded,
    String? selectedCollege,
    int? selectedMajorIndex,
    int? selectedSemesterIndex,
    String? collegeAndMajor,
    SelectionType? selectionType,
    Map<String, CollegeData>? collegesData,
    // Signup fields
    int? selectedGenderIndex,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? userNameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    bool? showEducationInfo,
    GlobalKey<FormState>? formKey,
    bool? isPasswordVisible,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      errorMessage: errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      // College fields
      isExpanded: isExpanded ?? this.isExpanded,
      selectedCollege: selectedCollege ?? this.selectedCollege,
      selectedMajorIndex: selectedMajorIndex ?? this.selectedMajorIndex,
      selectedSemesterIndex: selectedSemesterIndex ?? this.selectedSemesterIndex,
      collegeAndMajor: collegeAndMajor ?? this.collegeAndMajor,
      selectionType: selectionType ?? this.selectionType,
      collegesData: collegesData ?? this.collegesData,
      // Signup fields
      selectedGenderIndex: selectedGenderIndex ?? this.selectedGenderIndex,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      userNameController: userNameController ?? this.userNameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      showEducationInfo: showEducationInfo ?? this.showEducationInfo,
      formKey: formKey ?? this.formKey,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isRememberMe,
    errorMessage,
    isAuthenticated,
    // College props
    isExpanded,
    selectedCollege,
    selectedMajorIndex,
    selectedSemesterIndex,
    collegeAndMajor,
    selectionType,
    collegesData,
    // Signup props
    selectedGenderIndex,
    firstNameController?.text,
    lastNameController?.text,
    userNameController?.text,
    emailController?.text,
    phoneController?.text,
    passwordController?.text,
    confirmPasswordController?.text,
    showEducationInfo,
    formKey,
    isPasswordVisible,
  ];
}


// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
//
// class AuthState extends Equatable {
//   // Common fields
//   final bool isLoading;
//    bool isRememberMe;
//   final String? errorMessage;
//   final bool isAuthenticated;
//   final int? selectedGenderIndex;
//
//
//
//
//   // Signup specific fields
//   TextEditingController? firstNameController=TextEditingController();
//   TextEditingController? lastNameController=TextEditingController();
//   TextEditingController? userNameController=TextEditingController();
//   TextEditingController? emailController=TextEditingController();
//   TextEditingController? phoneController=TextEditingController();
//   TextEditingController? passwordController=TextEditingController();
//   TextEditingController? confirmPasswordController=TextEditingController();
//   final bool? showEducationInfo;
//   final GlobalKey<FormState>? formKey;
//
//   // UI state
//   final bool isPasswordVisible;
//
//    AuthState({
//     required this.isLoading,
//      this.isRememberMe=false,
//     this.errorMessage,
//     this.isAuthenticated = false,
//     this.selectedGenderIndex,
//     this.firstNameController,
//     this.lastNameController,
//     this.userNameController,
//     this.emailController,
//     this.phoneController,
//     this.passwordController,
//     this.confirmPasswordController,
//     this.showEducationInfo = false,
//     this.formKey,
//     this.isPasswordVisible = false,
//   });
//
//   // Initial state factory constructor
//   factory AuthState.initial() {
//     return AuthState(
//       isLoading: false,
//       isRememberMe: false,
//
//       errorMessage: null,
//       formKey: GlobalKey<FormState>(),
//     );
//   }
//
//   // Initial state factory constructor for signup
//   factory AuthState.initialSignup() {
//     return AuthState(
//       isLoading: false,
//       selectedGenderIndex: 0,
//       firstNameController: TextEditingController(),
//       lastNameController: TextEditingController(),
//       userNameController: TextEditingController(),
//       emailController: TextEditingController(),
//       phoneController: TextEditingController(),
//       passwordController: TextEditingController(),
//       confirmPasswordController: TextEditingController(),
//       formKey: GlobalKey<FormState>(),
//       showEducationInfo: false,
//     );
//   }
//
//   AuthState copyWith({
//      bool isLoading=false,
//     bool isRememberMe=false,
//     String? errorMessage,
//     bool? isAuthenticated,
//     int? selectedGenderIndex,
//     TextEditingController? firstNameController,
//     TextEditingController? lastNameController,
//     TextEditingController? userNameController,
//     TextEditingController? emailController,
//     TextEditingController? phoneController,
//     TextEditingController? passwordController,
//     TextEditingController? confirmPasswordController,
//     bool? showEducationInfo,
//     GlobalKey<FormState>? formKey,
//     bool? isPasswordVisible,
//   }) {
//     return AuthState(
//       isRememberMe: isRememberMe ,
//       isLoading: isLoading ,
//       errorMessage: errorMessage,
//       selectedGenderIndex: selectedGenderIndex ?? this.selectedGenderIndex,
//       isAuthenticated: isAuthenticated ?? this.isAuthenticated,
//       firstNameController: firstNameController ?? this.firstNameController,
//       lastNameController: lastNameController ?? this.lastNameController,
//       userNameController: userNameController??this.userNameController,
//       emailController: emailController??this.emailController,
//       phoneController: phoneController ?? this.phoneController,
//       passwordController: passwordController ?? this.passwordController,
//       confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
//       showEducationInfo: showEducationInfo ?? this.showEducationInfo,
//       formKey: formKey ?? this.formKey,
//       isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     isLoading,
//     isRememberMe,
//     errorMessage,
//     selectedGenderIndex,
//     isAuthenticated,
//     firstNameController?.text,
//     lastNameController?.text,
//     userNameController?.text,
//     emailController?.text,
//     phoneController?.text,
//     passwordController?.text,
//     confirmPasswordController?.text,
//     showEducationInfo,
//     formKey,
//     isPasswordVisible,
//   ];
// }