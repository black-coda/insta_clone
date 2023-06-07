import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:insta_clone/state/constants/firebase_field_name.dart';
import 'package:insta_clone/state/post/typedef/user_is.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.email: email ?? " ",
          FirebaseFieldName.displayName: displayName ?? "",
        });
}
