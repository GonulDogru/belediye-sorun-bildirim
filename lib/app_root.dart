import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/home/home_page.dart';
import 'features/issue/issue_page.dart';
import 'features/profile/profile_page.dart';

// 🔴 ADMIN ROOT (birazdan yapacağız)
import 'features/admin/admin_root.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _index = 0;

  final List<Widget> _userPages = const [
    HomePage(),
    IssuePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final profileBox = Hive.box('profile');
    final String role = profileBox.get('role', defaultValue: 'user');

    // 🔴 ADMIN → AYRI PANEL
    if (role == 'admin') {
      return const AdminRoot();
    }

    // 🟢 USER → MEVCUT YAPI
    return Scaffold(
      extendBody: true, // 🔥 cam bar için şart
      body: _userPages[_index],
      bottomNavigationBar: _GlassBottomNav(
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
      ),
    );
  }
}

/* ===================== */
/* CAM BOTTOM NAV        */
/* ===================== */

class _GlassBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _GlassBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home,
                label: 'Ana Sayfa',
                index: 0,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.add_circle,
                label: 'Bildir',
                index: 1,
                isCenter: true,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.person,
                label: 'Profil',
                index: 2,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== */
/* NAV ITEM              */
/* ===================== */

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final bool isCenter;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isCenter ? 12 : 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Colors.white.withOpacity(0.25)
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              size: isCenter ? 32 : 26,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
