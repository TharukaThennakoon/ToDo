import 'package:flutter/material.dart';

/// High-quality animated illustration for onboarding and auth screens.
class AnimatedIllustration extends StatefulWidget {
  final String assetPath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool animate;

  const AnimatedIllustration({
    super.key,
    required this.assetPath,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.animate = true,
  });

  @override
  State<AnimatedIllustration> createState() => _AnimatedIllustrationState();
}

class _AnimatedIllustrationState extends State<AnimatedIllustration>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _floatController;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _fade = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _scale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    if (widget.animate) {
      _entranceController.forward();
      _floatController.repeat(reverse: true);
    } else {
      _entranceController.value = 1;
    }
  }

  @override
  void didUpdateWidget(AnimatedIllustration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath && widget.animate) {
      _entranceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _floatController]),
      builder: (context, child) {
        final floatOffset =
            widget.animate ? (_floatController.value - 0.5) * 12 : 0.0;

        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: Opacity(
            opacity: _fade.value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
      child: Image.asset(
        widget.assetPath,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: (widget.height ?? 200) * 0.3,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          );
        },
      ),
    );
  }
}
