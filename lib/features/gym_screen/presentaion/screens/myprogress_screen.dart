import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';
import 'dart:io';
import '../controller/my_progress_controller.dart';
import '../../data/model/progress_model.dart';

class MyProgressScreen extends GetView<MyProgressController> {
  MyProgressScreen({Key? key}) : super(key: key);

  MyProgressController controller = Get.put(MyProgressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          _buildTimeFilterTabs(),
          SizedBox(height: 24.h),
          _buildWorkoutCount(),
          SizedBox(height: 20.h),
          _buildWorkoutPicturesHeader(),
          SizedBox(height: 12.h),
          _buildPicturesGrid(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBarNew(title: "My Progress");
  }

  Widget _buildTimeFilterTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildTabButton('This Week', 0),
          SizedBox(width: 8.w),
          _buildTabButton('This Month', 1),
          SizedBox(width: 8.w),
          _buildTabButton('This Year', 2),
          SizedBox(width: 8.w),
          _buildTabButton('Total', 3),
        ],
      ),
    );
  }

  Widget _buildWorkoutCount() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: const Color(0xFFb4ff39),
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Obx(() => Text(
            '${controller.workoutCount} workout${controller.workoutCount != 1 ? 's' : ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildWorkoutPicturesHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'Workout Pictures',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPicturesGrid() {
    return Expanded(
      child: Obx(() {
        final pictureCount = controller.pictures.length;
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1,
          ),
          itemCount: pictureCount + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildAddPictureButton();
            }
            return _buildPictureItem(controller.pictures[index - 1], index - 1);
          },
        );
      }),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab == index;
      return GestureDetector(
        onTap: () => controller.selectTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.grey[700]!,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAddPictureButton() {
    return GestureDetector(
      onTap: () => controller.addPicture(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2d2d2d),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          color: Colors.grey[600],
          size: 32.sp,
        ),
      ),
    );
  }

  Widget _buildPictureItem(PictureItem pictureItem, int index) {
    return GestureDetector(
      onTap: () => _showImageViewer(index),
      onLongPress: () => _showOptionsDialog(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: pictureItem.imageUrl.startsWith('http')
                ? NetworkImage(pictureItem.imageUrl) as ImageProvider
                : FileImage(File(pictureItem.imageUrl)),
            fit: BoxFit.cover,
          ),
        ),
        child: pictureItem.caption.isNotEmpty
            ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Text(
              pictureItem.caption,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        )
            : null,
      ),
    );
  }

  void _showImageViewer(int index) {
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(
          pictures: controller.pictures,
          initialIndex: index,
          onDelete: (deleteIndex) => _showDeleteDialog(deleteIndex),
          onEdit: (editIndex) => controller.editCaption(editIndex),
        ),
      ),
    );
  }

  void _showOptionsDialog(int index) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2d2d2d),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFFb4ff39)),
              title: const Text('Edit Caption', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                controller.editCaption(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete Picture', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                _showDeleteDialog(index);
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        title: const Text(
          'Delete Picture',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete this picture?',
          style: TextStyle(color: Colors.grey[400]),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.deletePicture(index);
              Get.back();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// Full screen image viewer with vertical scroll
class ImageViewerScreen extends StatefulWidget {
  final List<PictureItem> pictures;
  final int initialIndex;
  final Function(int)? onDelete;
  final Function(int)? onEdit;

  const ImageViewerScreen({
    Key? key,
    required this.pictures,
    required this.initialIndex,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
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
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.pictures.length}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          if (widget.onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFFb4ff39)),
              onPressed: () {
                widget.onEdit!(_currentIndex);
              },
            ),
          if (widget.onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                widget.onDelete!(_currentIndex);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.pictures.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final pictureItem = widget.pictures[index];
          return _buildImageViewer(pictureItem);
        },
      ),
    );
  }

  Widget _buildImageViewer(PictureItem pictureItem) {
    return Stack(
      children: [
        Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: pictureItem.imageUrl.startsWith('http')
                ? Image.network(
              pictureItem.imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                    color: const Color(0xFFb4ff39),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 100, color: Colors.grey[700]),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                );
              },
            )
                : Image.file(
              File(pictureItem.imageUrl),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 100, color: Colors.grey[700]),
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
          ),
        ),
        if (pictureItem.caption.isNotEmpty)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                pictureItem.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}