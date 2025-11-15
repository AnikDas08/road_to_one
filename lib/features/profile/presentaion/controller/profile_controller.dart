import '../../data/media_item.dart';

class ProfileController {
  final String username = "Alex Peterson";
  final String bio = "Job: UI/UX Designer\nDream Job: UI/UX Designer\nInterested in Socializing, Adventure, Travelling";
  final int postsCount = 33;
  final int networkCount = 483;
  final String profileImage = "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop";

  // Real photos from Unsplash and videos from sample sources
  final List<MediaItem> posts = [
    MediaItem(
      url: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      type: MediaType.video,
      duration: "0:15",
      thumbnail: "https://images.unsplash.com/photo-1574717024653-61fd2cf4d44d?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      type: MediaType.video,
      duration: "1:23",
      thumbnail: "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1583468982228-19f19164aee2?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1590086782792-42dd2350140d?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      type: MediaType.video,
      duration: "2:15",
      thumbnail: "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1605296867304-46d5465a13f1?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
  ];

  final List<MediaItem> stories = [
    MediaItem(
      url: "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      type: MediaType.video,
      duration: "0:15",
      thumbnail: "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1574717024653-61fd2cf4d44d?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1583468982228-19f19164aee2?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      type: MediaType.video,
      duration: "0:30",
      thumbnail: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
  ];

  final List<MediaItem> favorites = [
    MediaItem(
      url: "https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
      type: MediaType.video,
      duration: "1:05",
      thumbnail: "https://images.unsplash.com/photo-1605296867304-46d5465a13f1?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1590086782792-42dd2350140d?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
  ];

  final List<MediaItem> saved = [
    MediaItem(
      url: "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
      type: MediaType.video,
      duration: "3:20",
      thumbnail: "https://images.unsplash.com/photo-1574717024653-61fd2cf4d44d?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
      type: MediaType.video,
      duration: "0:58",
      thumbnail: "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=400&fit=crop",
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1583468982228-19f19164aee2?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
    MediaItem(
      url: "https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?w=400&h=400&fit=crop",
      type: MediaType.image,
    ),
  ];
}