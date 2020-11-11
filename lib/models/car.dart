import 'package:showcars_app/models/manufactor.dart';

class Car {
  String id;
  Manufactor manufactor;
  String name;

  String horsepower;
  String engineType;
  String torque;
  String gearbox;

  String topSpeed;
  String acceleration0To100;

  String numberDoors;
  String width;
  String height;
  String length;
  String weight;

  String imageUrl;

  Car({
    this.id, 
    this.manufactor, 
    this.name, 
    this.horsepower,
    this.engineType,
    this.torque,
    this.gearbox,
    this.topSpeed,
    this.acceleration0To100,
    this.numberDoors,
    this.width,
    this.height,
    this.length, 
    this.weight,
    this.imageUrl,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'].toString(),
      manufactor: Manufactor.fromJson(json['factory']),
      name: json['name'],
      horsepower: json['horsepower'],
      engineType: json['engine_type'],
      torque: json['torque'],
      gearbox: json['gearbox'],
      topSpeed: json['top_speed'],
      acceleration0To100: json['acceleration_0to100'],
      numberDoors: json['number_doors'],
      width: json['width'],
      height: json['height'],
      length: json['length'],
      weight: json['weight'],
      imageUrl: json['car_image'],
    );
  }

  @override
  String toString() => "Car name: $name";
}