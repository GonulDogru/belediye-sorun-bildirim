# City Issue Tracker — ER Diyagramı (Hive Box Tasarımı)

Bu doküman Hive box (tablo) tasarımını ve ilişkileri göstermektedir.
İlişkiler id (FK) üzerinden kuruludur (issue.userId, issue.categoryId vb.).

## Tablolar / Box'lar (10 adet)

- users
- sessions
- profiles
- issues
- issue_photos
- issue_status_history
- issue_comments
- categories
- municipality_works
- announcements

## Mermaid ER Diyagramı

```mermaid
erDiagram
  USERS {
    string id PK
    string email
    string passwordHash
    string role
    boolean isActive
    datetime createdAt
    datetime updatedAt
  }

  PROFILES {
    string id PK
    string userId FK
    string fullName
    string phone
    string avatarPath
    string addressText
    datetime createdAt
    datetime updatedAt
  }

  SESSIONS {
    string id PK
    string userId FK
    string deviceId
    string deviceName
    string refreshToken
    datetime lastLoginAt
    datetime expiresAt
    boolean isRevoked
  }

  CATEGORIES {
    string id PK
    string name
    string description
    string iconKey
    boolean isActive
    datetime createdAt
    datetime updatedAt
  }

  ISSUES {
    string id PK
    string userId FK
    string categoryId FK
    string assignedAdminId FK
    string relatedWorkId FK
    string title
    string description
    string status
    string priority
    double latitude
    double longitude
    string addressText
    datetime createdAt
    datetime updatedAt
    datetime closedAt
  }

  ISSUE_PHOTOS {
    string id PK
    string issueId FK
    string localPath
    string caption
    datetime takenAt
    datetime createdAt
    double lat
    double lng
  }

  ISSUE_STATUS_HISTORY {
    string id PK
    string issueId FK
    string changedByUserId FK
    string fromStatus
    string toStatus
    string note
    datetime changedAt
  }

  ISSUE_COMMENTS {
    string id PK
    string issueId FK
    string userId FK
    string message
    boolean isInternal
    datetime createdAt
    datetime updatedAt
  }

  MUNICIPALITY_WORKS {
    string id PK
    string categoryId FK
    string createdByAdminId FK
    string relatedIssueId FK
    string title
    string description
    string status
    datetime startDate
    datetime endDate
    double latitude
    double longitude
    string addressText
    datetime createdAt
    datetime updatedAt
  }

  ANNOUNCEMENTS {
    string id PK
    string createdByAdminId FK
    string categoryId FK
    string title
    string content
    boolean isPublished
    datetime publishAt
    datetime createdAt
    datetime updatedAt
  }

  USERS ||--|| PROFILES : has
  USERS ||--o{ SESSIONS : opens
  USERS ||--o{ ISSUES : reports
  CATEGORIES ||--o{ ISSUES : classifies

  ISSUES ||--o{ ISSUE_PHOTOS : has
  ISSUES ||--o{ ISSUE_COMMENTS : receives
  USERS ||--o{ ISSUE_COMMENTS : writes

  ISSUES ||--o{ ISSUE_STATUS_HISTORY : tracks
  USERS ||--o{ ISSUE_STATUS_HISTORY : changes

  USERS ||--o{ ANNOUNCEMENTS : publishes
  CATEGORIES ||--o{ ANNOUNCEMENTS : tags

  CATEGORIES ||--o{ MUNICIPALITY_WORKS : groups
  USERS ||--o{ MUNICIPALITY_WORKS : creates
  ISSUES ||--o{ MUNICIPALITY_WORKS : relates
```
