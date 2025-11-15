import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/features/auth/phone_signup/presentation/controller/phonesignupcontroller.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../signup/presentation/controller/sign_up_controller.dart';
import 'package:country_picker/country_picker.dart';

class PhoneSignUpScreen extends StatelessWidget {
  const PhoneSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhoneSignupController controller = Get.put(PhoneSignupController());

    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              // Title
              CommonText(
                  text: "Sign Up",
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white50,
              ),

              const SizedBox(height: 8),

              // Subtitle
              CommonText(
                text: "Sign up and execute your fitness journey with us",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white700,
              ),

              SizedBox(height: 40.h),

              // Mobile Number Label
              CommonText(
                  text: "Mobile Number",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white50,
              ),

              const SizedBox(height: 12),

              // Phone Input Field
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // Country Code Picker
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            backgroundColor: const Color(0xFF2A2A2A),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            searchTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            inputDecoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[600],
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1A1A1A),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            bottomSheetHeight: 500.h,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          onSelect: (Country country) {
                            controller.updateCountry(country);
                          },
                        );
                      },
                      child: Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              controller.selectedCountryFlag.value,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              controller.selectedCountryCode.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )),
                    ),

                    // Vertical Divider
                    Container(
                      height: 24.h,
                      width: 1,
                      color: Colors.grey[800],
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),

                    // Phone Number Input
                    Expanded(
                      child: TextField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: '1234 567891',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),
              CommonButton(
                  titleText: "Get Otp",
                  onTap: (){
                    
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}