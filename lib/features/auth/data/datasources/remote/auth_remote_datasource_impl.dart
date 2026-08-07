import '../../../xcore.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  static const _usersCollection = 'users';

  @override
  Future<UserDto> register({
    required String name,
    required String nickname,
    required String email,
    required String password,
  }) async {
    /// CREATE AUTH ACCOUNT FIRST (no Firestore access needed)

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw Exception('Registration failed: no user returned from Firebase');
    }

    /// CHECK NICKNAME EXISTS (now authenticated)

    final nicknameQuery = await _firestore
        .collection(_usersCollection)
        .where('nickname', isEqualTo: nickname.trim().toLowerCase())
        .limit(1)
        .get();

    if (nicknameQuery.docs.isNotEmpty) {
      await firebaseUser.delete();
      throw Exception('Nickname already taken');
    }

    final now = DateTime.now().toUtc();

    final userDto = UserDto(
      id: firebaseUser.uid,
      name: name.trim(),
      nickname: nickname.trim().toLowerCase(),
      email: email.trim(),
      createdAt: now,
      updatedAt: now,
    );

    /// STORE USER

    try {
      await _firestore
          .collection(_usersCollection)
          .doc(firebaseUser.uid)
          .set(userDto.toJson());
    } catch (e) {
      /// CLEANUP: remove Firebase Auth user if Firestore write fails
      await firebaseUser.delete();
      rethrow;
    }

    return userDto;
  }

  @override
  Future<UserDto> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw Exception('Login failed: no user returned from Firebase');
    }

    final doc = await _firestore
        .collection(_usersCollection)
        .doc(firebaseUser.uid)
        .get();

    final data = doc.data();
    if (data == null) {
      throw Exception('User data not found. Please contact support.');
    }

    return UserDto.fromJson(data);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserDto?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) return null;

    final doc = await _firestore
        .collection(_usersCollection)
        .doc(firebaseUser.uid)
        .get();

    if (!doc.exists) return null;

    final data = doc.data();
    if (data == null) return null;

    return UserDto.fromJson(data);
  }
}
