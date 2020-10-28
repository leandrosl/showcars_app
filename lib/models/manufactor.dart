class Manufactor {
  String name;
  String country;
  String logoUrl;

  Manufactor({this.name, this.country, this.logoUrl});

  factory Manufactor.fromJson(Map<String, dynamic> json) {
    return Manufactor(
      name: json['name'],
      country: json['country'],
      logoUrl: json['logo'],
    );
  }

  @override
  String toString() => "Name: $name";
}