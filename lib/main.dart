import 'package:flutter/material.dart';

import 'data/sample_cards.dart';
import 'models/photocard.dart';
import 'theme/app_theme.dart';
import 'Widgets/add_card_sheet.dart';
import 'Widgets/bias_progress_header.dart';
import 'Widgets/empty_state.dart';
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

/// Width at which the screen switches from one column to two panes.
/// 600dp is Material's compact/medium boundary.
const double _wideBreakpoint = 600;
const double _sidePaneWidth = 360;

/// Primary screen. Owns ALL state:
/// cards, search query, member filter, status filter, and the chosen bias.
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<Photocard> _cards = initialCards();

  final _searchController = TextEditingController();
  String _query = '';
  String? _member;
  String? _bias;
  StatusFilter _statusFilter = StatusFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  Future<void> _addCard() async {
    final card = await showAddCardSheet(context);
    if (card == null) return;
    setState(() => _cards = [..._cards, card]);
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _member = null;
      _statusFilter = StatusFilter.all;
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

    final hasCards = _cards.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Photocard Vault')),
      floatingActionButton: hasCards
          ? FloatingActionButton(
              onPressed: _addCard,
              tooltip: 'Add photocard',
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        top: false,
        bottom: false,
        child: !hasCards
            ? CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      icon: Icons.collections_bookmark_outlined,
                      title: 'Your vault is empty',
                      message:
                          'Add your first photocard to start tracking your collection.',
                      actionLabel: 'Add photocard',
                      onAction: _addCard,
                    ),
                  ),
                ],
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final controls = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BiasProgressHeader(
                        members: members,
                        bias: _bias,
                        owned: biasOwned,
                        total: biasCards.length,
                        onBiasChanged: _setBias,
                      ),
                      SearchField(
                        controller: _searchController,
                        onChanged: _setQuery,
                      ),
                      StatusFilterBar(
                        selected: _statusFilter,
                        onChanged: _setStatusFilter,
                      ),
                      MemberFilterBar(
                        members: members,
                        selected: _member,
                        onSelected: _setMember,
                      ),
                    ],
                  );

                  final results = visible.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyState(
                            icon: Icons.search_off,
                            title: 'No matching cards',
                            message:
                                'Try a different search or clear the filters.',
                            actionLabel: 'Clear filters',
                            onAction: _clearFilters,
                          ),
                        )
                      : PhotocardGrid(cards: visible, onToggle: _toggleStatus);

                  // Tablet / wide landscape: controls become a side pane and
                  // the grid gets its own scroll view. The structure changes,
                  // it does not just stretch.
                  if (constraints.maxWidth >= _wideBreakpoint) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: _sidePaneWidth,
                          child: SingleChildScrollView(child: controls),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          child: CustomScrollView(slivers: [results]),
                        ),
                      ],
                    );
                  }

                  // Phone: one scroll view, so short/landscape screens and
                  // the keyboard never cause overflow.
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: controls),
                      results,
                    ],
                  );
                },
              ),
      ),
    );
  }
}