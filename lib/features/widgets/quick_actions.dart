import 'package:flutter/material.dart';

import '../issue/issue_page.dart';
import '../map/map_page.dart';
import '../municipality/municipality_page.dart';
import '../alerts/live_malatya_page.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _QuickActionCard(
          icon: Icons.report_problem,
          title: 'Sorun Bildir',
          color: Colors.orangeAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const IssuePage()),
            );
          },
        ),
        _QuickActionCard(
          icon: Icons.map,
          title: 'Haritada Sorunlar',
          color: Colors.blueAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MapPage()),
            );
          },
        ),
        _QuickActionCard(
          icon: Icons.apartment,
          title: 'Belediye Çalışmaları',
          color: Colors.greenAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MunicipalityPage()),
            );
          },
        ),
        _QuickActionCard(
          icon: Icons.notifications_active,
          title: 'Anlık Malatya',
          color: Colors.redAccent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LiveMalatyaPage()),
            );
          },
        ),
      ],
    );
  }
}

/* ========================= */
/* HIZLI İŞLEM KARTI        */
/* ========================= */

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withOpacity(0.18),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.20),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 26, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
