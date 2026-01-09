import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../shared/services/location_service.dart';
import '../issue/issue_model.dart';
import '../issue/issue_detail_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _defaultLocation = LatLng(
    38.3552,
    38.3095,
  ); // Malatya merkez

  LatLng? _currentLatLng;

  late final Box<IssueModel> issuesBox;

  @override
  void initState() {
    super.initState();
    issuesBox = Hive.box<IssueModel>('issues');
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    try {
      final position = await LocationService.getCurrentPosition();
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      debugPrint('Konum alınamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng mapCenter = _currentLatLng ?? _defaultLocation;

    return Scaffold(
      body: ValueListenableBuilder<Box<IssueModel>>(
        valueListenable: issuesBox.listenable(),
        builder: (context, box, _) {
          final markers = <Marker>[];

          /// 📍 Kullanıcı konumu
          markers.add(
            Marker(
              point: mapCenter,
              width: 40,
              height: 40,
              child: const Icon(
                Icons.my_location,
                color: Colors.redAccent,
                size: 36,
              ),
            ),
          );

          /// 🚧 Bildirilen sorunlar
          for (final issue in box.values) {
            markers.add(
              Marker(
                point: LatLng(issue.latitude, issue.longitude),
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IssueDetailPage(issue: issue),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.report_problem,
                    size: 36,
                    color: _statusColor(issue.status),
                  ),
                ),
              ),
            );
          }

          return FlutterMap(
            options: MapOptions(initialCenter: mapCenter, initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.city_issue_tracker_clean',
              ),
              MarkerLayer(markers: markers),
            ],
          );
        },
      ),
    );
  }

  /// 🎨 Sorun durumuna göre renk
  Color _statusColor(String status) {
    switch (status) {
      case 'resolved':
        return Colors.greenAccent;
      case 'inProgress':
        return Colors.blueAccent;
      default:
        return Colors.orangeAccent;
    }
  }
}
