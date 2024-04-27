import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:symphonicdiagnosis/models/usersmodel.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    User? user = _auth.currentUser;
    return user;
  }

  Future<String?> getCurrentUserId() async {
    User? user = await getCurrentUser();
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<UsersModel?> getUsersData() async {
    try {
      String? userId = await getCurrentUserId();

      if (userId != null) {
        DocumentSnapshot? snapshot = await getUserData(userId);
        if (snapshot != null && snapshot.exists) {
          UsersModel userModel =
              UsersModel.fromJson(snapshot.data() as Map<String, dynamic>);

          return userModel;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving user data: $e');
      }
    }
    return null;
  }

  Future<DocumentSnapshot?> getUserData(String userId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('Users').doc(userId).get();
    return snapshot;
  }
}
