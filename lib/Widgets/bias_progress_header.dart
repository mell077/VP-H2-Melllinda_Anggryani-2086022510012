import 'package:flutter/material.dart';

class BiasProgressHeader extends StatelessWidget {
  const BiasProgressHeader({
    super.key,
    required this.members,
    required this.bias,
    required this.owned,
    required this.total,
    required this.onBiasChanged,
  });

  final List<String> members;
  final String? bias;
  final int owned;
  final int total;
  final ValueChanged<String?> onBiasChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card.filled(
        margin: EdgeInsets.zero,
        color: scheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: bias,
                isDense: true,
                underline: const SizedBox.shrink(),
                iconEnabledColor: scheme.onPrimaryContainer,
                hint: Text(
                  'Pick your bias',
                  style: text.titleMedium?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                style: text.titleMedium?.copyWith(
                  color: scheme.onPrimaryContainer,
                ),
                items: [
                  for (final m in members)
                    DropdownMenuItem(value: m, child: Text(m)),
                ],
                onChanged: onBiasChanged,
              ),
              if (bias != null) ...[
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$owned',
                        style: text.displayMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                      TextSpan(
                        text: ' / $total collected',
                        style: text.titleLarge?.copyWith(
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: total == 0 ? 0 : owned / total,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(6),
                  color: scheme.primary,
                  backgroundColor: scheme.surface,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}