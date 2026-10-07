import 'package:flutter/material.dart';

import 'models/photocard.dart';
import 'theme/app_theme.dart';
import 'Widgets/bias_progress_header.dart';
import 'Widgets/member_filter_bar.dart';
import 'Widgets/photo_card_grid.dart';
import 'Widgets/search_field.dart';
import 'Widgets/status_filter_bar.dart';

void main() => runApp(const PhotocardVaultApp());
class PhotocardVaultApp extends StatelessWidget {
  const PhotocardVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photocard Vault',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const CollectionScreen(),
    );
  }
}

/// Primary screen. Owns ALL state:
/// cards, search query, member filter, status filter, and the chosen bias.
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<Photocard> _cards = const [
    Photocard(
      id: '1',
      member: 'Member A',
      album: 'Album One',
      version: 'Ver. A',
      binderPage: 1,
      status: CardStatus.owned,
    ),
    Photocard(
      id: '2',
      member: 'Member B',
      album: 'Album One',
      version: 'Ver. A',
      binderPage: 1,
    ),
    Photocard(
      id: '3',
      member: 'Member C',
      album: 'Album One',
      version: 'Ver. B',
      binderPage: 2,
    ),
    Photocard(
      id: '4',
      member: 'Member A',
      album: 'Album Two',
      version: 'Ver. A',
      binderPage: 2,
    ),
    Photocard(
      id: '5',
      member: 'Member B',
      album: 'Album Two',
      version: 'Ver. B',
      binderPage: 3,
      status: CardStatus.owned,
    ),
    Photocard(
      id: '6',
      member: 'Member A',
      album: 'Album Two',
      version: 'Ver. B',
      binderPage: 3,
    ),
  ];

  String _query = '';
  String? _member;
  String? _bias;
  StatusFilter _statusFilter = StatusFilter.all;

  void _toggleStatus(String id) {
    setState(() {
      _cards = [
        for (final c in _cards)
          if (c.id == id)
            c.copyWith(
              status: c.isOwned ? CardStatus.wishlist : CardStatus.owned,
            )
          else
            c,
      ];
    });
  }

  void _setQuery(String value) => setState(() => _query = value);
  void _setMember(String? member) => setState(() => _member = member);
  void _setBias(String? bias) => setState(() => _bias = bias);
  void _setStatusFilter(StatusFilter f) => setState(() => _statusFilter = f);

  bool _matches(Photocard c) {
    final q = _query.toLowerCase();
    final matchesQuery = c.album.toLowerCase().contains(q) ||
        c.version.toLowerCase().contains(q);
    final matchesMember = _member == null || c.member == _member;
    final matchesStatus = switch (_statusFilter) {
      StatusFilter.all => true,
      StatusFilter.wishlist => !c.isOwned,
      StatusFilter.owned => c.isOwned,
    };
    return matchesQuery && matchesMember && matchesStatus;
  }

  @override
  Widget build(BuildContext context) {
    final members = {for (final c in _cards) c.member}.toList()..sort();
    final visible = _cards.where(_matches).toList()
      ..sort((a, b) => a.binderPage.compareTo(b.binderPage));

    final biasCards = _cards.where((c) => c.member == _bias).toList();
    final biasOwned = biasCards.where((c) => c.isOwned).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Photocard Vault')),
      body: Column(
        children: [
          BiasProgressHeader(
            members: members,
            bias: _bias,
            owned: biasOwned,
            total: biasCards.length,
            onBiasChanged: _setBias,
          ),
          SearchField(onChanged: _setQuery),
          StatusFilterBar(selected: _statusFilter, onChanged: _setStatusFilter),
          MemberFilterBar(
            members: members,
            selected: _member,
            onSelected: _setMember,
          ),
          Expanded(
            child: PhotocardGrid(cards: visible, onToggle: _toggleStatus),
          ),
        ],
      ),
    );
  }
}