import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../services/navigation_service.dart';
import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _orbitController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _titleSlide;
  late Animation<double> _titleOpacity;
  late Animation<double> _subtitleOpacity;
  late Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _mainController.forward();
    _pulseController.repeat(reverse: true);
    _orbitController.repeat();
    _navigateToOnboarding();
  }

  void _setupAnimations() {
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
      ),
    );

    _loaderOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  Future<void> _navigateToOnboarding() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (mounted) {
      NavigationService.instance.toOnboarding();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          _buildBackgroundOrbs(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _mainController,
                    _pulseController,
                    _orbitController,
                  ]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Opacity(
                        opacity: _logoOpacity.value,
                        child: _buildAnimatedLogo(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: Opacity(
                        opacity: _titleOpacity.value,
                        child: child,
                      ),
                    );
                  },
                  child: const Text(
                    'Taskly',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _subtitleOpacity.value,
                      child: child,
                    );
                  },
                  child: Text(
                    'Task Manager',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _loaderOpacity.value,
                      child: child,
                    );
                  },
                  child: _buildLoadingDots(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundOrbs() {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -80 + (_orbitController.value * 20),
              left: -60,
              child: _buildOrb(
                size: 200,
                color: AppColors.primary.withValues(alpha: 0.08),
              ),
            ),
            Positioned(
              bottom: -100 + (_orbitController.value * 30),
              right: -80,
              child: _buildOrb(
                size: 260,
                color: AppColors.primaryLight.withValues(alpha: 0.06),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              right: 40 + (_orbitController.value * 15),
              child: _buildOrb(
                size: 80,
                color: AppColors.accentOrange.withValues(alpha: 0.05),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOrb({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    final pulseScale = 1.0 + (_pulseController.value * 0.06);

    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: pulseScale * 1.4,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(
                  alpha: 0.08 + (_pulseController.value * 0.06),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: pulseScale,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                size: 48,
                color: AppColors.primary,
              ),
            ),
          ),
          ...List.generate(3, (index) {
            final angle = (_orbitController.value * 2 * math.pi) +
                (index * 2 * math.pi / 3);
            const radius = 52.0;
            return Transform.translate(
              offset: Offset(
                radius * math.cos(angle),
                radius * math.sin(angle),
              ),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(
                    alpha: 0.3 + (index * 0.15),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLoadingDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final delay = index * 0.2;
        final dotValue = (_pulseController.value + delay) % 1.0;
        final scale =
            0.6 + (dotValue < 0.5 ? dotValue * 0.8 : (1 - dotValue) * 0.8);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8 * scale,
          height: 8 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.4 + scale * 0.6),
          ),
        );
      }),
    );
  }
}
