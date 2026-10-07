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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: [
          for (final m in members)
            ChoiceChip(
              label: Text(m),
              selected: m == selected,
              onSelected: (isOn) => onSelected(isOn ? m : null),
            ),
        ],
      ),
    );
  }
}