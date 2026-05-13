import '../../core.dart';

part 'sync_status.g.dart';

@HiveType(typeId: HiveTypeIds.syncStatus)
enum SyncStatus {
  @HiveField(0)
  synced,

  @HiveField(1)
  pending,

  @HiveField(2)
  failed,
}
