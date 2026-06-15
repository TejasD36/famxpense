import '../../../../core.dart';

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseFirestore _firestore;

  UserRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'users';

  @override
  Future<UserRemoteDto?> getUser(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    final data = doc.data();
    if (data == null) return null;
    return UserRemoteDto.fromJson(data);
  }

  @override
  Future<UserRemoteDto?> searchUser({required String query, required String currentUserId}) async {
    AppLogger.firebase('Searching user: $query');

    QuerySnapshot<Map<String, dynamic>> snapshot;

    /// EMAIL SEARCH

    if (query.contains('@')) {
      snapshot = await _firestore.collection(_collection).where('email', isEqualTo: query.trim()).limit(1).get();
    } else {
      /// NICKNAME SEARCH

      snapshot = await _firestore.collection(_collection).where('nicknameLowercase', isEqualTo: query.toLowerCase().trim()).limit(1).get();

      if (snapshot.docs.isEmpty) {
        snapshot = await _firestore.collection(_collection).where('nickname', isEqualTo: query.trim()).limit(1).get();
      }
    }

    if (snapshot.docs.isEmpty) {
      AppLogger.warning('User not found');

      return null;
    }

    final user = UserRemoteDto.fromJson(snapshot.docs.first.data());

    /// PREVENT SELF SEARCH

    if (user.id == currentUserId) {
      AppLogger.warning('Self search prevented');

      return null;
    }

    AppLogger.success(
      'User found: '
      '${user.nickname}',
    );

    return user;
  }
}
