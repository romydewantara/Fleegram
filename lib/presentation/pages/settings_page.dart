import 'package:fleegram/core/utils/session_manager.dart';
import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/auth_provider.dart';
import 'package:fleegram/presentation/providers/locale_provider.dart';
import 'package:fleegram/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _onLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.logout),
        content: Text(AppLocalizations.of(context)!.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (mounted) context.go('/login');
            },
            child: Text(AppLocalizations.of(context)!.logoutButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settingTitle)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/images/ic_profile.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SessionManager.name ?? '-',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          SessionManager.email ?? '-',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          _sectionTitle(context, AppLocalizations.of(context)!.preferences),

          _settingsTile(
            context,
            icon: Icons.dark_mode_outlined,
            title: AppLocalizations.of(context)!.theme,
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              underline: const SizedBox(),
              onChanged: (mode) {
                if (mode != null) {
                  context.read<ThemeProvider>().setTheme(mode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(AppLocalizations.of(context)!.themeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppLocalizations.of(context)!.themeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppLocalizations.of(context)!.themeDark),
                ),
              ],
            ),
          ),

          _settingsTile(
            context,
            icon: Icons.language,
            title: AppLocalizations.of(context)!.language,
            trailing: DropdownButton<Locale>(
              value: localeProvider.locale,
              onChanged: (locale) {
                if (locale != null) {
                  context.read<LocaleProvider>().setLocale(locale);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('id'),
                  child: Text(AppLocalizations.of(context)!.languageId),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text(AppLocalizations.of(context)!.languageEn),
                ),
              ],
              underline: const SizedBox(),
            ),
          ),

          _sectionTitle(context, AppLocalizations.of(context)!.account),

          _settingsTile(
            context,
            icon: Icons.logout,
            title: AppLocalizations.of(context)!.logoutButton,
            isDanger: true,
            onTap: _onLogout,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDanger = false,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? Colors.redAccent : theme.iconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(color: isDanger ? Colors.redAccent : null),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
