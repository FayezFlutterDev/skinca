import '../../../core/constants/constants.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Search Doctors',
      description:
          'Get list of best doctor\n nearby you',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Initial diagnosis',
      description:
          'First step in identifying what might be \n causing a patient\'s health concerns',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Online Consultation',
      description:
          'Chat with SkinCa chatbot or with \na real doctor',
    ),
  ];
}
