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
    return Card(
      color: card.isOwned ? Colors.green.shade100 : null,
      child: InkWell(
        onTap: onToggle,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(card.isOwned ? Icons.check_circle : Icons.favorite_border),
              const SizedBox(height: 8),
              Text(card.member),
              Text('${card.album} · ${card.version}'),
              Text('Binder page ${card.binderPage}'),
            ],
          ),
        ),
      ),
    );
  }
}