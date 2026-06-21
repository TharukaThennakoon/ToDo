import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final Priority priority;
  final Category category;
  final double progress;
  final List<String> participants;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.category,
    this.progress = 0.0,
    this.participants = const [],
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'priority': priority.index,
      'category': category.index,
      'progress': progress,
      'participants': participants,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      priority: Priority.values[json['priority']],
      category: Category.values[json['category']],
      progress: json['progress'],
      participants: List<String>.from(json['participants']),
      isCompleted: json['isCompleted'],
    );
  }
}

enum Priority { low, medium, high }

enum Category { design, development, marketing, research }