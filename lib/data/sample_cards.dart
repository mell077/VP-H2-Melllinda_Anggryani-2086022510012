import '../models/photocard.dart';

/// Test scenarios for the responsive matrix (docs/week04/responsive-matrix.md):
///   flutter run --dart-define=SCENARIO=empty      -> zero items
///   flutter run --dart-define=SCENARIO=long       -> 500 items
///   flutter run --dart-define=SCENARIO=longtext   -> 200-character names
/// Without the flag the app starts with the normal sample data.
const _scenario = String.fromEnvironment('SCENARIO');

List<Photocard> initialCards() => switch (_scenario) {
      'empty' => const <Photocard>[],
      'long' => _longList(),
      'longtext' => _longTextCards(),
      _ => _sample,
    };

const _sample = <Photocard>[
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

List<Photocard> _longList() => [
      for (var i = 0; i < 500; i++)
        Photocard(
          id: '$i',
          member: 'Member ${String.fromCharCode(65 + i % 3)}',
          album: 'Album ${i ~/ 6 + 1}',
          version: i.isEven ? 'Ver. A' : 'Ver. B',
          binderPage: i ~/ 9 + 1,
          status: i % 5 == 0 ? CardStatus.owned : CardStatus.wishlist,
        ),
    ];

// 200 characters, no spaces: the worst case for wrapping.
final _long = 'LongName' * 25;

List<Photocard> _longTextCards() => [
      Photocard(
        id: '1',
        member: _long,
        album: 'Album One',
        version: 'Ver. A',
        binderPage: 1,
        status: CardStatus.owned,
      ),
      Photocard(
        id: '2',
        member: 'Member B',
        album: _long,
        version: _long,
        binderPage: 1,
      ),
      const Photocard(
        id: '3',
        member: 'Member C',
        album: 'Album Two',
        version: 'Ver. B',
        binderPage: 2,
      ),
    ];