import 'dart:ui';
import 'package:flutter/material.dart';

class LiveMalatyaPage extends StatefulWidget {
  const LiveMalatyaPage({super.key});

  @override
  State<LiveMalatyaPage> createState() => _LiveMalatyaPageState();
}

class _LiveMalatyaPageState extends State<LiveMalatyaPage> {
  AlertType _filter = AlertType.all;

  // Şimdilik statik veri (Firebase sonrası burası canlı olacak)
  final List<LiveAlert> _items = const [
    LiveAlert(
      id: '1',
      type: AlertType.water,
      title: 'Planlı Su Kesintisi',
      district: 'Battalgazi',
      neighborhood: 'Üniversite Mahallesi',
      timeRange: '13:00 – 16:00',
      description:
          'Şebeke bakım çalışması nedeniyle belirtilen saat aralığında su kesintisi yaşanacaktır.',
      createdLabel: 'Bugün • 10:12',
      isUrgent: false,
    ),
    LiveAlert(
      id: '2',
      type: AlertType.traffic,
      title: 'Yol Çalışması',
      district: 'Yeşilyurt',
      neighborhood: 'Çilesiz',
      timeRange: '09:00 – 18:00',
      description:
          'Asfalt yenileme çalışması nedeniyle İnönü Caddesi araç trafiğine kapalı olacaktır. Alternatif güzergahları kullanınız.',
      createdLabel: 'Bugün • 08:35',
      isUrgent: false,
    ),
    LiveAlert(
      id: '3',
      type: AlertType.electric,
      title: 'Elektrik Kesintisi (Planlı)',
      district: 'Merkez',
      neighborhood: 'Fuzuli',
      timeRange: '14:30 – 17:00',
      description:
          'Trafo bakım çalışması nedeniyle bölgesel elektrik kesintisi uygulanacaktır.',
      createdLabel: 'Bugün • 11:05',
      isUrgent: false,
    ),
    LiveAlert(
      id: '4',
      type: AlertType.general,
      title: 'Belediye Duyurusu',
      district: 'Battalgazi',
      neighborhood: 'Merkez',
      timeRange: '—',
      description:
          'Hafta sonu düzenlenecek etkinlik nedeniyle çevre yollarında kısa süreli yoğunluk yaşanabilir.',
      createdLabel: 'Dün • 19:20',
      isUrgent: false,
    ),
    LiveAlert(
      id: '5',
      type: AlertType.emergency,
      title: 'Acil Uyarı',
      district: 'Yeşilyurt',
      neighborhood: 'Yakınca',
      timeRange: 'Şu an',
      description:
          'Yoğun yağış nedeniyle bazı bölgelerde geçici su birikintileri oluşabilir. Lütfen dikkatli olunuz.',
      createdLabel: 'Bugün • 12:40',
      isUrgent: true,
    ),
  ];

  List<LiveAlert> get _filtered {
    if (_filter == AlertType.all) return _items;
    return _items.where((e) => e.type == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Anlık Malatya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.15),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🌄 Arka plan
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_malatya.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🌑 Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.18)),
          ),

          // İçerik
          SafeArea(
            child: Column(
              children: [
                // Filtreler
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: _GlassCard(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _FilterChip(
                            label: 'Hepsi',
                            selected: _filter == AlertType.all,
                            onTap: () =>
                                setState(() => _filter = AlertType.all),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Su',
                            selected: _filter == AlertType.water,
                            onTap: () =>
                                setState(() => _filter = AlertType.water),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Trafik',
                            selected: _filter == AlertType.traffic,
                            onTap: () =>
                                setState(() => _filter = AlertType.traffic),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Elektrik',
                            selected: _filter == AlertType.electric,
                            onTap: () =>
                                setState(() => _filter = AlertType.electric),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Genel',
                            selected: _filter == AlertType.general,
                            onTap: () =>
                                setState(() => _filter = AlertType.general),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Acil',
                            selected: _filter == AlertType.emergency,
                            onTap: () =>
                                setState(() => _filter = AlertType.emergency),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Liste
                Expanded(
                  child: list.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              'Şu anda bu kategoride bir duyuru bulunmuyor.',
                              style: TextStyle(color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          itemCount: list.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, i) => _AlertCard(alert: list[i]),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ========================= */
/* Model + Enum              */
/* ========================= */

enum AlertType { all, water, traffic, electric, general, emergency }

class LiveAlert {
  final String id;
  final AlertType type;
  final String title;
  final String district;
  final String neighborhood;
  final String timeRange;
  final String description;
  final String createdLabel;
  final bool isUrgent;

  const LiveAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.district,
    required this.neighborhood,
    required this.timeRange,
    required this.description,
    required this.createdLabel,
    required this.isUrgent,
  });
}

/* ========================= */
/* UI Widgets                */
/* ========================= */

class _AlertCard extends StatelessWidget {
  final LiveAlert alert;
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final meta = _AlertMeta.fromType(alert.type);

    return _GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sol ikon alanı
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: meta.color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: meta.color.withOpacity(0.35)),
            ),
            child: Icon(meta.icon, color: meta.color),
          ),
          const SizedBox(width: 12),

          // İçerik
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Üst satır: Başlık + rozet
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        alert.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    if (alert.isUrgent)
                      _Badge(text: 'Acil', color: Colors.redAccent)
                    else
                      _Badge(text: meta.label, color: meta.color),
                  ],
                ),
                const SizedBox(height: 6),

                // Konum + saat
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 14,
                      color: Colors.white.withOpacity(0.75),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${alert.district} • ${alert.neighborhood}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.80),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: Colors.white.withOpacity(0.70),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      alert.timeRange,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      alert.createdLabel,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.60),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Açıklama
                Text(
                  alert.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withOpacity(0.22)
              : Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? Colors.white.withOpacity(0.35)
                : Colors.white.withOpacity(0.18),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _AlertMeta {
  final String label;
  final IconData icon;
  final Color color;

  const _AlertMeta({
    required this.label,
    required this.icon,
    required this.color,
  });

  factory _AlertMeta.fromType(AlertType type) {
    switch (type) {
      case AlertType.water:
        return const _AlertMeta(
          label: 'Su',
          icon: Icons.water_drop,
          color: Colors.lightBlueAccent,
        );
      case AlertType.traffic:
        return const _AlertMeta(
          label: 'Trafik',
          icon: Icons.traffic,
          color: Colors.orangeAccent,
        );
      case AlertType.electric:
        return const _AlertMeta(
          label: 'Elektrik',
          icon: Icons.bolt,
          color: Colors.amberAccent,
        );
      case AlertType.general:
        return const _AlertMeta(
          label: 'Genel',
          icon: Icons.campaign,
          color: Colors.greenAccent,
        );
      case AlertType.emergency:
        return const _AlertMeta(
          label: 'Acil',
          icon: Icons.warning_amber,
          color: Colors.redAccent,
        );
      case AlertType.all:
        return const _AlertMeta(
          label: 'Hepsi',
          icon: Icons.notifications,
          color: Colors.white,
        );
    }
  }
}

/* ========================= */
/* Glass Card                */
/* ========================= */

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.26), // mat + şık
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.28)),
          ),
          child: child,
        ),
      ),
    );
  }
}
