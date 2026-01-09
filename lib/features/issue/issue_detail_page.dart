import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'issue_model.dart';

class IssueDetailPage extends StatelessWidget {
  final IssueModel issue;

  const IssueDetailPage({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_malatya.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📸 FOTO
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

                  // 📝 AÇIKLAMA
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
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📍 KONUM
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

                  // ⏱️ DURUM
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Durum',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _StatusTimeline(issue.status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ========================= */
/* STATUS TIMELINE           */
/* ========================= */

class _StatusTimeline extends StatelessWidget {
  final String status;
  const _StatusTimeline(this.status);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row('Alındı', Icons.check_circle, true),
        _row(
          'İnceleniyor',
          Icons.search,
          status == 'inProgress' || status == 'resolved',
        ),
        _row('Çözüldü', Icons.done_all, status == 'resolved'),
      ],
    );
  }

  Widget _row(String label, IconData icon, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: active ? Colors.greenAccent : Colors.white24),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: active ? Colors.greenAccent : Colors.white38,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/* ========================= */
/* GLASS CARD                */
/* ========================= */

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
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
          ),
          child: child,
        ),
      ),
    );
  }
}
