# Savings Sync + UI Redesign Plan

## Phase 1: Monthly Snapshot Firestore Sync

### 1a. Add `userId` to MonthlySavingDto + Entity
- `monthly_saving_dto.dart`: Add `@HiveField(10) @Default('') String userId`
- `monthly_saving_entity.dart`: Add `@Default('') String userId`
- `monthly_saving_mapper.dart`: Pass `userId` through in both directions
- Run `flutter pub run build_runner build --delete-conflicting-outputs`

### 1b. Create Remote Datasource
- New file: `lib/features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart`
  - Interface: `saveSnapshot(MonthlySavingDto)`, `fetchSnapshots(String userId)`
- New file: `lib/features/savings/data/datasources/remote/monthly_saving_remote_datasource_impl.dart`
  - Firestore collection `monthly_savings`, `.set()` on save, `.where('userId', ...)` on fetch

### 1c. Update SavingsRepositoryImpl
- Accept `MonthlySavingRemoteDatasource` in constructor
- `computeCurrentMonth()`: save locally with `syncStatus: pending` → upload → mark synced
- `finalizeMonth()`: update locally → upload to remote
- Set `userId` on snapshots from account's `userId`

### 1d. SyncService
- Add `syncMonthlySavings()` method (same pattern as `syncTransfers`)
- Call from `syncAll()` after `syncTransfers`

### 1e. Firestore Rules
```
match /monthly_savings/{snapshotId} {
  allow read: if request.auth != null
    && resource.data.userId == request.auth.uid;
  allow create: if request.auth.uid == request.resource.data.userId;
  allow update: if request.auth.uid == resource.data.userId;
  allow delete: if false;
}
```

### 1f. DI
- Register `MonthlySavingRemoteDatasource`
- Update `SavingsRepositoryImpl` registration to pass remote
- Pass to SyncService

### 1g. Xcore
- Add exports for new remote datasource files

## Phase 2: Savings Screen Redesign

### 2a. Summary Header
- Load all savings accounts, get current month snapshot for each
- Display:
  - "Total Goal: ₹X" (sum of `goalAmount`)
  - "Total Saved: ₹Y" (sum of `savedAmount`)
  - Linear progress bar: `(Y / X * 100).clamp(0, 100)` with color (red < 0, amber < 80%, green)
  - Achievement percentage text

### 2b. Per-Account Cards
- Each savings account as a card with:
  - Account name + current balance
  - Monthly goal vs saved (from snapshot)
  - Mini linear progress bar
  - On tap → `context.pushNamed(AppRoute.accountDetail.name, extra: account)`

### 2c. Timeline Section
- Scrollable list of months for current year (descending)
- Each month card shows:
  - Month name + year
  - Total saved across all savings accounts
  - Negative months highlighted in red with warning icon
  - On tap → could show per-account breakdown for that month

### 2d. Auto-refresh
- Listen to `RefreshNotifier` in `initState`, reload on notify

## Files to Modify
- `lib/shared/data/transformers/dtos/savings/monthly_saving_dto.dart`
- `lib/shared/domain/entities/savings/monthly_saving_entity.dart`
- `lib/shared/data/transformers/mappers/savings/monthly_saving_mapper.dart`
- `lib/features/savings/xcore.dart`
- `lib/features/savings/domain/repositories/savings_repository.dart`
- `lib/features/savings/data/repositories/savings_repository_impl.dart`
- `lib/features/savings/presentation/screens/savings_list_screen.dart`
- `lib/core/di/injection.dart`
- `lib/core/services/sync/sync_service.dart`
- `firestore.rules`
- `test/mocks.dart` (MonthlySavingDto fallback userId)

## New Files
- `lib/features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart`
- `lib/features/savings/data/datasources/remote/monthly_saving_remote_datasource_impl.dart`

## Verify
- `flutter pub run build_runner build --delete-conflicting-outputs`
- `flutter analyze lib/` — 0 errors, 0 warnings
- `flutter test` — all tests pass
