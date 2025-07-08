class Player {
  String id;
  String fullname;
  String position;
  String? club;
  String? country;
  String? image;
  int number;
  int pac;
  int sho;
  int pas;
  int dri;
  int def;
  int phy;
  int score;

  Player({
    required this.id,
    required this.fullname,
    required this.position,
    this.club,
    this.country,
    required this.number,
    required this.pac,
    required this.sho,
    required this.pas,
    required this.dri,
    required this.def,
    required this.phy,
    required this.score,
    this.image,
  });

  factory Player.fromJson(json) {
    return Player(
      id: json['id'],
      fullname: json['fullname'],
      position: json['position'],
      club: json['club'],
      country: json['country'],
      number: json['number'],
      pac: json['pac'],
      sho: json['sho'],
      pas: json['pas'],
      dri: json['dri'],
      def: json['def'],
      phy: json['phy'],
      score: json['score'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'position': position,
      'club': club,
      'country': country,
      'number': number,
      'pac': pac,
      'sho': sho,
      'pas': pas,
      'dri': dri,
      'def': def,
      'phy': phy,
      'score': score,
      'image': image,
    };
  }
}
