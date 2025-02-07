import 'package:academe_x/features/home/domain/entities/post/poll/poll_option.dart';

class PollOptionModel extends PollOption{

  PollOptionModel({
    required super.content,
    required super.count,
    required super.id,
    required super.isVoted,
    required super.order,
  });

  // Factory method to create a PollOption object from a JSON map
  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      id: json['id'],
      content: json['content'],
      order: json['order'],
      count: json['count'],
      isVoted: json['isVoted'],
    );
  }

  // Method to convert a PollOption object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'order': order,
      'count': count,
      'isVoted': isVoted,
    };
  }
}