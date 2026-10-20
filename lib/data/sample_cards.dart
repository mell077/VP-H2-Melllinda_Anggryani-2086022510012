import '../models/photocard.dart';

const kMembers = <String>['Member A', 'Member B', 'Member C'];

const _scenario = String.fromEnvironment('SCENARIO');

List<PhotoCard> initialCards() => switch (_scenario) {
      'empty' => const <PhotoCard>[],
      'long' => _longList(),
      'longtext' => _longTextCards(),
      _ => _sample,
    };

const _sample = <PhotoCard>[
  PhotoCard(id: '1', member: 'Member A', album: 'Album One', version: 'Ver. A', binderPage: 1, status: CardStatus.owned),
  PhotoCard(id: '2', member: 'Member B', album: 'Album One', version: 'Ver. A', binderPage: 1, status: CardStatus.wishlist),
  PhotoCard(id: '3', member: 'Member C', album: 'Album One', version: 'Ver. B', binderPage: 2, status: CardStatus.wishlist),
  PhotoCard(id: '4', member: 'Member A', album: 'Album Two', version: 'Ver. A', binderPage: 2, status: CardStatus.owned),
  PhotoCard(id: '5', member: 'Member B', album: 'Album Two', version: 'Ver. B', binderPage: 3, status: CardStatus.owned),
  PhotoCard(id: '6', member: 'Member A', album: 'Album Two', version: 'Ver. B', binderPage: 3, status: CardStatus.wishlist),
];

List<PhotoCard> _longList() => [
      for (var i = 0; i < 500; i++)
        PhotoCard(
          id: '$i',
          member: 'Member ${String.fromCharCode(65 + i % 3)}',
          album: 'Album ${i ~/ 6 + 1}',
          version: i.isEven ? 'Ver. A' : 'Ver. B',
          binderPage: i ~/ 9 + 1,
          status: i % 5 == 0 ? CardStatus.owned : CardStatus.wishlist,
        ),
    ];

// 200 karakter tanpa spasi: kasus terburuk untuk wrapping.
final _long = 'LongName' * 25;

List<PhotoCard> _longTextCards() => [
      PhotoCard(id: '1', member: _long, album: 'Album One', version: 'Ver. A', binderPage: 1, status: CardStatus.owned),
      PhotoCard(id: '2', member: 'Member B', album: _long, version: _long, binderPage: 1, status: CardStatus.wishlist),
      const PhotoCard(id: '3', member: 'Member C', album: 'Album Two', version: 'Ver. B', binderPage: 2, status: CardStatus.wishlist),
    ];