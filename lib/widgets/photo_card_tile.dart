import 'package:flutter/material.dart';

import '../models/photocard.dart';

class PhotocardTile extends StatelessWidget {
  const PhotocardTile({
    super.key,
    required this.card,
    required this.onToggle,
  });

  final Photocard card;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    // Owned = tertiary container, Wishlist = default card surface.
    final foreground =
        card.isOwned ? scheme.onTertiaryContainer : scheme.onSurface;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: card.isOwned ? scheme.tertiaryContainer : null,
      child: InkWell(
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  card.isOwned ? Icons.check_circle : Icons.favorite_border,
                  color: card.isOwned ? scheme.tertiary : scheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  card.member,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: text.bodyLarge?.copyWith(color: foreground),
                ),
                Text(
                  '${card.album} · ${card.version}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: text.bodyMedium?.copyWith(color: foreground),
                ),
                Text(
                  'Binder page ${card.binderPage}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: text.bodyMedium?.copyWith(color: foreground),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}