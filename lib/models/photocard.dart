enum CardStatus { owned, wishlist }

class PhotoCard {
  const PhotoCard({
    required this.id,
    required this.member,
    required this.album,
    this.version = 'Ver. A',
    this.binderPage = 1,
    this.status = CardStatus.wishlist,
  });

  final String id;
  final String member;
  final String album;
  final String version;
  final int binderPage;
  final CardStatus status;
}