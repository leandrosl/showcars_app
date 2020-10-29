class Car {
  String id;
  String factoryId;
  String name;
  String horsepower;
  String imageUrl;

  Car({this.id, this.factoryId, this.name, this.horsepower, this.imageUrl});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'].toString(),
      factoryId: json['factoryId'].toString(),
      name: json['name'],
      horsepower: json['horsepower'],
      imageUrl: json['car_image'],
    );
  }

  @override
  String toString() => "Car name: $name";
}