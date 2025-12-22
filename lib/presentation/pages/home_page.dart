import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/auth_provider.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/presentation/widgets/story_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
        actions: [
          IconButton(onPressed: _onLogout, icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/post'),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: provider.fetchInitialStories,
        child: ListView.builder(
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
}
