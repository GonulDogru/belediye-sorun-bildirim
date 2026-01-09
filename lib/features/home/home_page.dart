import 'package:flutter/material.dart';

import '../widgets/touristic_slider.dart';
import '../widgets/quick_actions.dart';
import '../widgets/municipality_summary.dart';
import '../widgets/glass_panel.dart';
import '../profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Malatya',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.15),
        elevation: 0,

        // 🔥 SAĞ ÜST PROFİL İKONU
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.25),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      extendBodyBehindAppBar: true,

      body: Stack(
        children: [
          // Arka plan görseli
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_malatya.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Karartma overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),

          // İçerik
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MALATYA'YI KEŞFET
                  GlassPanel(child: TouristicSlider()),

                  const SizedBox(height: 24),

                  // HIZLI İŞLEMLER (BAŞLIK + KARTLAR)
                  GlassPanel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hızlı İşlemler',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12),
                        QuickActions(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // BELEDİYE ÇALIŞMALARI
                  GlassPanel(child: const MunicipalitySummary()),

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
