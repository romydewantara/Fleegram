import 'package:fleegram/core/app_state.dart';
import 'package:fleegram/core/utils/session_manager.dart';
import 'package:fleegram/data/models/story_model.dart';
import 'package:fleegram/presentation/pages/detail_story_page.dart';
import 'package:fleegram/presentation/pages/home_page.dart';
import 'package:fleegram/presentation/pages/login_page.dart';
import 'package:fleegram/presentation/pages/post_story_page.dart';
import 'package:fleegram/presentation/pages/register_page.dart';
import 'package:fleegram/presentation/pages/settings_page.dart';
import 'package:fleegram/presentation/pages/splash_page.dart';
import 'package:fleegram/presentation/widgets/paid_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/splash',
  refreshListenable: appState,
  redirect: (context, state) {
    final loggedIn = SessionManager.isLoggedIn;
    final splashDone = appState.splashDone;
    final location = state.uri.path;

    if (!splashDone) return '/splash';

    if (location == '/splash') return loggedIn ? '/' : '/login';

    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (_, _) => const SplashPage()),
    GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
    GoRoute(path: '/register', builder: (_, _) => const RegisterPage()),
    GoRoute(path: '/', builder: (_, _) => const HomePage()),
    GoRoute(
      path: '/detail',
      builder: (_, state) {
        final story = state.extra as Story;
        return DetailStoryPage(story: story);
      },
    ),
    GoRoute(path: '/post', builder: (_, _) => const PostStoryPage()),
    GoRoute(path: '/setting', builder: (_, _) => const SettingsPage()),
    GoRoute(
      path: '/paid-info',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black54,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                ),
                child: child,
              ),
            );
          },
          child: const PaidInfoDialog(),
        );
      },
    ),
  ],
);
