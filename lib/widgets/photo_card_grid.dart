import 'package:flutter/material.dart';
import '../models/photocard.dart';
import 'photo_card_tile.dart';

class PhotoCardGrid extends StatelessWidget {
  const PhotoCardGrid({super.key, required this.cards});

  final List<PhotoCard> cards;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return PhotoCardTile(key: ValueKey(card.id), card: card);
      },
    );
  }
}