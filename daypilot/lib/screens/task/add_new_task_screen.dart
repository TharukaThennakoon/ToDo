import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';
import '../../utils/colors.dart';

enum TaskType { newTask, routine, todo }

enum TaskPriority { low, medium, high }

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController =
      TextEditingController(text: 'Dashboard UI Design');
  final TextEditingController _descriptionController =
      TextEditingController();

  TaskType _selectedType = TaskType.newTask;
  TaskPriority _selectedPriority = TaskPriority.high;
  int _selectedCategoryIndex = 0;

  static const List<({String label, Color color})> _categories = [
    (label: 'Design', color: AppColors.primary),
    (label: 'Development', color: AppColors.statTeal),
    (label: 'Marketing', color: AppColors.statYellow),
    (label: 'Research', color: AppColors.statGreen),
  ];

  static const List<({String initial, Color color})> _participants = [
    (initial: 'A', color: AppColors.accentOrange),
    (initial: 'M', color: AppColors.primary),
    (initial: 'S', color: AppColors.statTeal),
    (initial: 'J', color: AppColors.statBlue),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTypeSelector(),
                    const SizedBox(height: 24),
                    _buildFieldLabel('Title'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _titleController,
                      hint: 'Dashboard UI Design',
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel('Description'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _descriptionController,
                      hint: 'Add details for this task...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel('Date & Time'),
                    const SizedBox(height: 8),
                    _buildDateTimeField(),
                    const SizedBox(height: 24),
                    _buildFieldLabel('Priority'),
                    const SizedBox(height: 10),
                    _buildPrioritySelector(),
                    const SizedBox(height: 24),
                    _buildFieldLabel('Category'),
                    const SizedBox(height: 10),
                    _buildCategorySelector(),
                    const SizedBox(height: 24),
                    _buildFieldLabel('Participants'),
                    const SizedBox(height: 10),
                    _buildParticipantsRow(),
                  ],
                ),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => NavigationService.instance.pop(),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Add New',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTypeTab('New', TaskType.newTask),
          _buildTypeTab('Routine', TaskType.routine),
          _buildTypeTab('Todo', TaskType.todo),
        ],
      ),
    );
  }

  Widget _buildTypeTab(String label, TaskType type) {
    final isSelected = _selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accentOrange : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.statText : AppColors.onboardingTextSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.onboardingTextSecondary.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.onboardingTextSecondary.withValues(alpha: 0.5),
          fontSize: 15,
        ),
        filled: true,
        fillColor: AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDateTimeField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 18,
            color: AppColors.accentOrange.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 12),
          const Text(
            'Mon, 17 — 9:30 AM',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: TaskPriority.values.map((priority) {
        final isSelected = _selectedPriority == priority;
        final label = switch (priority) {
          TaskPriority.low => 'Low',
          TaskPriority.medium => 'Medium',
          TaskPriority.high => 'High',
        };

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: priority != TaskPriority.high ? 10 : 0,
            ),
            child: GestureDetector(
              onTap: () => setState(() => _selectedPriority = priority),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.accentOrange
                        : AppColors.onboardingTextSecondary.withValues(alpha: 0.15),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      size: 16,
                      color: isSelected
                          ? AppColors.accentOrange
                          : AppColors.onboardingTextSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.accentOrange
                            : AppColors.onboardingTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategorySelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(_categories.length, (index) {
        final category = _categories[index];
        final isSelected = _selectedCategoryIndex == index;

        return GestureDetector(
          onTap: () => setState(() => _selectedCategoryIndex = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? category.color.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? category.color
                    : category.color.withValues(alpha: 0.6),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sell_outlined,
                  size: 14,
                  color: category.color,
                ),
                const SizedBox(width: 6),
                Text(
                  category.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: category.color,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildParticipantsRow() {
    return Row(
      children: [
        SizedBox(
          height: 36,
          width: _participants.length * 24.0 + 12,
          child: Stack(
            children: List.generate(_participants.length, (index) {
              final participant = _participants[index];
              return Positioned(
                left: index * 24.0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: participant.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkBackground, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    participant.initial,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.person_add_alt_1_outlined,
            size: 18,
            color: AppColors.primaryLight,
          ),
          label: Text(
            'Invite',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 54,
              child: OutlinedButton(
                onPressed: () => NavigationService.instance.pop(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark.withValues(alpha: 0.35),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () => NavigationService.instance.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  foregroundColor: AppColors.statText,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Task',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
