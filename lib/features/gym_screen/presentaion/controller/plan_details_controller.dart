import 'package:get/get.dart';

import '../../data/model/plan_details_model.dart';

class PlanDetailController extends GetxController {

  final isLoading = true.obs;
  final Rx<PlanDetailModel?> planDetail = Rx<PlanDetailModel?>(null);


  @override
  void onInit() {
    super.onInit();
    loadPlanDetail();
  }

  void loadPlanDetail() async {
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Load plan details based on planId
    planDetail.value = _getPlanDetails();

    isLoading.value = false;
  }

  PlanDetailModel _getPlanDetails() {
    // Mock data - Replace with actual API call

        return PlanDetailModel(
          id: '1',
          title: 'Push Day',
          imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800',
          description: 'Target the major muscle groups of the upper body: chest, shoulders, and triceps. Strengthening these areas improves pushing power, upper body aesthetics, and enhancing overall muscle balance and definition.',
          benefits: [
            'Builds upper body strength and muscle density.',
            'Improves shoulder stability and joint support.',
            'Enhances posture and core alignment.',
            'Boosts performance in compound lifts and athletic movements.',
            'Promotes balanced muscle development and reduces risk of injury.',
          ],
        );
  }
}