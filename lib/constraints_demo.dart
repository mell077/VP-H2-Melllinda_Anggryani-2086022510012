import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

/// Week 04 H2: three deliberate constraint errors, each with its fix.
/// Run with:  flutter run -t lib/constraints_demo.dart
/// Pick a case, leave "Show fix" off to see the error, turn it on for the fix.
void main() => runApp(const ConstraintsDemo());

class ConstraintsDemo extends StatelessWidget {
  const ConstraintsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Constraint diagnosis',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const _DemoScreen(),
    );
  }
}

class _DemoScreen extends StatefulWidget {
  const _DemoScreen();

  @override
  State<_DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<_DemoScreen> {
  int _case = 1;
  bool _fixed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Constraint diagnosis')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('1 Row')),
                ButtonSegment(value: 2, label: Text('2 Column')),
                ButtonSegment(value: 3, label: Text('3 List')),
              ],
              selected: {_case},
              onSelectionChanged: (s) => setState(() => _case = s.first),
            ),
          ),
          SwitchListTile(
            title: const Text('Show fix'),
            value: _fixed,
            onChanged: (v) => setState(() => _fixed = v),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: switch (_case) {
                1 => _RowOverflow(fixed: _fixed),
                2 => _ColumnOverflow(fixed: _fixed),
                _ => _UnboundedList(fixed: _fixed),
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Horizontal overflow: long text in a Row.
// ---------------------------------------------------------------------------
class _RowOverflow extends StatelessWidget {
  const _RowOverflow({required this.fixed});

  final bool fixed;

  // 200 characters, no spaces.
  static final _longName = 'LongName' * 25;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          const Icon(Icons.favorite_border),
          const SizedBox(width: 8),
          if (fixed)
            // FIX: Expanded gives the Text a bounded width, so it can ellipsize.
            Expanded(
              child: Text(_longName, maxLines: 1, overflow: TextOverflow.ellipsis),
            )
          else
            // BROKEN: a Row gives non-flex children unbounded width.
            Text(_longName),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Vertical overflow: Column taller than a fixed-height parent.
// ---------------------------------------------------------------------------
class _ColumnOverflow extends StatelessWidget {
  const _ColumnOverflow({required this.fixed});

  final bool fixed;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    final content = Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_border, size: 56),
          const SizedBox(height: 8),
          Text('Member A', style: text.headlineSmall),
          const Text('Album One · Ver. A'),
          const Text('Binder page 1'),
        ],
      ),
    );

    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        child: SizedBox(
          width: 160,
          child: fixed
              // FIX: minHeight lets the box grow to fit its content.
              ? ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 120),
                  child: content,
                )
              // BROKEN: exact height 120, content needs about 160.
              : SizedBox(height: 120, child: content),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Unbounded height: scrollable inside a Column.
// ---------------------------------------------------------------------------
class _UnboundedList extends StatelessWidget {
  const _UnboundedList({required this.fixed});

  final bool fixed;

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      itemCount: 20,
      itemBuilder: (_, i) => ListTile(title: Text('Photocard ${i + 1}')),
    );

    return Column(
      children: [
        Text('Collection', style: Theme.of(context).textTheme.titleLarge),
        // FIX: Expanded gives the list the remaining, bounded height.
        // BROKEN: a Column gives non-flex children unbounded height.
        if (fixed) Expanded(child: list) else list,
      ],
    );
  }
}