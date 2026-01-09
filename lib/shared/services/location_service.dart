import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Konum servisleri kapalı');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Konum izni verilmedi');
    }

    // 1️⃣ Önce AKTİF (canlı) konumu iste
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 8),
      );
    } catch (_) {
      // 2️⃣ Aktif konum alınamazsa SON BİLİNEN konum
      final Position? lastKnown = await Geolocator.getLastKnownPosition();

      if (lastKnown != null) {
        return lastKnown;
      }

      // 3️⃣ Hiçbiri yoksa hata fırlat
      throw Exception('Konum alınamadı');
    }
  }
}
