import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/config/extention_.dart';
import 'package:insta_clone/state/auth/backend/authenticator.dart';
import 'package:insta_clone/state/auth/models/auth_result.dart';

import 'package:insta_clone/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator _authenticator = const Authenticator();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    // Instantiate Authenticator class

    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(isLoading: true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }


  Future <void> loginWithGoogle() async{
    state = state.copyWithIsLoading(isLoading: true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      state.log();
    } else {
      
    }
  }
}
