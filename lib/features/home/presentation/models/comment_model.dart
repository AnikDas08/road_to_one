class CommentModel {
  final String userName;
  final String comment;

  CommentModel({
    required this.userName,
    required this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userName: json['userName'] ?? '',
      comment: json['comment'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'comment': comment,
    };
  }

}