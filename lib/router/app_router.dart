import 'package:fleegram/core/utils/session_manager.dart';
import 'package:fleegram/data/models/story_model.dart';
import 'package:fleegram/presentation/pages/detail_story_page.dart';
import 'package:fleegram/presentation/pages/home_page.dart';
import 'package:fleegram/presentation/pages/login_page.dart';
import 'package:fleegram/presentation/pages/post_story_page.dart';
import 'package:fleegram/presentation/pages/register_page.dart';
import 'package:fleegram/presentation/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final loggedIn = SessionManager.isLoggedIn;
    final location = state.uri.path;

    final publicRoutes = ['/login', '/register'];

    if (!loggedIn && !publicRoutes.contains(location)) return '/login';
    if (loggedIn && publicRoutes.contains(location)) return '/';
    return null;
  },
  routes: [
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
  ],
);
