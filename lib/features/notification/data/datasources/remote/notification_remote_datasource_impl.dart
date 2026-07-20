import '../../../xcore.dart';

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  final FirebaseFirestore _firestore;

  NotificationRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'notifications';

  @override
  Future<void> uploadNotification(NotificationDto notification) async {
    await _firestore.collection(_collection).doc(notification.id).set(notification.toJson());
  }

  @override
  Future<List<NotificationDto>> fetchNotifications({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => NotificationDto.fromJson(doc.data())).toList();
  }

  @override
  Stream<List<NotificationDto>> streamNotifications({required String userId}) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs
          .map((doc) => NotificationDto.fromJson(doc.data()))
          .toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }
}
