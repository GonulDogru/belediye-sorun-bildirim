import 'dart:ui';
import 'package:flutter/material.dart';

class MunicipalityPage extends StatelessWidget {
  const MunicipalityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Belediye Çalışmaları',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.15),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🌄 ARKA PLAN
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_malatya.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🌑 OVERLAY
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.18)),
          ),

          // 📄 İÇERİK
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _WorkCard(
                  imagePath: 'assets/images/work_road.jpg',
                  title: 'Yol Yenileme Çalışması',
                  description:
                      'Battalgazi ilçesinde bozulan yollar yenilenerek halkın hizmetine sunuldu.',
                  location: 'Battalgazi / Malatya',
                  year: '2024',
                ),
                SizedBox(height: 18),
                _WorkCard(
                  imagePath: 'assets/images/work_park.jpg',
                  title: 'Yeni Park Alanı',
                  description:
                      'Yeşilyurt bölgesinde vatandaşların kullanımına sunulan yeni park alanı tamamlandı.',
                  location: 'Yeşilyurt / Malatya',
                  year: '2024',
                ),
                SizedBox(height: 18),
                _WorkCard(
                  imagePath: 'assets/images/work_water.jpg',
                  title: 'Altyapı İyileştirmesi',
                  description:
                      'Şehir merkezinde su altyapısı iyileştirme çalışmaları başarıyla tamamlandı.',
                  location: 'Merkez / Malatya',
                  year: '2023',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================== */
/* ÇALIŞMA KARTI      */
/* ================== */

class _WorkCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String location;
  final String year;

  const _WorkCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.location,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// GÖRSEL
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 14),

          /// BAŞLIK
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          /// AÇIKLAMA
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Colors.white.withOpacity(0.85),
            ),
          ),

          const SizedBox(height: 14),

          /// ALT BİLGİ
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 15,
                color: Colors.greenAccent,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ),
              const Icon(
                Icons.check_circle,
                size: 15,
                color: Colors.greenAccent,
              ),
              const SizedBox(width: 4),
              Text(
                '$year • Tamamlandı',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ================== */
/* CAM KART           */
/* ================== */

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.28), // ⬅️ DAHA MAT
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.30)),
          ),
          child: child,
        ),
      ),
    );
  }
}
