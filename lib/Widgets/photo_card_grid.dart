// ignore: file_names
import 'package:flutter/material.dart';

import '../models/photocard.dart';
import 'photo_card_tile.dart';

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
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: cards.length,
      itemBuilder: (context, i) => PhotocardTile(
        key: ValueKey(cards[i].id),
        card: cards[i],
        onToggle: () => onToggle(cards[i].id),
      ),
    );
  }
}