import 'package:flutter/material.dart';

class BiasProgressHeader extends StatelessWidget {
  const BiasProgressHeader({
    super.key,
    required this.owned,
    required this.total,
  });

  final int owned;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : owned / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Koleksi: $owned dari $total kartu',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
}