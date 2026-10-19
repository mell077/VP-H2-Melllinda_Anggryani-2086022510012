import 'package:flutter/material.dart';

import '../models/photocard.dart';

class StatusFilterBar extends StatelessWidget {
  const StatusFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final StatusFilter selected;
  final ValueChanged<StatusFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SegmentedButton<StatusFilter>(
        segments: const [
          ButtonSegment(value: StatusFilter.all, label: Text('All')),
          ButtonSegment(value: StatusFilter.wishlist, label: Text('Wishlist')),
          ButtonSegment(value: StatusFilter.owned, label: Text('Owned')),
        ],
        selected: {selected},
        onSelectionChanged: (s) => onChanged(s.first),
      ),
    );
  }
}