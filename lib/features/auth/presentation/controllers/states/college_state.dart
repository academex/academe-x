import 'package:equatable/equatable.dart';

enum SelectionType {
  semester,
  major
}

class CollegeData {
  final String icon;
  final List<String> majors;
  const CollegeData({required this.icon, required this.majors});
}

class CollegeState extends Equatable {
  final bool isExpanded;
  final String? selectedCollege;
  final int? selectedMajorIndex;
  final int? selectedSemesterIndex;
  final Map<String, CollegeData> collegesData;
  final SelectionType? selectionType;

  const CollegeState({
    this.isExpanded = false,
    this.selectedCollege,
    this.selectedMajorIndex,
    this.selectedSemesterIndex,
    this.selectionType,
    this.collegesData = const {
      'كلية الطب': CollegeData(
        icon: '👨‍⚕️',
        majors: ['طب عام', 'طب أسنان'],
      ),
      'كلية الهندسة': CollegeData(
        icon: '👷',
        majors: ['صناعي', 'مدني', 'معماري', 'كهربائي'],
      ),
    },
  });

  CollegeState copyWith({
    bool? isExpanded,
    String? selectedCollege,
    int? selectedMajorIndex,
    int? selectedSemesterIndex,
    SelectionType? selectionType,
    Map<String, CollegeData>? collegesData,
  }) {
    return CollegeState(
      isExpanded: isExpanded ?? this.isExpanded,
      selectedCollege: selectedCollege ?? this.selectedCollege,
      selectedMajorIndex: selectedMajorIndex ?? this.selectedMajorIndex,
      selectedSemesterIndex: selectedSemesterIndex ?? this.selectedSemesterIndex,
      selectionType: selectionType ?? this.selectionType,
      collegesData: collegesData ?? this.collegesData,
    );
  }

  @override
  List<Object?> get props => [isExpanded, selectedCollege,selectedSemesterIndex, selectedMajorIndex, collegesData,selectionType];
}
