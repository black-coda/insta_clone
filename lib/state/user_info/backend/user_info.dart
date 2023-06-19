import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:insta_clone/config/extention_.dart';
import 'package:insta_clone/state/constants/firebase_collection_name.dart';
import 'package:insta_clone/state/constants/firebase_field_name.dart';
import 'package:insta_clone/state/post/typedef/user_is.dart';
import 'package:insta_clone/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  static final db = FirebaseFirestore.instance;

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    
    try {
      final userInfo = await db
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      //? User already exist
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      //? User doesn't exist, creating new user
      final payload = UserInfoPayLoad(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await db.collection(FirebaseCollectionName.users).add(payload);
      return true;
    } catch (e) {
      e.log();
      e.toString().log();
      return false;
    }
  }
}
