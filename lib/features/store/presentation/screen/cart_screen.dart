import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/image/app_bar.dart';
import '../../../../config/route/app_routes.dart';
import '../controller/cart_controller.dart';
import '../../data/models/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarNew(title: 'Cart'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items List
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CartItemCard(item: item),
                        );
                      },
                    )),
                    SizedBox(height: 24.h),
                    // Cost Summary
                    CommonText(
                      text: "Cost Summary",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white50,
                    ),
                    SizedBox(height: 16.h),
                    Obx(() => Column(
                      children: [
                        _buildSummaryRow('Subtotal', controller.subtotal),
                        SizedBox(height: 12.h),
                        _buildSummaryRow('Taxes', controller.taxes),
                        SizedBox(height: 12.h),
                        _buildSummaryRow('Other Fees', controller.otherFees),
                        SizedBox(height: 12.h),
                        _buildSummaryRow('Delivery Fees', controller.deliveryFees),
                        SizedBox(height: 16.h),
                        Divider(color: Colors.grey, height: 1),
                        SizedBox(height: 16.h),
                        _buildSummaryRow('Total', controller.total, isTotal: true),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CommonButton(
                    titleText: "Contunue Shopping",
                  buttonColor: Colors.transparent,
                  borderColor: Colors.white,
                  titleColor: Colors.white,
                  onTap: (){

                  },
                ),
                SizedBox(height: 20.h,),
                CommonButton(
                  titleText: "Checkout",
                  onTap: (){
                    Get.toNamed(AppRoutes.shippingInformationScreen);
                  },
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isTotal?AppColors.white50:AppColors.white700,
        ),
        CommonText(
          text: "\$${amount.toStringAsFixed(2)}",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isTotal?AppColors.white50:AppColors.white700,
        ),
      ],
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800, width: 1),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Quantity Controls and Delete
          Column(
            children: [
              GestureDetector(
                onTap: () => controller.removeItem(item.id),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.decrementQuantity(item.id),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${item.quantity.value}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
                    GestureDetector(
                      onTap: () => controller.incrementQuantity(item.id),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}