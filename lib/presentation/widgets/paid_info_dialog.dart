import 'package:fleegram/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaidInfoDialog extends StatelessWidget {
  const PaidInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.manage_accounts_rounded,
                    color: colors.secondaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Text(l10n.freeAccountTitle, style: text.titleLarge),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.freeAccountDescription,
                style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              _featureTable(context),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: Text(l10n.upgradeToPaid),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: Text(l10n.maybeLater),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureTable(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: 0.6),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: Text(l10n.feature, style: text.titleSmall)),
                Text(l10n.freeLabel, style: text.bodySmall),
                const SizedBox(width: 20),
                Text(l10n.paidLabel, style: text.bodySmall),
              ],
            ),
          ),
          _tableRow(context, l10n.addPhoto, true, true),
          _tableRow(context, l10n.addDescription, true, true),
          _tableRow(context, l10n.addLocationFeature, false, true),
        ],
      ),
    );
  }

  Widget _tableRow(BuildContext context, String title, bool free, bool paid) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;

    Widget icon(bool active) => Icon(
      active ? Icons.check_circle : Icons.close,
      size: 18,
      color: active ? colors.secondaryContainer : colors.error,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
            ),
          ),
          icon(free),
          const SizedBox(width: 30),
          icon(paid),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
