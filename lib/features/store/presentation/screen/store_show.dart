// Path: lib/screens/store/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/store_show_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key}) : super(key: key);

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBarNew(title: "Product Details"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400.h,
                          margin: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            image: controller.product['image'] != null
                                ? DecorationImage(
                              image: NetworkImage(controller.product['image']),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: controller.product['image'] == null
                              ? Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey[400],
                              size: 80.sp,
                            ),
                          )
                              : null,
                        ),
                        Positioned(
                          top: 28.h,
                          right: 28.w,
                          child: Obx(() => GestureDetector(
                            onTap: controller.toggleFavorite,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                                color: controller.isFavorite.value ? Colors.red : Colors.grey[700],
                                size: 24.sp,
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
        
                    // Product Info
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.product['name'] ?? 'Product Name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '\$${controller.product['price'] ?? '0.00'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Item',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14.sp,
                            ),
                          ),
        
                          SizedBox(height: 24.h),
        
                          // Size and Quantity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                'Size: ${controller.selectedSize.value}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
        
                          SizedBox(height: 12.h),
        
                          // Size Selection and Quantity Counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Size Buttons
                              Row(
                                children: controller.sizes.map((size) {
                                  return Obx(() {
                                    final isSelected = controller.selectedSize.value == size;
                                    return GestureDetector(
                                      onTap: () => controller.selectSize(size),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8.w),
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.white : Color(0xFF2A2A2A),
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: isSelected ? Colors.white : Colors.grey[700]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          size,
                                          style: TextStyle(
                                            color: isSelected ? Colors.black : Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                }).toList(),
                              ),
        
                              // Quantity Counter
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.white, size: 20.sp),
                                      onPressed: controller.decrementQuantity,
                                      padding: EdgeInsets.all(8.w),
                                      constraints: BoxConstraints(),
                                    ),
                                    Obx(() => Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                                      child: Text(
                                        '${controller.quantity.value}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.white, size: 20.sp),
                                      onPressed: controller.incrementQuantity,
                                      padding: EdgeInsets.all(8.w),
                                      constraints: BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
        
                          SizedBox(height: 24.h),
        
                          // Color Selection
                          Text(
                            'Color: ${controller.selectedColor.value}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
        
                          SizedBox(height: 12.h),
        
                          Row(
                            children: controller.colors.map((colorItem) {
                              return Obx(() {
                                final isSelected = controller.selectedColor.value == colorItem['name'];
                                return GestureDetector(
                                  onTap: () => controller.selectColor(colorItem['name']),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 12.w),
                                    width: 36.w,
                                    height: 36.w,
                                    decoration: BoxDecoration(
                                      color: colorItem['color'],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? Colors.white : Colors.transparent,
                                        width: 2,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.3),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                          : null,
                                    ),
                                  ),
                                );
                              });
                            }).toList(),
                          ),
        
                          SizedBox(height: 24.h),
        
                          // Product Description
                          CommonText(
                              text: "Product Description",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
        
                          SizedBox(height: 12.h),
        
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: Colors.grey[700]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Introducing the No Doubt T-shirt from design from Lospi do EL. "It\'s ok to just 1" and, like the message of my jumper, we have decided to use a short story! We had the idea of this design being good for short stories or any situations or conversations that are abvout self loving good for the best version of yourself. We believe self love is a life-long goal the best.',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
        
                          SizedBox(height: 24.h),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: [
                                CommonButton(
                                  titleText: "Add to Cart",
                                  buttonColor: AppColors.transparent,
                                  titleColor: AppColors.white,
                                  borderColor: AppColors.white,
                                  onTap: (){
                                    Get.toNamed(AppRoutes.cartScreen);
                                  },
                                ),
                                SizedBox(height: 18.h),
                                CommonButton(
                                  titleText: "Buy with Shop",
                                  onTap: (){
                                    Get.toNamed(AppRoutes.homeNav);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}