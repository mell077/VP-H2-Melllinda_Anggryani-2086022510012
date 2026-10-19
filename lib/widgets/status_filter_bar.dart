import '../models/photocard.dart';
import 'package:flutter/material.dart';

class StatusFilterBar extends StatelessWidget {
  const StatusFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final CardStatus? selected;
  final ValueChanged<CardStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    const options = <(String, CardStatus?)>[
      ('Semua', null),
      ('Dimiliki', CardStatus.owned),
      ('Wishlist', CardStatus.wishlist),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          for (final (label, value) in options)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(label),
                selected: selected == value,
                onSelected: (_) => onSelected(value),
              ),
            ),
        ],
      ),
    );
  }
}