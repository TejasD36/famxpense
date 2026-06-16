import '../../../core.dart';
import '../../../features/notification/data/datasources/notification_local_datasource.dart';
import '../../../features/notification/data/datasources/remote/notification_remote_datasource.dart';

class NotificationService {
  final NotificationLocalDatasource _local;
  final NotificationRemoteDatasource _remote;

  NotificationService(this._local, this._remote);

  Future<void> _saveAndUpload(NotificationDto notification) async {
    await _local.saveNotification(notification);
    try {
      await _remote.uploadNotification(notification);
    } catch (_) {
      // Firestore upload is best-effort; notification is already saved locally
    }
    sl<RefreshNotifier>().notifyDataChanged();
  }

  Future<void> notifyExpenseAdded({
    required String title,
    required double amount,
    required String paidByUserId,
    required String paidByNickname,
    required List<String> participantUserIds,
    required String expenseId,
  }) async {
    for (final userId in participantUserIds) {
      if (userId == paidByUserId) continue;
      final notification = NotificationDto(
        id: const Uuid().v4(),
        userId: userId,
        type: NotificationType.expenseAdded,
        title: 'New Expense',
        message: '$paidByNickname added "$title" (₹${amount.toStringAsFixed(0)})',
        relatedId: expenseId,
        createdAt: DateTime.now(),
      );
      await _saveAndUpload(notification);
    }
  }

  Future<void> notifyPartnerRequest({
    required String receiverUserId,
    required String senderNickname,
    required String partnershipId,
  }) async {
    final notification = NotificationDto(
      id: const Uuid().v4(),
      userId: receiverUserId,
      type: NotificationType.partnerRequest,
      title: 'Partner Request',
      message: '$senderNickname wants to be your partner',
      relatedId: partnershipId,
      createdAt: DateTime.now(),
    );
    await _saveAndUpload(notification);
  }

  Future<void> notifyPartnerAccepted({
    required String senderUserId,
    required String accepterNickname,
    required String partnershipId,
  }) async {
    final notification = NotificationDto(
      id: const Uuid().v4(),
      userId: senderUserId,
      type: NotificationType.partnerRequest,
      title: 'Request Accepted',
      message: '$accepterNickname accepted your partner request',
      relatedId: partnershipId,
      createdAt: DateTime.now(),
    );
    await _saveAndUpload(notification);
  }

  Future<void> notifySettlement({
    required String fromUserId,
    required String toUserId,
    required String fromNickname,
    required String toNickname,
    required double amount,
    required String settlementId,
  }) async {
    final notification = NotificationDto(
      id: const Uuid().v4(),
      userId: toUserId,
      type: NotificationType.settlementConfirmed,
      title: 'Settlement Received',
      message: '$fromNickname settled ₹${amount.toStringAsFixed(0)} with you',
      relatedId: settlementId,
      createdAt: DateTime.now(),
    );
    await _saveAndUpload(notification);
  }
}
