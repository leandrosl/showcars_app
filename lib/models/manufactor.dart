class Manufactor {
  String id;
  String name;
  String country;
  String logoUrl;

  Manufactor({this.id, this.name, this.country, this.logoUrl});

  factory Manufactor.fromJson(Map<String, dynamic> json) {
    return Manufactor(
      id: json["id"].toString(),
      name: json['name'],
      country: json['country'],
      logoUrl: json['logo'],
    );
  }

  @override
  String toString() => "Name: $name";
}