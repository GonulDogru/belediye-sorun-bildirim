import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../shared/services/location_service.dart';
import 'issue_model.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({super.key});

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedImage;
  double? _lat;
  double? _lng;
  String? _addressText;

  String? _issueType; // 🔴 Sorun türü
  bool _imageError = false; // 🔴 foto hatası

  final List<String> _issueTypes = [
    'Kaldırım',
    'Yol',
    'Aydınlatma',
    'Çöp',
    'Su / Kanalizasyon',
    'Diğer',
  ];

  static const double _defaultLat = 38.3552;
  static const double _defaultLng = 38.3095;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    try {
      final position = await LocationService.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.first;

      if (!mounted) return;
      setState(() {
        _lat = position.latitude;
        _lng = position.longitude;
        _addressText =
            '${place.administrativeArea} / ${place.subAdministrativeArea} / ${place.locality ?? ''}';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _lat = _defaultLat;
        _lng = _defaultLng;
        _addressText = 'Malatya (varsayılan konum)';
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null && mounted) {
      setState(() {
        _selectedImage = File(image.path);
        _imageError = false;
      });
    }
  }

  void _submitIssue() {
    if (_selectedImage == null) {
      setState(() => _imageError = true);
      return;
    }

    if (_issueType == null ||
        _descriptionController.text.trim().isEmpty ||
        _lat == null ||
        _lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    _showConfirmDialog();
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sorunu Gönder'),
        content: const Text('Bu sorunu belediyeye göndermek istiyor musunuz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _saveIssue();
            },
            child: const Text('Gönder'),
          ),
        ],
      ),
    );
  }

  void _saveIssue() {
    final issue = IssueModel(
      id: const Uuid().v4(),
      description: _descriptionController.text.trim(),
      imagePath: _selectedImage!.path,
      latitude: _lat!,
      longitude: _lng!,
      address: _addressText ?? '',
      createdAt: DateTime.now(),
      status: 'received',
    );

    Hive.box<IssueModel>('issues').add(issue);

    _descriptionController.clear();
    setState(() {
      _selectedImage = null;
      _issueType = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sorun başarıyla gönderildi')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sorun Bildir'),
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
                children: [
                  // 📸 FOTOĞRAF
                  _GlassCard(
                    borderColor: _imageError ? Colors.redAccent : null,
                    child: Column(
                      children: [
                        _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  _selectedImage!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white12,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 48,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                        if (_imageError)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Fotoğraf eklemek zorunludur',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _pickImage(ImageSource.camera),
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Kamera',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Galeri',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔽 SORUN TÜRÜ
                  _GlassCard(
                    child: DropdownButtonFormField<String>(
                      value: _issueType,
                      dropdownColor: Colors.black87,
                      hint: const Text(
                        'Sorun Türü Seçin',
                        style: TextStyle(color: Colors.white70),
                      ),
                      items: _issueTypes
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _issueType = v),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📝 AÇIKLAMA
                  _GlassCard(
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Sorun açıklaması',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 📍 KONUM
                  _GlassCard(
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _addressText ?? 'Konum alınıyor...',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🚀 GÖNDER
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _submitIssue,
                      icon: const Icon(Icons.send),
                      label: const Text(
                        'Sorunu Gönder',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
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

/* ===================== */
/* CAM PANEL             */
/* ===================== */

class _GlassCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;

  const _GlassCard({required this.child, this.borderColor});

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
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(0.18),
              width: borderColor != null ? 2 : 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
