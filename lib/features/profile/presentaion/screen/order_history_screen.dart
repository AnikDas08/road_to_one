import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/order_history_controller.dart';
import '../../data/order_model.dart';


class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({Key? key}) : super(key: key);

  final OrderHistoryController controller = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "Order History"),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          Obx(() => controller.orders.isEmpty
              ? _buildEmptyState()
              : Expanded(
                child: ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            itemCount: controller.orders.length,
                            separatorBuilder: (context, index) => Divider(
                color: Colors.white.withOpacity(0.05),
                height: 1,
                thickness: 1,
                            ),
                            itemBuilder: (context, index) {
                final order = controller.orders[index];
                return _buildOrderItem(order);
                            },
                          ),
              )),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Order order) {
    return InkWell(
      onTap: () => controller.viewOrderDetails(order),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.upcolor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                // Product Image
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.grey[800],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      order.productImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                            size: 32.sp,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.w),

                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.productName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${order.itemCount} Item${order.itemCount > 1 ? 's' : ''}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Date
                Text(
                  order.date,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h,)
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            color: Colors.grey[700],
            size: 80.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Orders Yet',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your order history will appear here',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}