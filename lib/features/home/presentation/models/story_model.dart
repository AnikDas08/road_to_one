class StoryModel {
  final String name;
  final String image;
  final bool isOwn;
  final bool hasStory;

  StoryModel({
    required this.name,
    required this.image,
    required this.isOwn,
    required this.hasStory,
  });

  // From JSON
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isOwn: json['isOwn'] ?? false,
      hasStory: json['hasStory'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isOwn': isOwn,
      'hasStory': hasStory,
    };
  }

  // Copy with
  StoryModel copyWith({
    String? name,
    String? image,
    bool? isOwn,
    bool? hasStory,
  }) {
    return StoryModel(
      name: name ?? this.name,
      image: image ?? this.image,
      isOwn: isOwn ?? this.isOwn,
      hasStory: hasStory ?? this.hasStory,
    );
  }
}