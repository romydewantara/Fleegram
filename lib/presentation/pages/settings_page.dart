import 'package:fleegram/core/constants/app_assets.dart';
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
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (mounted) context.go('/login');
            },
            child: Text(l10n.logoutButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingTitle)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _sectionTitle(l10n.account),
                _profileSection(theme, l10n),
                _sectionTitle(l10n.preferences),
                _preferencesSection(themeProvider, localeProvider, l10n),
                _sectionCard(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
                  child: _logoutTile(
                    title: l10n.logoutButton,
                    onTap: _onLogout,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  l10n.copyright,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${l10n.developedBy} ${l10n.developerName}',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.version,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileSection(ThemeData theme, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Card(
            elevation: 1.5,
            surfaceTintColor: theme.colorScheme.surface,
            shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(AppAssets.icProfile),
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
          const SizedBox(height: 4),
          _sectionInfoText(l10n.userInformation),
        ],
      ),
    );
  }

  Widget _preferencesSection(
    ThemeProvider themeProvider,
    LocaleProvider localeProvider,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    return _settingsGroup(
      child: Column(
        children: [
          _settingsTile(
            icon: Icons.dark_mode_outlined,
            title: l10n.theme,
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
                  child: Text(l10n.themeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.themeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.themeDark),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            color: theme.dividerColor.withValues(alpha: 0.4),
          ),
          _settingsTile(
            icon: Icons.language,
            title: l10n.language,
            trailing: DropdownButton<Locale>(
              value: localeProvider.locale,
              underline: const SizedBox(),
              onChanged: (locale) {
                if (locale != null) {
                  context.read<LocaleProvider>().setLocale(locale);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('id'), child: Text('Indonesia')),
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsGroup({required Widget child}) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            surfaceTintColor: theme.colorScheme.surface,
            shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: child,
          ),
          const SizedBox(height: 4),
          _sectionInfoText(l10n.prefInformation),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _sectionInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _settingsTile({
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

  Widget _logoutTile({required String title, VoidCallback? onTap}) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _sectionCard({
    required Widget child,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    final theme = Theme.of(context);

    final bgColor = backgroundColor ?? theme.colorScheme.surface;
    final fgColor = foregroundColor ?? theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 16),
      child: Card(
        elevation: 1.5,
        color: bgColor,
        shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.apply(
              bodyColor: fgColor,
              displayColor: fgColor,
            ),
            iconTheme: theme.iconTheme.copyWith(color: fgColor),
            listTileTheme: theme.listTileTheme.copyWith(
              iconColor: fgColor,
              textColor: fgColor,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
