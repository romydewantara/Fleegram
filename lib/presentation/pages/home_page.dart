import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/presentation/widgets/add_story_icon.dart';
import 'package:fleegram/presentation/widgets/asymmetric_burger_icon.dart';
import 'package:fleegram/presentation/widgets/story_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final storyProvider = context.read<StoryProvider>();
    storyProvider.fetchInitialStories();

    _scrollController.addListener(() {
      final provider = context.read<StoryProvider>();
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.fetchNextStories();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fleegram',
          style: GoogleFonts.satisfy(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        leading: AddStoryIcon(onPressed: () => context.push('/post')),
        actions: [
          IconButton(
            onPressed: () => context.push('/setting'),
            icon: const AsymmetricBurgerIcon(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.fetchInitialStories,
        child: provider.errorMessage != null && provider.stories.isEmpty
            ? _errorView(provider.errorMessage!, provider.fetchInitialStories)
            : ListView.builder(
                controller: _scrollController,
                itemCount: provider.stories.length + 1,
                itemBuilder: (context, index) {
                  if (index == provider.stories.length) {
                    if (provider.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return const SizedBox.shrink();
                  }

                  final story = provider.stories[index];
                  return StoryCard(
                    story: story,
                    onTap: () => context.push('/detail', extra: story),
                  );
                },
              ),
      ),
    );
  }

  Widget _errorView(StoryError message, VoidCallback onRetry) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/empty_data.json',
              width: 200,
              repeat: false,
            ),
            const SizedBox(height: 24),

            Text(
              l10n.errorNetworkTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              message == StoryError.network
                  ? l10n.errorNetwork
                  : l10n.errorGeneric,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
