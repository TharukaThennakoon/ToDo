import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class TaskAnalysisChart extends StatelessWidget {
  const TaskAnalysisChart({super.key});

  static const List<double> _values = [0.32, 0.48, 0.38, 0.52, 0.42, 0.58, 0.72, 0.5, 0.44];
  static const List<String> _labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
  static const int _peakIndex = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: _LineChartPainter(
                values: _values,
                peakIndex: _peakIndex,
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _labels.map((label) {
              return Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> values;
  final int peakIndex;

  _LineChartPainter({
    required this.values,
    required this.peakIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    const gridColor = Color(0xFF2A3142);
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (var i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height - (values[i] * size.height * 0.85) - 8;
      points.add(Offset(x, y));
    }

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = AppColors.statGreen
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, linePaint);

    for (var i = 0; i < points.length; i++) {
      final isPeak = i == peakIndex;
      canvas.drawCircle(
        points[i],
        isPeak ? 6 : 3,
        Paint()
          ..color = AppColors.statGreen
          ..style = isPeak ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      if (isPeak) {
        canvas.drawCircle(
          points[i],
          10,
          Paint()
            ..color = AppColors.statGreen.withValues(alpha: 0.25)
            ..style = PaintingStyle.fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WeeklyProductivityChart extends StatelessWidget {
  const WeeklyProductivityChart({super.key});

  static const List<double> _bars = [0.45, 0.62, 0.38, 0.75, 0.55, 0.68, 0.5];
  static const List<String> _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(_bars.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : 4,
                      right: index == _bars.length - 1 ? 0 : 4,
                    ),
                    child: Container(
                      height: 100 * _bars[index],
                      decoration: BoxDecoration(
                        color: index == 3
                            ? AppColors.accentOrange
                            : AppColors.primary.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(_days.length, (index) {
              return Expanded(
                child: Center(
                  child: Text(
                    _days[index],
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
