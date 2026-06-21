import '../../utils/constants.dart';
import 'onboarding_model.dart';

class OnboardingData {
  OnboardingData._();

  static const List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'Get Things Done',
      subtitle: 'Celebrate every win, big or small.',
      imageAsset: AppConstants.onboardingGetThingsDone,
    ),
    OnboardingModel(
      title: 'Collaborate',
      subtitle: 'Invite teammates and track progress together.',
      imageAsset: AppConstants.onboardingCollaborate,
    ),
    OnboardingModel(
      title: 'Plan Your Day',
      subtitle: 'Create tasks, set priorities and stay focused.',
      imageAsset: AppConstants.onboardingPlanDay,
    ),
    OnboardingModel(
      title: 'Enjoy Super\nOrganized Life',
      subtitle: 'A task manager you can trust for life',
      imageAsset: AppConstants.onboardingOrganizedLife,
      isLastScreen: true,
    ),
  ];
}
