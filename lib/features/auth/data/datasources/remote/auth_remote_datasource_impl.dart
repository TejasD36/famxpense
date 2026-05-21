import '../../../xcore.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasourceImpl({required FirebaseAuth firebaseAuth, required FirebaseFirestore firestore})
    : _firebaseAuth = firebaseAuth,
      _firestore = firestore;

  static const _usersCollection = 'users';

  @override
  Future<UserDto> register({required String name, required String nickname, required String email, required String password}) async {
    /// CHECK NICKNAME EXISTS

    final nicknameQuery = await _firestore.collection(_usersCollection).where('nickname', isEqualTo: nickname.trim()).limit(1).get();

    if (nicknameQuery.docs.isNotEmpty) {
      throw Exception('Nickname already taken');
    }

    /// CREATE AUTH ACCOUNT

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password);

    final firebaseUser = credential.user!;

    final now = DateTime.now();

    final userDto = UserDto(
      id: firebaseUser.uid,

      name: name.trim(),

      nickname: nickname.trim(),

      email: email.trim(),

      createdAt: now,

      updatedAt: now,
    );

    /// STORE USER

    await _firestore.collection(_usersCollection).doc(firebaseUser.uid).set(userDto.toJson());

    return userDto;
  }

  @override
  Future<UserDto> login({required String email, required String password}) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    final firebaseUser = credential.user!;

    final doc = await _firestore.collection(_usersCollection).doc(firebaseUser.uid).get();

    return UserDto.fromJson(doc.data()!);
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

    final doc = await _firestore.collection(_usersCollection).doc(firebaseUser.uid).get();

    if (!doc.exists) return null;

    return UserDto.fromJson(doc.data()!);
  }
}
