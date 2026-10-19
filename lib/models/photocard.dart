<<<<<<< HEAD
enum CardStatus { owned, wishlist }

class PhotoCard {
  final String id;
  final String member;
  final String album;
  final CardStatus status;

  const PhotoCard({
    required this.id,
    required this.member,
    required this.album,
    required this.status,
  });
}

const kMembers = ['Mina', 'Rena', 'Sora', 'Yuna'];

const kSampleCards = [
  PhotoCard(id: '1', member: 'Mina', album: 'Debut Album', status: CardStatus.owned),
  PhotoCard(id: '2', member: 'Mina', album: 'Summer Single', status: CardStatus.wishlist),
  PhotoCard(id: '3', member: 'Rena', album: 'Debut Album', status: CardStatus.owned),
  PhotoCard(id: '4', member: 'Sora', album: 'Winter Repackage', status: CardStatus.wishlist),
  PhotoCard(id: '5', member: 'Yuna', album: 'Debut Album', status: CardStatus.owned),
];
=======
enum CardStatus { wishlist, owned }

enum StatusFilter { all, wishlist, owned }

class Photocard {
  const Photocard({
    required this.id,
    required this.member,
    required this.album,
    required this.version,
    required this.binderPage,
    this.status = CardStatus.wishlist,
  });

  final String id;
  final String member;
  final String album;
  final String version;
  final int binderPage;
  final CardStatus status;

  bool get isOwned => status == CardStatus.owned;

  Photocard copyWith({CardStatus? status}) => Photocard(
        id: id,
        member: member,
        album: album,
        version: version,
        binderPage: binderPage,
        status: status ?? this.status,
      );
}
>>>>>>> 93bfda3288f1e95717bc161a3fdb6988f199527c
