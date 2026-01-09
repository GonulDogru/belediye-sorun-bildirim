import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/theme/theme_controller.dart';
import '../issue/issue_model.dart';
import '../auth/login_page.dart';
import '../issue/issue_detail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const String _profileBoxName = 'profile';
  static const String _nameKey = 'fullName';

  // Issue status stringleri için sabitler (tek yerde yönetelim)
  static const String _statusReceived = 'received';
  static const String _statusInProgress = 'inProgress';
  static const String _statusResolved = 'resolved';

  String _getUserName(Box box) {
    return box.get(_nameKey, defaultValue: 'Misafir');
  }

  void _saveUserName(String name) {
    Hive.box(_profileBoxName).put(_nameKey, name);
  }

  // =========================
  // ✅ İSTATİSTİK HESAPLAMA
  // =========================
  int _countByStatus(Iterable<IssueModel> issues, String status) {
    int count = 0;
    for (final i in issues) {
      if ((i.status).toString() == status) count++;
    }
    return count;
  }

  // =========================
  // ✅ STATUS → UI BİLGİSİ
  // =========================
  ({String label, Color color, IconData icon}) _statusUi(String status) {
    switch (status) {
      case _statusInProgress:
        return (
          label: 'İnceleniyor',
          color: Colors.blueAccent,
          icon: Icons.search,
        );
      case _statusResolved:
        return (
          label: 'Çözüldü',
          color: Colors.greenAccent,
          icon: Icons.done_all,
        );
      default:
        return (
          label: 'Alındı',
          color: Colors.orangeAccent,
          icon: Icons.mark_email_read,
        );
    }
  }

  Widget _statusChip(String status) {
    final ui = _statusUi(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: ui.color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ui.color.withOpacity(0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ui.icon, size: 14, color: ui.color),
          const SizedBox(width: 6),
          Text(
            ui.label,
            style: TextStyle(
              color: ui.color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    String two(int n) => n < 10 ? '0$n' : '$n';
    return '${two(dt.day)}.${two(dt.month)}.${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final profileBox = Hive.box(_profileBoxName);
    final issuesBox = Hive.box<IssueModel>('issues');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profil'),
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
                  /// PROFİL HEADER
                  _GlassCard(
                    child: ValueListenableBuilder<Box<IssueModel>>(
                      valueListenable: issuesBox.listenable(),
                      builder: (_, box, __) {
                        final issues = box.values.toList();
                        final total = issues.length;

                        // ✅ Burada canlı sayıyoruz
                        final inProgressCount = _countByStatus(
                          issues,
                          _statusInProgress,
                        );
                        final resolvedCount = _countByStatus(
                          issues,
                          _statusResolved,
                        );

                        return Column(
                          children: [
                            const CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.person,
                                size: 42,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ValueListenableBuilder(
                              valueListenable: profileBox.listenable(
                                keys: [_nameKey],
                              ),
                              builder: (_, __, ___) {
                                return Text(
                                  _getUserName(profileBox),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Vatandaş',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _ProfileStat(
                                  icon: Icons.report_problem,
                                  label: 'Toplam',
                                  value: total,
                                  color: Colors.orangeAccent,
                                ),
                                _ProfileStat(
                                  icon: Icons.hourglass_top,
                                  label: 'İncelenen',
                                  value: inProgressCount, // ✅ canlı
                                  color: Colors.blueAccent,
                                ),
                                _ProfileStat(
                                  icon: Icons.check_circle,
                                  label: 'Çözüldü',
                                  value: resolvedCount, // ✅ canlı
                                  color: Colors.greenAccent,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _openEditProfile(context, profileBox),
                              icon: const Icon(Icons.edit, color: Colors.white),
                              label: const Text(
                                'Profili Düzenle',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// BİLDİRİLEN SORUNLAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bildirdiğim Sorunlar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Alındı / İnceleniyor / Çözüldü',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  _GlassCard(
                    child: ValueListenableBuilder<Box<IssueModel>>(
                      valueListenable: issuesBox.listenable(),
                      builder: (_, box, __) {
                        if (box.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Henüz bildirilmiş bir sorun yok.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        final issues = box.values.toList();

                        return Column(
                          children: issues.map((issue) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        IssueDetailPage(issue: issue),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.14),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.report_problem,
                                      color: Colors.orangeAccent,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            issue.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            issue.address,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            _formatDate(issue.createdAt),
                                            style: const TextStyle(
                                              color: Colors.white60,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // ✅ Sorunun yanında durum etiketi
                                    _statusChip(issue.status),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// AYARLAR
                  const _SectionTitle('Ayarlar'),
                  _GlassCard(
                    child: Column(
                      children: [
                        SwitchListTile(
                          value: ThemeController.isDark,
                          onChanged: ThemeController.setDark,
                          secondary: const Icon(
                            Icons.dark_mode,
                            color: Colors.white,
                          ),
                          title: const Text(
                            'Koyu Tema',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const Divider(color: Colors.white24),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                          ),
                          title: const Text(
                            'Çıkış Yap',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Hive.box('session').put('loggedIn', false);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                              (_) => false,
                            );
                          },
                        ),
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

  void _openEditProfile(BuildContext context, Box profileBox) {
    final controller = TextEditingController(text: _getUserName(profileBox));

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Center(
            child: _GlassCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Profili Düzenle',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Ad Soyad',
                      labelStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _saveUserName(controller.text.trim());
                        Navigator.pop(context);
                      },
                      child: const Text('Kaydet'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// DESTEK WIDGETLAR

class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const _ProfileStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
