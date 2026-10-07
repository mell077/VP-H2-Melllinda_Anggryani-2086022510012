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