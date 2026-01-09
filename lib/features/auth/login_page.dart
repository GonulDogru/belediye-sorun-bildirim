import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../app_root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tcController = TextEditingController();
  final _passwordController = TextEditingController();

  static const String _adminTc = '19769072944';

  String _simulatedNameFromTc(String tc) {
    if (tc == _adminTc) {
      return 'Malatya Belediyesi';
    }
    return 'Vatandaş ${tc.substring(0, 3)}';
  }

  String? _errorText;
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _errorText = null);

    final tc = _tcController.text.trim();
    final password = _passwordController.text.trim();

    if (tc.length != 11 || int.tryParse(tc) == null) {
      setState(() => _errorText = 'TC Kimlik Numarası 11 haneli olmalıdır.');
      return;
    }

    if (password.isEmpty) {
      setState(() => _errorText = 'Şifre boş bırakılamaz.');
      return;
    }

    setState(() => _loading = true);

    // ⏳ e-Devlet simülasyonu
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // 🔐 SESSION KAYDI
    final sessionBox = Hive.box('session');
    sessionBox.put('loggedIn', true);

    // 👤 PROFİL + ROL KAYDI
    final profileBox = Hive.box('profile');
    final role = tc == _adminTc ? 'admin' : 'user';

    profileBox.put('fullName', _simulatedNameFromTc(tc));
    profileBox.put('tc', tc);
    profileBox.put('role', role);

    setState(() => _loading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AppRoot()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 🌄 ARKA PLAN
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_malatya.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🌑 Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          // 📄 FORM
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _GlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.account_balance,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'e-Devlet Girişi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Bu bir simülasyondur',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),

                      const SizedBox(height: 24),

                      _InputField(
                        controller: _tcController,
                        label: 'TC Kimlik No',
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                      ),

                      const SizedBox(height: 12),

                      _InputField(
                        controller: _passwordController,
                        label: 'e-Devlet Şifresi',
                        obscure: true,
                      ),

                      if (_errorText != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _errorText!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Giriş Yap',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== */
/* CAM PANEL             */
/* ===================== */

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}

/* ===================== */
/* INPUT FIELD           */
/* ===================== */

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType? keyboardType;
  final int? maxLength;

  const _InputField({
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
