import 'package:fleegram/core/constants/app_assets.dart';
import 'package:fleegram/core/utils/date_formatter.dart';
import 'package:fleegram/data/models/story_model.dart';
import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/widgets/story_map_card.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DetailStoryPage extends StatelessWidget {
  final Story story;

  const DetailStoryPage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final formattedDate = DateFormatter.formatFull(
      date: story.createdAt,
      locale: locale,
      pattern: l10n.dateFormatFull,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              l10n.storyDetailTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(story.name, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(AppAssets.icProfile),
                  ),
                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formattedDate,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' • ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          IconTheme(
                            data: const IconThemeData(size: 14),
                            child: Align(
                              alignment: Alignment.center,
                              heightFactor: 1,
                              child: Icon(
                                Icons.public_rounded,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Hero(
              tag: 'story-${story.id}',
              child: Image.network(
                story.photoUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (_, _, _) {
                  return const Center(
                    child: Icon(Icons.broken_image, size: 64),
                  );
                },
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: ReadMoreText(
                story.description,
                trimLines: 4,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Selengkapnya',
                trimExpandedText: ' Ringkas',
                style: const TextStyle(fontSize: 13),
                moreStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
                lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),

            if (story.lat != null && story.lon != null)
              _LazyMapSection(story: story),
          ],
        ),
      ),
    );
  }
}

class _LazyMapSection extends StatefulWidget {
  final Story story;
  const _LazyMapSection({required this.story});

  @override
  State<_LazyMapSection> createState() => _LazyMapSectionState();
}

class _LazyMapSectionState extends State<_LazyMapSection> {
  bool _showMap = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _showMap = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: !_showMap
          ? Center(child: CircularProgressIndicator())
          : StoryMapCard(
              name: widget.story.name,
              lat: widget.story.lat!,
              lon: widget.story.lon!,
            ),
    );
  }
}
