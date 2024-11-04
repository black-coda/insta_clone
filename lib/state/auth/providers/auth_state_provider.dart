import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/state/auth/models/auth_state.dart';
import 'package:insta_clone/state/auth/notifiers/auth_state_notifiers.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
