import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../issue/issue_model.dart';

class AdminIssueDetailPage extends StatelessWidget {
  final IssueModel issue;
  final int index;

  const AdminIssueDetailPage({
    super.key,
    required this.issue,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final issuesBox = Hive.box<IssueModel>('issues');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sorun Detayı'),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.15),
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// 🌄 ARKA PLAN
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_malatya.jpg',
              fit: BoxFit.cover,
            ),
          ),

          /// 🌑 OVERLAY
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),

          /// 📄 İÇERİK
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🖼 FOTOĞRAF
                  _GlassCard(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(issue.imagePath),
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 📝 AÇIKLAMA
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Açıklama',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          issue.description,
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 📍 KONUM
                  _GlassCard(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.greenAccent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            issue.address,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🔄 DURUM
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Durum Güncelle',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),

                        DropdownButtonFormField<String>(
                          value: issue.status,
                          dropdownColor: Colors.grey.shade900,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'received',
                              child: Text('Alındı'),
                            ),
                            DropdownMenuItem(
                              value: 'inProgress',
                              child: Text('İnceleniyor'),
                            ),
                            DropdownMenuItem(
                              value: 'resolved',
                              child: Text('Çözüldü'),
                            ),
                          ],
                          onChanged: (newStatus) {
                            if (newStatus == null) return;

                            final updated = IssueModel(
                              id: issue.id,
                              description: issue.description,
                              imagePath: issue.imagePath,
                              latitude: issue.latitude,
                              longitude: issue.longitude,
                              address: issue.address,
                              createdAt: issue.createdAt,
                              status: newStatus,
                            );

                            issuesBox.putAt(index, updated);

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== */
/* CAM KART              */
/* ===================== */

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}
