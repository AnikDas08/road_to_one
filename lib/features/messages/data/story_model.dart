class Story {
  final String id;
  final String name;
  final String avatar;
  final bool isYourStory;

  Story({
    required this.id,
    required this.name,
    required this.avatar,
    this.isYourStory = false,
  });
}