import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/usersmodel.dart';

class UsersRepository extends ChangeNotifier {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static final User? _currentUser = _auth.currentUser;

  UsersModel currentUserData = UsersModel.empty();
  bool isLoading = true;

  Future<void> init() async {
    try {
      await getUserRecordById();
    } catch (e) {
      // Handle any error that occurred during SharedPreferences initialization
      if (kDebugMode) {
        print('Error user Repository: $e');
      }
    }
  }

// Save users data in firestore database

  static Future<void> saveUserRecord(UsersModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch user data according to User Id.

  Future<UsersModel> getUserRecordById() async {
    try {
      isLoading = true;
      notifyListeners();

      final documentSnapshot = await _db
          .collection("Users")
          .doc(UsersRepository._currentUser!.uid)
          .get();
      if (documentSnapshot.exists) {
        currentUserData = UsersModel.fromJson(documentSnapshot.data()!);
        isLoading = false;
        notifyListeners();
        return UsersModel.fromJson(documentSnapshot.data()!);
      } else {
        return UsersModel.empty();
      }
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }

  // Update user data
  Future<void> updateUserRecord(UsersModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
      notifyListeners();
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }

  // Update user field in specific users collection
  Future<void> updateUserSingleField(Map<String, dynamic> fieldData) async {
    try {
      await _db
          .collection("Users")
          .doc(UsersRepository._currentUser!.uid)
          .update(fieldData);
      notifyListeners();
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }

  // remove user
  Future<void> removeUserRecord() async {
    try {
      await _db
          .collection("Users")
          .doc(UsersRepository._currentUser!.uid)
          .delete();
      notifyListeners();
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      e.toString();
    }
  }
  // upload Image
}
