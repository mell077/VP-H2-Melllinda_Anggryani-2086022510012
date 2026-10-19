import 'package:flutter/material.dart';

import 'models/photocard.dart';
import 'widgets/add_card_sheet.dart';
import 'widgets/bias_progress_header.dart';
import 'widgets/empty_state.dart';
import 'widgets/member_filter_bar.dart';
import 'widgets/photo_card_grid.dart';
import 'widgets/status_filter_bar.dart';

class FandomVaultApp extends StatelessWidget {
  const FandomVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fandom Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7B5CFA)),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PhotoCard> _cards = [];
  bool _isLoading = true;
  String _query = '';
  String? _memberFilter;
  CardStatus? _statusFilter;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  // Simulasi loading dari sumber data
  Future<void> _loadCards() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _cards.addAll(kSampleCards);
      _isLoading = false;
    });
  }

  List<PhotoCard> get _visibleCards {
    final q = _query.trim().toLowerCase();
    return _cards.where((card) {
      final matchesMember = _memberFilter == null || card.member == _memberFilter;
      final matchesStatus = _statusFilter == null || card.status == _statusFilter;
      final matchesQuery = q.isEmpty ||
          card.album.toLowerCase().contains(q) ||
          card.member.toLowerCase().contains(q);
      return matchesMember && matchesStatus && matchesQuery;
    }).toList();
  }

  Future<void> _addCard() async {
    final card = await showAddCardSheet(context);
    if (card != null) {
      setState(() => _cards.add(card));
    }
  }

  @override
  Widget build(BuildContext context) {
    final memberCards = _memberFilter == null
        ? _cards
        : _cards.where((c) => c.member == _memberFilter).toList();
    final ownedCount =
        memberCards.where((c) => c.status == CardStatus.owned).length;
    final visible = _visibleCards;

    return Scaffold(
      appBar: AppBar(title: const Text('Fandom Vault')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCard,
        icon: const Icon(Icons.add),
        label: const Text('Tambah kartu'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Cari kartu...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
                MemberFilterBar(
                  members: kMembers,
                  selected: _memberFilter,
                  onSelected: (m) => setState(() => _memberFilter = m),
                ),
                StatusFilterBar(
                  selected: _statusFilter,
                  onSelected: (s) => setState(() => _statusFilter = s),
                ),
                BiasProgressHeader(
                  owned: ownedCount,
                  total: memberCards.length,
                ),
                Expanded(
                  child: visible.isEmpty
                      ? EmptyState(
                          message: _cards.isEmpty
                              ? 'Belum ada kartu. Tekan "Tambah kartu" untuk mulai.'
                              : 'Tidak ada kartu yang cocok dengan pencarian atau filter.',
                        )
                      : PhotoCardGrid(cards: visible),
                ),
              ],
            ),
    );
  }
}



