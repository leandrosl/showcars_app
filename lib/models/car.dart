import 'package:showcars_app/models/manufactor.dart';

class Car {
  String id;
  Manufactor manufactor;
  String name;
  String horsepower;
  String imageUrl;

  Car({this.id, this.manufactor, this.name, this.horsepower, this.imageUrl});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'].toString(),
      manufactor: Manufactor.fromJson(json['factory']),
      name: json['name'],
      horsepower: json['horsepower'],
      imageUrl: json['car_image'],
    );
  }

  @override
  String toString() => "Car name: $name";
}