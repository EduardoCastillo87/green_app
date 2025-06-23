import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  bool _isInitialized = false;

  FirebaseService() {
    _initializeFirebase();
  }

  void _initializeFirebase() {
    try {
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _isInitialized = true;
    } catch (e) {
      print('⚠️  Firebase not available: $e');
      _isInitialized = false;
    }
  }

  // Check if Firebase is available
  bool get isAvailable => _isInitialized && _auth != null && _firestore != null;

  // Get current user
  User? get currentUser => _auth?.currentUser;

  // Stream of auth changes
  Stream<User?> get authStateChanges =>
      _auth?.authStateChanges() ?? Stream.value(null);

  // Sign up with email and password
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      UserCredential userCredential = await _auth!
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create user profile in Firestore
      await _firestore!.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });

      // Update display name
      await userCredential.user!.updateDisplayName(fullName);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An error occurred during registration: $e';
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      UserCredential userCredential = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update last login time
      await _firestore!
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'lastLogin': FieldValue.serverTimestamp()});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An error occurred during login: $e';
    }
  }

  // Sign out
  Future<void> signOut() async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      await _auth!.signOut();
    } catch (e) {
      throw 'An error occurred during sign out: $e';
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      await _auth!.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An error occurred while resetting password: $e';
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      DocumentSnapshot doc = await _firestore!
          .collection('users')
          .doc(uid)
          .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      throw 'An error occurred while fetching user data: $e';
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      await _firestore!.collection('users').doc(uid).update(data);
    } catch (e) {
      throw 'An error occurred while updating profile: $e';
    }
  }

  // Save user preferences
  Future<void> saveUserPreferences({
    required String uid,
    required Map<String, dynamic> preferences,
  }) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      await _firestore!.collection('users').doc(uid).update({
        'preferences': preferences,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'An error occurred while saving preferences: $e';
    }
  }

  // Get user preferences
  Future<Map<String, dynamic>?> getUserPreferences(String uid) async {
    if (!isAvailable) {
      throw 'Firebase is not configured. Please follow the setup guide in FIREBASE_SETUP.md';
    }

    try {
      DocumentSnapshot doc = await _firestore!
          .collection('users')
          .doc(uid)
          .get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      return data?['preferences'] as Map<String, dynamic>?;
    } catch (e) {
      throw 'An error occurred while fetching preferences: $e';
    }
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
