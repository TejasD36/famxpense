# FamXpense - Agent Context

## Tech Stack
- Flutter cross-platform (Android, iOS, Web), Dart 3.11
- Firebase Auth + Firestore, Hive CE local storage
- flutter_bloc 9.x, go_router 17.x, get_it 9.x, freezed, json_serializable
- Clean Architecture (feature-first), offline-first expense sync

## Architecture
- **State**: flutter_bloc (Cubit/BLoC)
- **DI**: get_it service locator via `sl` (defined in `lib/core/di/injection.dart`, re-exported through `lib/core.dart`)
- **Routing**: go_router with `StatefulShellRoute.indexedStack` for bottom nav; standalone routes for add-expense, add-partner
- **Auth**: Firebase Auth (email/password) with Hive session persistence
- **Data**: Firestore remote → Hive local via SyncService (offline-first with merge strategy)
- **Codegen**: freezed + json_serializable via `build_runner`

## Key Fixes Applied

### Cross-screen Auto-refresh
- Created `RefreshNotifier` (ChangeNotifier) in `lib/core/services/refresh/refresh_notifier.dart` registered as lazy singleton in DI
- `AddExpenseBloc` calls `sl<RefreshNotifier>().notifyDataChanged()` on successful expense submission
- `HomeScreen` and `ActivityScreen` listen to `RefreshNotifier` in `initState` and reload bloc data on notification
- Replaced `RouteAware`/`RouteObserver` pattern (broken under GoRouter `StatefulShellRoute`) with this approach
- Removed `RouteObserver` registration from DI and GoRouter observers

### Partner Search
- `UserRemoteDatasourceImpl.searchUser()` falls back to `where('nickname', ...)` query when `nicknameLowercase` search returns empty results — handles legacy users registered before the `nicknameLowercase` field was added

### FAB Conflict
- Removed `FloatingActionButton` from `PartnersScreen`
- Added `IconButton(Icons.person_add_alt_1_rounded)` in AppBar `actions` with tooltip "Add Partner"
- `MainNavigation` retains its center-docked FAB for adding expenses

### Pull-to-Refresh
- Added `RefreshIndicator` to Connected and Requests tab views in `PartnersScreen`
- `_reloadPartners()` fires `PartnerEvent.loadPartners()` and waits for non-loading state via `stream.firstWhere`

## Build & Verify
- `flutter analyze lib/` — must pass with zero issues
- `flutter pub run build_runner build --delete-conflicting-outputs` — re-run after modifying any freezed/json_serializable model files

### Firestore participantIds Pattern (debt_ledgers, settlements, partnerships)
- Separate `allow read` lines for two-field OR collections DON'T work with Firestore collection queries — every field in a rule condition needs a `where` filter in the query
- Fix: `participantIds: [userA, userB]` array field, `.where('participantIds', arrayContains: userId)` query, `request.auth.uid in resource.data.participantIds` rule
- Applied to: debt_ledgers, settlements (entity + remote datasource), partnerships (remote DTO + remote datasource)
- PartnershipRemoteDto added `@Default([]) List<String> participantIds` (freezed → auto-serialized to/from Firestore)
- SettlementEntity: `_fromJson` fallback `[fromUserId, toUserId]` for legacy docs without the field
- `participantIds` field is **Firestore-only** — not stored in Hive (entity/remote-dto level only, not local DTO)

### Notification Sync
- `syncNotifications` filters `n.userId != userId` to skip uploading notifications that fail Firestore update rule (`auth.uid == resource.data.userId`)
- Remote notifications fetched for the current user are still saved locally

## Critical Context
- GoRouter's `StatefulShellRoute.indexedStack` does NOT fire `RouteAware.didPopNext()` on child routes — use `RefreshNotifier` instead
- Freezed classes use private variant names (`_Loading`, `_Loaded`, etc.) — cannot reference them from outside their library
- Hive box keys must match exactly (`userId`, not `user_id`)
