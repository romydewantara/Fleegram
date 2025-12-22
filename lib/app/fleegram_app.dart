import 'package:fleegram/app/theme/app_theme.dart';
import 'package:fleegram/core/network/api_client.dart';
import 'package:fleegram/core/network/multipart_client.dart';
import 'package:fleegram/data/repositories/auth_repository.dart';
import 'package:fleegram/data/repositories/story_repository.dart';
import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/auth_provider.dart';
import 'package:fleegram/presentation/providers/locale_provider.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/presentation/providers/theme_provider.dart';
import 'package:fleegram/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

/// Created by Romy on December 20, 2025.

class Fleegram extends StatelessWidget {
  const Fleegram({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..load()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()..load()),
        Provider<ApiClient>(create: (_) => ApiClient()),
        Provider<MultipartClient>(create: (_) => MultipartClient()),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(context.read<ApiClient>()),
        ),
        Provider<StoryRepository>(
          create: (context) => StoryRepository(
            apiClient: context.read<ApiClient>(),
            multipartClient: context.read<MultipartClient>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryProvider(context.read<StoryRepository>()),
        ),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, theme, locale, _) {
          return MaterialApp.router(
            title: 'Fleegram',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: locale.locale,
            supportedLocales: const [Locale('id'), Locale('en')],
            routerConfig: router,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: theme.themeMode,
          );
        },
      ),
    );
  }
}
