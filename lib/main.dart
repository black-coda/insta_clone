import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/config/theme_.dart';
import 'package:insta_clone/state/auth/providers/auth_state_provider.dart';
import 'package:insta_clone/state/auth/providers/is_logged_in_provider.dart';
import 'package:insta_clone/state/providers/is_loading_provider.dart';
import 'package:insta_clone/views/components/loading/loading_screen_widget.dart';
// import 'config/theme_.dart';
import 'firebase_options.dart';
import 'views/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: customTheme,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          //* displaying the loading screen
          // ref.listen<bool>(
          //   isLoadingProvider,
          //   (previous, isLoading) {
          //     if (isLoading) {
          //       LoadingScreenWidget.instance().show(context: context);
          //     } else {
          //       LoadingScreenWidget.instance().hide();
          //     }
          //   },
          // );

          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreenWidget.instance().show(
                  context: context,
                );
              } else {
                LoadingScreenWidget.instance().hide();
              }
            },
          );

          final isLoggedIn = ref.watch(isLoggedInProvider);
          return isLoggedIn ? const MainView() : const LoginView();
        },
      ),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("M A I N - V I E W")),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("Logout"),
              onPressed: () async {
                LoadingScreenWidget.instance().show(context: context);
                return ref.watch(authStateProvider.notifier).logOut();
              },
            ),
          ]),
    );
  }
}
