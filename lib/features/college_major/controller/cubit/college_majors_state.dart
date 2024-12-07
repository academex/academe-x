import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/college_major/domain/entities/college_entity.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum MajorsStatus { initial, loading, success, failure }

class CollegeMajorsState extends Equatable {
  final MajorsStatus status;
  final List<MajorEntity> majors;
  final String? selectedCollege;
  final String? errorMessage;
  final String? collegeAndMajor;
  final bool isCached;
  final bool isLoadingForCollege;
  final bool isExpanded;
  final int? selectedMajorIndex;
  final List<CollegeEntity>? colleges;


  const CollegeMajorsState({
    this.status = MajorsStatus.initial,
    this.majors = const [],
    this.colleges = const [],
    this.selectedCollege,
    this.errorMessage,
    this.collegeAndMajor,
    this.selectedMajorIndex,
    this.isCached = false,
    this.isLoadingForCollege = false,
    this.isExpanded = false,
  });

  CollegeMajorsState copyWith({
    MajorsStatus? status,
    List<MajorEntity>? majors,
    List<CollegeEntity>? colleges,

    String? selectedCollege,
    String? collegeAndMajor,
    String? errorMessage,
    bool? isCached,
    int?selectedMajorIndex,
    bool? isExpanded,
    bool? isLoadingForCollege,
  }) {
    return CollegeMajorsState(
      status: status ?? this.status,
      majors: majors ?? this.majors,
      colleges: colleges ?? this.colleges,
      selectedCollege: selectedCollege ?? this.selectedCollege,
      errorMessage: errorMessage ?? this.errorMessage,
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
    selectedCollege,
    errorMessage,
    collegeAndMajor,
    isCached,
    isExpanded,
    isLoadingForCollege,
  ];
}