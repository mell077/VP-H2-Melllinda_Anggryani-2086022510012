import 'package:flutter/material.dart';
import '../models/photocard.dart';

Future<PhotoCard?> showAddCardSheet(BuildContext context) {
  return showModalBottomSheet<PhotoCard>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const _AddCardForm(),
  );
}

class _AddCardForm extends StatefulWidget {
  const _AddCardForm();

  @override
  State<_AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<_AddCardForm> {
  final _albumController = TextEditingController();
  String _member = kMembers.first;
  CardStatus _status = CardStatus.owned;

  @override
  void dispose() {
    _albumController.dispose();
    super.dispose();
  }

  void _submit() {
    final album = _albumController.text.trim();
    if (album.isEmpty) return; // validasi sederhana

    Navigator.pop(
      context,
      PhotoCard(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        member: _member,
        album: album,
        status: _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Tambah kartu', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _albumController,
            decoration: const InputDecoration(
              labelText: 'Nama album',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final m in kMembers)
                ChoiceChip(
                  label: Text(m),
                  selected: _member == m,
                  onSelected: (_) => setState(() => _member = m),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SegmentedButton<CardStatus>(
            segments: const [
              ButtonSegment(value: CardStatus.owned, label: Text('Dimiliki')),
              ButtonSegment(value: CardStatus.wishlist, label: Text('Wishlist')),
            ],
            selected: {_status},
            onSelectionChanged: (s) => setState(() => _status = s.first),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _submit, child: const Text('Simpan')),
        ],
      ),
    );
  }
}