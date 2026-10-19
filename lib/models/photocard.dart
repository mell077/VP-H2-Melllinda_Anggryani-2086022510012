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