 import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const userId = 'uid';
  static const postId = "post_id";
  static const comment = "comment";
  static const createdAt = "created_at";
  static const date = "date";
  static const displayName = "display_name";
  static const email = "email";

  //? Private class
  const FirebaseCollectionName._();
}
