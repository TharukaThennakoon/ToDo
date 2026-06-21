import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';
import '../../utils/colors.dart';
import 'onboarding_model.dart';
import 'onboarding_data.dart';
import 'widgets/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingModel> get _pages => OnboardingData.pages;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return OnboardingPageContent(
                  data: _pages[index],
                  pageIndex: index,
                  currentPage: _currentPage,
                  onStart: _goToLogin,
                );
              },
            ),
            if (!isLastPage) _buildSkipButton(),
            if (!isLastPage) _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: TextButton(
        onPressed: _goToLogin,
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 40,
      left: 24,
      right: 24,
      child: Column(
        children: [
          _buildDotIndicators(),
          const SizedBox(height: 28),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    final isActive = _currentPage == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 28 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.darkCard,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: 160,
      height: 56,
      child: ElevatedButton(
        onPressed: _goToNextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _goToNextPage() {
    if (_currentPage < _pages.length - 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      _pageController.animateToPage(
        _pages.length - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _goToLogin() {
    NavigationService.instance.toLogin();
  }
}
