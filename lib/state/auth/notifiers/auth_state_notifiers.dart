import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/config/extention_.dart';
import 'package:insta_clone/state/auth/backend/authenticator.dart';
import 'package:insta_clone/state/auth/models/auth_result.dart';
import 'package:insta_clone/state/auth/models/auth_state.dart';
import 'package:insta_clone/state/post/typedef/user_is.dart';
import 'package:insta_clone/state/user_info/backend/user_info.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator _authenticator = const Authenticator();
  final UserInfoStorage _userInfoStorage = const UserInfoStorage();
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

  Future<void> saveUserInformation({required UserId userId}) async {
    await _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email);
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(isLoading: true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(isLoading: true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      state.log();
      await saveUserInfo(userId: userId);
    }

    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithIsLoading(isLoading: true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      state.log();
      await saveUserInfo(userId: userId);
    } else {}

    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> saveUserInfo({required UserId userId}) async =>
      await _userInfoStorage.saveUserInfo(
          userId: userId,
          displayName: _authenticator.displayName,
          email: _authenticator.email);
}
