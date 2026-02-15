
class Car {
  final int id;
  final String name;
  final String? plate;
  final String brand;
  final String model;
  final int year;
  final double tankVolume;
  final List<int> fuelTypes;


  const Car({
    this.id = 0,
    required this.name,
    this.plate,
    required this.brand,
    required this.model,
    required this.year,
    required this.tankVolume,
    required this.fuelTypes,
  });
}
