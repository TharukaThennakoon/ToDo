import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final double progress;
  final String time;
  final String? status;
  final Color? progressColor;
  final List<({String initial, Color color})> participants;

  const TaskCard({
    super.key,
    required this.title,
    required this.progress,
    required this.time,
    this.status,
    this.progressColor,
    this.participants = const [
      (initial: 'A', color: AppColors.accentOrange),
      (initial: 'M', color: AppColors.primary),
      (initial: 'S', color: AppColors.statTeal),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Participates',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onboardingTextSecondary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildParticipantAvatars(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildCircularProgress(),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.hourglass_bottom_rounded,
                size: 16,
                color: AppColors.accentOrange.withValues(alpha: 0.9),
              ),
              const SizedBox(width: 6),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.onboardingTextSecondary.withValues(alpha: 0.8),
                ),
              ),
              const Spacer(),
              if (status != null) _buildStatusBadge(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentOrange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status!,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.accentOrange,
        ),
      ),
    );
  }

  Widget _buildParticipantAvatars() {
    return SizedBox(
      height: 32,
      width: participants.length * 22.0 + 10,
      child: Stack(
        children: List.generate(participants.length, (index) {
          final participant = participants[index];
          return Positioned(
            left: index * 22.0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: participant.color,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.darkCard, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                participant.initial,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCircularProgress() {
    final percent = (progress * 100).toInt();
    final ringColor = progressColor ?? AppColors.accentOrange;

    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 4,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              color: ringColor,
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            '$percent%',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
