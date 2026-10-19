import 'package:flutter/material.dart';

class MemberFilterBar extends StatelessWidget {
  const MemberFilterBar({
    super.key,
    required this.members,
    required this.selected,
    required this.onSelected,
  });

  final List<String> members;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('Semua member'),
              selected: selected == null,
              onSelected: (_) => onSelected(null),
            ),
          ),
          for (final m in members)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(m),
                selected: selected == m,
                onSelected: (_) => onSelected(m),
              ),
            ),
        ],
      ),
    );
  }
}