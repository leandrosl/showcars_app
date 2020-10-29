class Car {
  String id;
  String factoryId;
  String name;
  String horsepower;
  String image;

  Car({this.id, this.factoryId, this.name, this.horsepower, this.image});

  @override
  String toString() => "Car name: $name";
}