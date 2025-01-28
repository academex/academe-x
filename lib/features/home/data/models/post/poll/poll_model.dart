import 'package:academe_x/features/home/data/models/post/poll/poll_option_model.dart';
import 'package:academe_x/features/home/domain/entities/post/poll/poll.dart';

class PollModel extends Poll{
 

  PollModel({
    required super.id,
    required super.pollOptions,
    required super.question,
    required super.votedOptionId,
  });

  // Factory method to create a Poll object from a JSON map
  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'],
      question: json['question'],
      pollOptions: json['pollOptions'] != null
          ? (json['pollOptions'] as List)
          .map((option) => PollOptionModel.fromJson(option))
          .toList()
          : null, // Handle null case
      votedOptionId: json['votedOptionId'],
    );
  }

  // Method to convert a Poll object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'pollOptions': (pollOptions as List<PollOptionModel>?)?.map((option) => option.toJson()).toList(),
      'votedOptionId': votedOptionId,
    };
  }
}

