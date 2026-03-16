import 'package:flutter/material.dart';

class ProfilePreviewCard extends StatelessWidget {
  final String fullName;
  final String studentId;
  final String className;
  final String fallbackFullNameLabel;
  final String fallbackStudentIdLabel;
  final String fallbackClassNameLabel;

  const ProfilePreviewCard({
    super.key,
    required this.fullName,
    required this.studentId,
    required this.className,
    required this.fallbackFullNameLabel,
    required this.fallbackStudentIdLabel,
    required this.fallbackClassNameLabel,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        fullName.trim().isEmpty ? fallbackFullNameLabel : fullName.trim();
    final displayStudentId =
        studentId.trim().isEmpty ? fallbackStudentIdLabel : studentId.trim();
    final displayClass =
        className.trim().isEmpty ? fallbackClassNameLabel : className.trim();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: const Color(0xFFE8EEFF),
              child: Text(
                displayName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF3552C8),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    displayStudentId,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    displayClass,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
