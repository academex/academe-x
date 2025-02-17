import 'package:academe_x/features/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'college_state.dart';

class AuthState extends Equatable {
  // Common fields for auth
  final bool isLoading;
  final bool isLoadingForCollege;
  final bool isLoadingForMajors;
  final bool isRememberMe;
  final List<String>? errorMessage;
  final List<CollegeEntity>? colleges;
  List<MajorEntity>? majors;
  final bool isAuthenticated;

  // College-related fields
  final bool isExpanded;
  final String? selectedCollege;
  final int? selectedMajorIndex;
  late final int? selectedTagId;
  late  int? selectedSemesterIndex;
  final String? collegeAndMajor;
  late Map<String, CollegeData>? collegesData;
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

   AuthState({
    this.isLoading = false,
    this.isLoadingForCollege = false,
    this.isLoadingForMajors = false,
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
    this.selectedTagId,

    // Map<String, CollegeData>? collegesData,
    // Signup fields
    this.selectedGenderIndex,
    this.firstNameController,
    this.lastNameController,
    this.userNameController,
    this.emailController,
    this.phoneController,
     Map<String, CollegeData>? collegesData,

     this.passwordController,
    this.confirmPasswordController,
    this.showEducationInfo = false,
    this.formKey,

    this.isPasswordVisible = false,

    this.colleges,
    this.majors,

  }): collegesData = collegesData ?? const {
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
    bool? isLoadingForCollege,
    bool? isLoadingForMajors,
    bool? isRememberMe,
    List<String>? errorMessage,
    List<CollegeEntity>? colleges,
    List<MajorEntity>? majors,
    bool? isAuthenticated,
    // College fields
    bool? isExpanded,
    String? selectedCollege,
    int? selectedMajorIndex,
    int? selectedSemesterIndex,
    int? selectedTagId,
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
      isLoadingForCollege: isLoadingForCollege ?? this.isLoadingForCollege,
      isLoadingForMajors: isLoadingForMajors ?? this.isLoadingForMajors,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      errorMessage: errorMessage,
      colleges: colleges ?? this.colleges,
      selectedTagId: selectedTagId ?? this.selectedTagId,
      majors: majors ?? this.majors,
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
    isLoadingForCollege,
    isLoadingForMajors,
    isRememberMe,
    errorMessage,
    isAuthenticated,
    // College props
    isExpanded,
    selectedCollege,
    selectedTagId,
    selectedMajorIndex,
    selectedSemesterIndex,
    collegeAndMajor,
    selectionType,
    colleges,
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