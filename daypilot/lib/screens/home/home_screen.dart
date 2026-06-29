import 'package:daypilot/services/auth.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDayIndex = 0;
  int _selectedTabIndex = 0;

  static const List<Map<String, String>> _weekDays = [
    {'day': 'SUN', 'date': '16'},
    {'day': 'MON', 'date': '17'},
    {'day': 'TUE', 'date': '18'},
    {'day': 'WED', 'date': '19'},
    {'day': 'THU', 'date': '20'},
    {'day': 'FRI', 'date': '21'},
  ];

  static const List<String> _tabs = [
    'Today',
    'Upcoming',
    'Due Soon',
    'Completed',
  ];

  static final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Dashboard UI Design',
      'progress': 0.5,
      'time': '1:30 AM - 2:20 AM',
    },
    {
      'title': 'Mobile App Wireframe',
      'progress': 0.35,
      'time': '2:30 PM - 4:20 PM',
    },
  ];

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 28),
            _buildHeadline(),
            const SizedBox(height: 20),
            _buildStatsGrid(),
            const SizedBox(height: 28),
            const Text(
              'Ongoing Task',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildDateSelector(),
            const SizedBox(height: 20),
            _buildTabBar(),
            const SizedBox(height: 20),
            ..._tasks.map(
              (task) => TaskCard(
                title: task['title']!,
                progress: task['progress']!,
                time: task['time']!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.accentOrange,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'A',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alex Morgen',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'Good Morning 👋',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.onboardingTextSecondary.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        _buildHeaderIcon(Icons.search_rounded),
        const SizedBox(width: 10),
        _buildHeaderIcon(Icons.notifications_none_rounded, showBadge: true),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon, {bool showBadge = false}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.onboardingTextSecondary.withValues(alpha: 0.2),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          if (showBadge)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return const Text(
      'Create & Make\nDaily Task',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
        letterSpacing: -0.5,
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

  Widget _buildDateSelector() {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _weekDays.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = _weekDays[index];
          final isSelected = _selectedDayIndex == index;

          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day['day']!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.onboardingTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    day['date']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? Colors.white
                          : AppColors.onboardingTextSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: List.generate(_tabs.length, (index) {
        final isSelected = _selectedTabIndex == index;
        return Padding(
          padding: EdgeInsets.only(right: index < _tabs.length - 1 ? 20 : 0),
          child: GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Text(
                  _tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.accentOrange
                        : AppColors.onboardingTextSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 3,
                  width: isSelected ? 24 : 0,
                  decoration: BoxDecoration(
                    color: AppColors.accentOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
