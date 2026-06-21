import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/task_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedMonth = DateTime(2025, 9);
  int _selectedDay = 18;

  static const List<String> _weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  static final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Dashboard UI Design',
      'progress': 0.5,
      'time': '1:30 AM - 2:20 AM',
      'status': 'On Going',
      'progressColor': AppColors.accentOrange,
    },
    {
      'title': 'Mobile App Wireframe',
      'progress': 0.35,
      'time': '2:30 PM - 4:20 PM',
      'status': 'On Going',
      'progressColor': AppColors.primary,
    },
  ];

  String get _monthLabel {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[_focusedMonth.month - 1]} ${_focusedMonth.year}';
  }

  String get _selectedDateLabel {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[_focusedMonth.month - 1]} $_selectedDay';
  }

  int get _daysInMonth =>
      DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;

  int get _firstWeekdayOffset {
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    return firstDay.weekday % 7;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Calendar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildMonthHeader(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildWeekDayLabels(),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildCalendarGrid(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildTasksHeader(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              children: _tasks.map((task) {
                return TaskCard(
                  title: task['title']!,
                  progress: task['progress']!,
                  time: task['time']!,
                  status: task['status'],
                  progressColor: task['progressColor'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _monthLabel,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        _buildMonthNavButton(Icons.chevron_left_rounded, _previousMonth),
        const SizedBox(width: 8),
        _buildMonthNavButton(Icons.chevron_right_rounded, _nextMonth),
      ],
    );
  }

  Widget _buildMonthNavButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.onboardingTextSecondary,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildWeekDayLabels() {
    return Row(
      children: _weekDays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.onboardingTextSecondary.withValues(alpha: 0.8),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final totalCells = _firstWeekdayOffset + _daysInMonth;
    final rowCount = (totalCells / 7).ceil();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: rowCount * 7,
      itemBuilder: (context, index) {
        final dayNumber = index - _firstWeekdayOffset + 1;

        if (dayNumber < 1 || dayNumber > _daysInMonth) {
          return const SizedBox.shrink();
        }

        final isSelected = dayNumber == _selectedDay;

        return GestureDetector(
          onTap: () => setState(() => _selectedDay = dayNumber),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.accentOrange
                  : AppColors.darkCard.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$dayNumber',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.statText
                    : AppColors.onboardingTextSecondary.withValues(alpha: 0.9),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTasksHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tasks · $_selectedDateLabel',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          '${_tasks.length} items',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primaryLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      _selectedDay = 1;
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
      _selectedDay = 1;
    });
  }
}
