class OnboardingModel {
  final String title;
  final String subtitle;
  final String imageAsset;
  final bool isLastScreen;

  const OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    this.isLastScreen = false,
  });
}
