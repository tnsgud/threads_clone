import 'package:threads_clone/views/create_account_screen.dart';
import 'package:threads_clone/views/sign_in_screen.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/widgets/custom_bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/view_models/user_config.dart';
import 'package:threads_clone/views/activity_screen.dart';
import 'package:threads_clone/views/home_screen.dart';
import 'package:threads_clone/views/profile_screen.dart';
import 'package:threads_clone/views/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, navigationShell) {
        return Scaffold(
          key: state.pageKey,
          body: SafeArea(child: navigationShell),
          bottomNavigationBar: const CustomBottomNavigation(),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/activity',
          name: 'activity',
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        )
      ],
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/create-account',
      name: 'create-account',
      builder: (context, state) => const CreateAccountScreen(),
    )
  ],
);

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserModel>(
  (ref) => UserViewModel(
    UserModel(isDarkMode: false),
  ),
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(userViewModelProvider);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: user.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          routerConfig: _router,
        );
      },
    );
  }
}
