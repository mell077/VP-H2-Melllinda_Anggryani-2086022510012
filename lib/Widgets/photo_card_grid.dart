// ignore: file_names
import 'package:flutter/material.dart';

import '../models/photocard.dart';
import 'photo_card_tile.dart';

/// A sliver, so it lives inside the screen's CustomScrollView.
/// Uses SliverGrid.builder: tiles are built lazily, only the ones on screen,
/// so 500+ cards stay smooth.
class PhotocardGrid extends StatelessWidget {
  const PhotocardGrid({
    super.key,
    required this.cards,
    required this.onToggle,
  });

  final List<Photocard> cards;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      // Bottom padding keeps the last row clear of the FAB.
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisExtent: 176,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: cards.length,
        itemBuilder: (context, i) => PhotocardTile(
          key: ValueKey(cards[i].id),
          card: cards[i],
          onToggle: () => onToggle(cards[i].id),
        ),
      ),
    );
  }
}