import 'package:flutter/material.dart';
import '../models/photocard.dart';

class PhotoCardTile extends StatelessWidget {
  const PhotoCardTile({super.key, required this.card});

  final PhotoCard card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final owned = card.status == CardStatus.owned;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: scheme.primaryContainer,
              alignment: Alignment.center,
              child: Icon(
                Icons.photo_outlined,
                size: 48,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.member, style: theme.textTheme.titleSmall),
                Text(
                  card.album,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      owned ? Icons.check_circle : Icons.favorite_border,
                      size: 16,
                      color: owned ? scheme.primary : scheme.outline,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      owned ? 'Dimiliki' : 'Wishlist',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}