import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/state/auth/providers/auth_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
return authState.isLoading;
});
