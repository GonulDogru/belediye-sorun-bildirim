import 'dart:io';
import 'package:flutter/material.dart';
import 'issue_model.dart';

class IssueListPage extends StatelessWidget {
  final List<IssueModel> issues;

  const IssueListPage({super.key, required this.issues});

  @override
  Widget build(BuildContext context) {
    if (issues.isEmpty) {
      return const Center(
        child: Text(
          'Henüz bildirilmiş bir sorun yok',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: issues.length,
      itemBuilder: (context, index) {
        final issue = issues[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(issue.imagePath),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      issue.description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(issue.address, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 6),
                    Text(
                      'Tarih: ${issue.createdAt.toLocal()}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
