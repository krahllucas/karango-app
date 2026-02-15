
class Car {
  final String id;
  final String name;
  final String? plate;
  final String brand;
  final String model;
  final int year;
  final double tankVolume;


  const Car({
    required this.id,
    required this.name,
    this.plate,
    required this.brand,
    required this.model,
    required this.year,
    required this.tankVolume,
  });
}
