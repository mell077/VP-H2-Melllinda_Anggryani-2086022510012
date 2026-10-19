import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/photocard.dart';

/// Bottom sheet form for adding a photocard. Scrolls and lifts above the
/// keyboard so the focused field always stays visible.
Future<Photocard?> showAddCardSheet(BuildContext context) {
  return showModalBottomSheet<Photocard>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const _AddCardForm(),
  );
}

class _AddCardForm extends StatefulWidget {
  const _AddCardForm();

  @override
  State<_AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<_AddCardForm> {
  final _formKey = GlobalKey<FormState>();
  final _member = TextEditingController();
  final _album = TextEditingController();
  final _version = TextEditingController();
  final _page = TextEditingController();

  @override
  void dispose() {
    _member.dispose();
    _album.dispose();
    _version.dispose();
    _page.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Photocard(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        member: _member.text.trim(),
        album: _album.text.trim(),
        version: _version.text.trim(),
        binderPage: int.parse(_page.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + keyboard),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add photocard',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _member,
                decoration: const InputDecoration(
                  labelText: 'Member',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _album,
                decoration: const InputDecoration(
                  labelText: 'Album',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _version,
                decoration: const InputDecoration(
                  labelText: 'Version',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _page,
                decoration: const InputDecoration(
                  labelText: 'Binder page',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                validator: (v) {
                  final base = _required(v);
                  if (base != null) return base;
                  return int.parse(v!.trim()) < 1 ? 'Must be 1 or more' : null;
                },
              ),
              const SizedBox(height: 20),
              FilledButton(onPressed: _submit, child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}