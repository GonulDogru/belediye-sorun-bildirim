import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';

// Mevcut issue modeli (features içinde)
import '../../features/issue/issue_model.dart';

// Yeni 10 tablo modellerin
import '../../models/user_profile.dart';
import '../../models/app_user.dart';
import '../../models/session.dart';
import '../../models/category.dart';
import '../../models/issue.dart';
import '../../models/issue_photo.dart';
import '../../models/issue_status_history.dart';
import '../../models/issue_comment.dart';
import '../../models/municipality_work.dart';
import '../../models/announcement.dart';

class HiveInit {
  HiveInit._();

  static Future<void> init() async {
    await Hive.initFlutter();

    // 1) Mevcut projede kullanılan IssueModel (typeId: 0) – geriye uyumluluk
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(IssueModelAdapter());
    }

    // 2) 10 tablo modelleri (typeId çakışmamalı)
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(UserProfileAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(AppUserAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(SessionAdapter());
    if (!Hive.isAdapterRegistered(4)) Hive.registerAdapter(CategoryAdapter());
    if (!Hive.isAdapterRegistered(5)) Hive.registerAdapter(IssueAdapter());
    if (!Hive.isAdapterRegistered(6)) Hive.registerAdapter(IssuePhotoAdapter());
    if (!Hive.isAdapterRegistered(7))
      Hive.registerAdapter(IssueStatusHistoryAdapter());
    if (!Hive.isAdapterRegistered(8))
      Hive.registerAdapter(IssueCommentAdapter());
    if (!Hive.isAdapterRegistered(9))
      Hive.registerAdapter(MunicipalityWorkAdapter());
    if (!Hive.isAdapterRegistered(10))
      Hive.registerAdapter(AnnouncementAdapter());

    // 3) Box açma
    // Not: openBox async olduğu için burada await ediyoruz; bu yüzden main’de FutureBuilder kullanacağız.
    for (final name in Boxes.all) {
      if (Hive.isBoxOpen(name)) continue;

      if (name == 'issues') {
        // Uygulamadaki mevcut issue akışı IssueModel kullanıyor
        await Hive.openBox<IssueModel>('issues');
      } else {
        await Hive.openBox(name);
      }
    }

    // 4) Mevcut projede kullanılan ekstra box adları (Boxes.all içinde yoksa)
    // "profile" ve "issues" eski sistemde kullanılıyor olabilir.
    if (!Hive.isBoxOpen('profile')) {
      await Hive.openBox('profile');
    }

    if (!Hive.isBoxOpen('session')) {
      await Hive.openBox('session');
    }
  }
}
