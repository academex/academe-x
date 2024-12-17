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
  final String? selectedCollege;
  final String? selectedTag;
  final String? errorMessage;
  final String? collegeAndMajor;
  final bool isCached;
  final bool isVisibileMajors;
  final bool isLoadingForCollege;
  final bool isLoadingMajorSetting;
  final bool isExpanded;
  final int? selectedMajorIndex;
  final List<CollegeEntity>? colleges;


   CollegeMajorsState({
    this.status = MajorsStatus.initial,
    this.majors = const [],
    this.colleges = const [],
    this.selectedCollege,
    this.selectedMajor,
    this.selectedTag,
    this.errorMessage,
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
      errorMessage: errorMessage,
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
    errorMessage,
    selectedMajor,
    collegeAndMajor,
    isCached,
    isExpanded,
    isLoadingForCollege,
  ];
}