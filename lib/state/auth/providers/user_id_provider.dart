import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/state/auth/providers/auth_state_provider.dart';
import 'package:insta_clone/state/post/typedef/user_is.dart';

final userIdProvider = Provider<UserId?>((ref) {
  //? This will be returning a type of UserId? which is basically still a String
  return ref.watch(authStateProvider).userId;
});
