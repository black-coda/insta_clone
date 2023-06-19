import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/state/auth/models/auth_result.dart';
import 'package:insta_clone/state/auth/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final currentAuthState = ref.watch(authStateProvider);
  return  currentAuthState.result == AuthResult.success;
});