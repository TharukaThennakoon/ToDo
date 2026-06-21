import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/stat_card.dart';
import 'widgets/analysis_charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = 'Daily';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildStatsGrid(),
            const SizedBox(height: 28),
            _buildSectionHeader(
              title: 'Task Analyses',
              trailing: _buildPeriodDropdown(),
            ),
            const SizedBox(height: 14),
            const TaskAnalysisChart(),
            const SizedBox(height: 28),
            const Text(
              'Weekly Productivity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            const WeeklyProductivityChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: const [
        StatCard(
          value: '34',
          label: 'Task Completed',
          icon: Icons.task_alt_outlined,
          backgroundColor: AppColors.statGreen,
        ),
        StatCard(
          value: '15',
          label: 'Project Submitted',
          icon: Icons.upload_outlined,
          backgroundColor: AppColors.statYellow,
        ),
        StatCard(
          value: '10',
          label: 'Project Ongoing',
          icon: Icons.image_outlined,
          backgroundColor: AppColors.statBlue,
        ),
        StatCard(
          value: '20',
          label: 'Task Pending',
          icon: Icons.show_chart_rounded,
          backgroundColor: AppColors.statTeal,
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _buildPeriodDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPeriod,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryLight,
            size: 18,
          ),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryLight,
          ),
          dropdownColor: AppColors.darkCard,
          items: ['Daily', 'Weekly', 'Monthly'].map((period) {
            return DropdownMenuItem(
              value: period,
              child: Text(period),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedPeriod = value);
            }
          },
        ),
      ),
    );
  }
}
