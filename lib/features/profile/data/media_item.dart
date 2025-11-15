enum MediaType { image, video }

class MediaItem {
  final String url;
  final MediaType type;
  final String? duration;
  final String? thumbnail;

  MediaItem({
    required this.url,
    required this.type,
    this.duration,
    this.thumbnail,
  });
}