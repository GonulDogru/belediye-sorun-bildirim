# City Issue Tracker — 10 Tablo/Box Kanıt Dokümanı (Hive)

Bu doküman, projenin “en az 10 tablo/box + Mermaid ER diyagramı” şartını karşıladığını gösterir.

## 1) Mermaid ER Diyagramı (Doküman)

- Dosya: `docs/ERD.md`
- İçerik: 10 tablo/box ve ilişkiler (FK alanları) Mermaid ER ile çizilmiştir.

## 2) Box İsimleri (Tek Kaynak)

- Dosya: `lib/core/storage/boxes.dart`
- `Boxes.all` listesi (10 adet):
  1. users
  2. sessions
  3. profiles
  4. categories
  5. issues
  6. issue_photos
  7. issue_status_history
  8. issue_comments
  9. municipality_works
  10. announcements

## 3) Hive Modelleri ve TypeId Planı

> Not: Projede önceden var olan `UserProfile` modeli typeId=1 ile korunmuştur.

### Modeller (Dosya → typeId)

- `lib/models/user_profile.dart` → typeId: 1 (UserProfile)
- `lib/models/app_user.dart` → typeId: 2 (AppUser)
- `lib/models/session.dart` → typeId: 3 (Session)
- `lib/models/category.dart` → typeId: 4 (Category)
- `lib/models/issue.dart` → typeId: 5 (Issue)
- `lib/models/issue_photo.dart` → typeId: 6 (IssuePhoto)
- `lib/models/issue_status_history.dart` → typeId: 7 (IssueStatusHistory)
- `lib/models/issue_comment.dart` → typeId: 8 (IssueComment)
- `lib/models/municipality_work.dart` → typeId: 9 (MunicipalityWork)
- `lib/models/announcement.dart` → typeId: 10 (Announcement)

### Adapter dosyaları (otomatik üretim)

Her modelin karşılığında `*.g.dart` dosyası bulunur ve Hive TypeAdapter içerir.

## 4) İlişki Mantığı (FK Alan Örnekleri)

- Issue → User (1-N): `Issue.userId`
- Issue → Category (1-N): `Issue.categoryId`
- IssuePhoto → Issue (1-N): `IssuePhoto.issueId`
- IssueStatusHistory → Issue (1-N): `IssueStatusHistory.issueId`
- IssueComment → Issue (1-N): `IssueComment.issueId`
- MunicipalityWork → Category (1-N): `MunicipalityWork.categoryId`
- Announcement → Category (opsiyonel): `Announcement.categoryId`

## 5) Hive Kurulumu (Adapter + Box Açma)

- Dosya: `lib/core/storage/hive_init.dart`
- İşlev: `Hive.initFlutter()`, `Hive.registerAdapter(...)`, `Hive.openBox(...)` işlemlerini tek noktadan yönetir.
