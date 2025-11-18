import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../data/media_item.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final ProfileController controller = ProfileController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.upcolor,
      appBar: AppBar(
        backgroundColor: AppColors.upcolor,
        title: CommonText(
          text: "Profile",
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white50,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.add,size: 30,color: AppColors.white200,),
          onPressed: () {
            Get.toNamed(AppRoutes.createPost);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings,size: 30,color: AppColors.white200,),
            onPressed: () {
              Get.toNamed(AppRoutes.settingScreen);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Picture and Stats
                Row(
                  children: [
                    // Profile Picture
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(controller.profileImage),
                      backgroundColor: Colors.grey[800],
                    ),
                    SizedBox(width: 30.h),
                    // Stats
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn(controller.postsCount.toString(), 'Posts'),
                          GestureDetector( onTap: (){
                            Get.toNamed(AppRoutes.networkScreen);
                          },
                              child:
                          _buildStatColumn(controller.networkCount.toString(), 'Network')
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonText(
                    text: controller.username,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white50,
                  ),
                ),
                SizedBox(height: 14.h),
                // Edit Profile Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.editProfileScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CommonText(
                        text: "Edit Profile",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white50,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Bio
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonText(
                    text: controller.bio,
                    fontSize: 16.sp,
                    maxLines: 6,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white50,
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[800]!, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 1,
              tabs: const [
                Tab(icon: Icon(Icons.grid_on, size: 24)),
                Tab(icon: Icon(Icons.video_library, size: 24)),
                Tab(icon: Icon(Icons.favorite_border, size: 24)),
                Tab(icon: Icon(Icons.bookmark_border, size: 24)),
              ],
            ),
          ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGridView(controller.posts),
                _buildGridView(controller.stories),
                _buildGridView(controller.favorites),
                _buildGridView(controller.saved),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        CommonText(
          text: count,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white50,
        ),
        SizedBox(height: 2),
        CommonText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white50,
        ),
      ],
    );
  }

  Widget _buildGridView(List<MediaItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            _showMediaViewer(context, items, index);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Thumbnail
              Image.network(
                item.type == MediaType.video
                    ? (item.thumbnail ?? item.url)
                    : item.url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: Icon(
                      item.type == MediaType.video ? Icons.videocam : Icons.image,
                      size: 50,
                      color: Colors.grey[700],
                    ),
                  );
                },
              ),
              // Video indicator
              if (item.type == MediaType.video)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.videocam,
                    color: Colors.white,
                    size: 20,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              // Video duration
              if (item.type == MediaType.video && item.duration != null)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.duration!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showMediaViewer(BuildContext context, List<MediaItem> items, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaViewerScreen(items: items, initialIndex: initialIndex),
      ),
    );
  }
}

// Full screen media viewer
class MediaViewerScreen extends StatefulWidget {
  final List<MediaItem> items;
  final int initialIndex;

  const MediaViewerScreen({
    Key? key,
    required this.items,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<MediaViewerScreen> createState() => _MediaViewerScreenState();
}

class _MediaViewerScreenState extends State<MediaViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${_currentIndex + 1} / ${widget.items.length}'),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical, // THIS IS THE KEY CHANGE - Makes it scroll vertically
        itemCount: widget.items.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Center(
            child: item.type == MediaType.video
                ? VideoPlayerWidget(videoUrl: item.url)
                : _buildImageViewer(item),
          );
        },
      ),
    );
  }

  Widget _buildImageViewer(MediaItem item) {
    return InteractiveViewer(
      child: Image.network(
        item.url,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 100, color: Colors.grey[700]),
                const SizedBox(height: 16),
                Text(
                  'Failed to load image',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Video Player Widget with actual playback
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _showControls = true;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });

      // Auto play video
      _controller.play();
      _controller.setLooping(true);
      _controller.setVolume(_volume);
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      print('Video initialization error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      if (_volume > 0) {
        _volume = 0.0;
      } else {
        _volume = 1.0;
      }
      _controller.setVolume(_volume);
    });
  }

  void _skipBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _skipForward() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.duration;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(newPosition < duration ? newPosition : duration);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'Failed to load video',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your internet connection',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: _toggleControls,
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video Player
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),

            // Video Controls Overlay
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.black38,
                child: Column(
                  children: [
                    // Top Controls
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Mute/Unmute Button
                          IconButton(
                            icon: Icon(
                              _volume > 0 ? Icons.volume_up : Icons.volume_off,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: _toggleMute,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Center Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Skip Backward
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon: const Icon(
                              Icons.replay_10,
                              color: Colors.white,
                            ),
                            onPressed: _skipBackward,
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Play/Pause Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 64,
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Skip Forward
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon: const Icon(
                              Icons.forward_10,
                              color: Colors.white,
                            ),
                            onPressed: _skipForward,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Bottom Controls - Progress Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          // Progress Bar
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            colors: const VideoProgressColors(
                              playedColor: Colors.red,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.white24,
                            ),
                          ),

                          // Time Display and Speed Control
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Current Time / Total Time
                              ValueListenableBuilder(
                                valueListenable: _controller,
                                builder: (context, value, child) {
                                  return Text(
                                    '${_formatDuration(value.position)} / ${_formatDuration(_controller.value.duration)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),

                              // Playback Speed
                              PopupMenuButton<double>(
                                icon: const Icon(
                                  Icons.speed,
                                  color: Colors.white,
                                ),
                                color: Colors.grey[900],
                                onSelected: (speed) {
                                  _controller.setPlaybackSpeed(speed);
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 0.5,
                                    child: Text('0.5x', style: TextStyle(color: Colors.white)),
                                  ),
                                  const PopupMenuItem(
                                    value: 0.75,
                                    child: Text('0.75x', style: TextStyle(color: Colors.white)),
                                  ),
                                  const PopupMenuItem(
                                    value: 1.0,
                                    child: Text('Normal', style: TextStyle(color: Colors.white)),
                                  ),
                                  const PopupMenuItem(
                                    value: 1.25,
                                    child: Text('1.25x', style: TextStyle(color: Colors.white)),
                                  ),
                                  const PopupMenuItem(
                                    value: 1.5,
                                    child: Text('1.5x', style: TextStyle(color: Colors.white)),
                                  ),
                                  const PopupMenuItem(
                                    value: 2.0,
                                    child: Text('2x', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Loading Indicator
            if (!_controller.value.isPlaying && !_controller.value.isBuffering)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 64,
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: _togglePlayPause,
                ),
              ),
          ],
        ),
      ),
    );
  }
}