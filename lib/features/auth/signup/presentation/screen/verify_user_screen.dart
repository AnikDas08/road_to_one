import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:road_project_flutter/features/auth/signup/presentation/controller/verify_user_controller.dart';

class VerifyUserScreen extends StatelessWidget {
  const VerifyUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyUserController controller = Get.put(VerifyUserController());

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
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
              const SizedBox(height: 40),

              /// Title
              const Text(
                'Verify Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              /// Subtitle
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text:
                      'Enter your verification code that we have sent you on your email\n',
                    ),
                    TextSpan(
                      text: controller.email,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// OTP Label
              Text(
                'Enter Code',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ PIN Code Input Field
              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                cursorColor: const Color(0xFFCDFF00),
                obscureText: false,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline, // 🔥 শুধু underline
                  fieldHeight: 55,
                  fieldWidth: 45,
                  inactiveColor: Colors.grey[700]!,
                  activeColor: const Color(0xFFCDFF00),
                  selectedColor: const Color(0xFFCDFF00),
                ),
                onChanged: (value) => controller.updateOTPFromTextField(value),
              ),

              const SizedBox(height: 40),

              /// Verify Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => controller.verifyOTP(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCDFF00),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
