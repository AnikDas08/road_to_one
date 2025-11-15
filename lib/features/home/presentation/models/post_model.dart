import 'comment_model.dart';

class PostModel {
  final String id;
  final String userName;
  final String userImage;
  final String time;
  final String caption;
  final String hashtag;
  final List<String> images;
  final String likes;
  bool isLiked;
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.time,
    required this.caption,
    required this.hashtag,
    required this.images,
    required this.likes,
    required this.isLiked,
    required this.comments,
  });

  // From JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      time: json['time'] ?? '',
      caption: json['caption'] ?? '',
      hashtag: json['hashtag'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      likes: json['likes'] ?? '0',
      isLiked: json['isLiked'] ?? false,
      comments: json['comments'] != null
          ? (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList()
          : [],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userImage': userImage,
      'time': time,
      'caption': caption,
      'hashtag': hashtag,
      'images': images,
      'likes': likes,
      'isLiked': isLiked,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  // Copy with
  PostModel copyWith({
    String? id,
    String? userName,
    String? userImage,
    String? time,
    String? caption,
    String? hashtag,
    List<String>? images,
    String? likes,
    bool? isLiked,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      time: time ?? this.time,
      caption: caption ?? this.caption,
      hashtag: hashtag ?? this.hashtag,
      images: images ?? this.images,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      comments: comments ?? this.comments,
    );
  }
}