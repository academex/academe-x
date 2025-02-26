import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/college_major/domain/entities/college_entity.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum MajorsStatus { initial, loading, success, failure }

class CollegeMajorsState extends Equatable {
  final MajorsStatus status;
  final List<MajorEntity> majors;
  late  MajorEntity? selectedMajor;
  late  String? selectedCollege;
  late  String? selectedTag;
  final String? errorMessage;
  final String? errorMessageCollege;
  late  String? collegeAndMajor;
  final bool isCached;
  final bool isVisibileMajors;
  final bool isLoadingForCollege;
  final bool isLoadingMajorSetting;
  final bool isExpanded;
  late  int? selectedMajorIndex;
  final List<CollegeEntity>? colleges;


   CollegeMajorsState({
    this.status = MajorsStatus.initial,
    this.majors = const [],
    this.colleges = const [],
    this.selectedCollege,
    this.selectedMajor,
    this.selectedTag,
    this.errorMessage,
    this.errorMessageCollege,
    this.isLoadingMajorSetting=true,
    this.collegeAndMajor,
    this.selectedMajorIndex,
    this.isCached = false,
    this.isVisibileMajors = false,
    this.isLoadingForCollege = false,
    this.isExpanded = false,
  });

  CollegeMajorsState copyWith({
    MajorsStatus? status,
    List<MajorEntity>? majors,
    List<CollegeEntity>? colleges,
    MajorEntity? selectedMajor,
    String? selectedCollege,
    String? selectedTag,
    String? collegeAndMajor,
    String? errorMessage,
    String? errorMessageCollege,
    bool? clearErrorMessageCollege,
    bool? isCached,
    int?selectedMajorIndex,
    bool? isExpanded,
    bool? isVisibileMajors,
    bool? isLoadingForCollege,
    bool? isLoadingMajorSetting,
  }) {
    return CollegeMajorsState(
      status: status ?? this.status,
      majors: majors ?? this.majors,
      colleges: colleges ?? this.colleges,
      selectedMajor: selectedMajor ?? this.selectedMajor,
      selectedCollege: selectedCollege ?? this.selectedCollege,
      isVisibileMajors: isVisibileMajors ?? this.isVisibileMajors,
      selectedTag: selectedTag ?? this.selectedTag,
      errorMessage: errorMessage ?? this.errorMessage,
      errorMessageCollege: clearErrorMessageCollege == true
          ? null
          : errorMessageCollege ?? this.errorMessageCollege,
      isLoadingMajorSetting: isLoadingMajorSetting ?? this.isLoadingMajorSetting,
      selectedMajorIndex: selectedMajorIndex ?? this.selectedMajorIndex,
      collegeAndMajor: collegeAndMajor ?? this.collegeAndMajor,
      isCached: isCached ?? this.isCached,
      isExpanded: isExpanded ?? this.isExpanded,
      isLoadingForCollege: isLoadingForCollege ?? this.isLoadingForCollege,
    );
  }

  @override
  List<Object?> get props => [
    status,
    majors,
    colleges,
    selectedMajorIndex,
    isVisibileMajors,
    selectedCollege,
    isLoadingMajorSetting,
    selectedTag,
    selectedMajor,
    collegeAndMajor,
    isCached,
    isExpanded,
    isLoadingForCollege,
    errorMessage,
    errorMessageCollege,
  ];
}