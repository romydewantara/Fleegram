import 'package:fleegram/core/utils/session_manager.dart';
import 'package:fleegram/data/repositories/auth_repository.dart';
import 'package:fleegram/data/repositories/story_repository.dart';
import 'package:fleegram/presentation/providers/auth_provider.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.loadSession();
  await initializeDateFormatting('id_ID', null);

  runApp(const Fleegram());
}

/// Created by: Romy
class Fleegram extends StatelessWidget {
  const Fleegram({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => AuthRepository()),
        Provider<StoryRepository>(create: (_) => StoryRepository()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryProvider(context.read<StoryRepository>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Fleegram',
        routerConfig: router,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      ),
    );
  }
}
