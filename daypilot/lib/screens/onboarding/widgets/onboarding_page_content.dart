import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../widgets/animated_illustration.dart';
import '../onboarding_model.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingModel data;
  final int pageIndex;
  final int currentPage;
  final VoidCallback? onStart;

  const OnboardingPageContent({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.currentPage,
    this.onStart,
  });

  bool get _isActive => pageIndex == currentPage;

  @override
  Widget build(BuildContext context) {
    if (data.isLastScreen) {
      return _buildLastPage(context);
    }
    return _buildRegularPage(context);
  }

  Widget _buildRegularPage(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
            child: AnimatedIllustration(
              key: ValueKey(data.imageAsset),
              assetPath: data.imageAsset,
              width: double.infinity,
              fit: BoxFit.contain,
              animate: _isActive,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _AnimatedTextBlock(
              isActive: _isActive,
              title: data.title,
              subtitle: data.subtitle,
              titleSize: 28,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: AnimatedIllustration(
                key: ValueKey(data.imageAsset),
                assetPath: data.imageAsset,
                width: double.infinity,
                fit: BoxFit.contain,
                animate: _isActive,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AnimatedTextBlock(
                  isActive: _isActive,
                  title: data.title,
                  subtitle: data.subtitle,
                  titleSize: 32,
                ),
                const SizedBox(height: 32),
                AnimatedOpacity(
                  opacity: _isActive ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedSlide(
                    offset: _isActive ? Offset.zero : const Offset(0, 0.15),
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutCubic,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onStart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start Managing',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedTextBlock extends StatelessWidget {
  final bool isActive;
  final String title;
  final String subtitle;
  final double titleSize;

  const _AnimatedTextBlock({
    required this.isActive,
    required this.title,
    required this.subtitle,
    required this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isActive ? 1 : 0.4,
      duration: const Duration(milliseconds: 350),
      child: AnimatedSlide(
        offset: isActive ? Offset.zero : const Offset(0, 0.12),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.onboardingTextSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (titleSize == 28) const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
