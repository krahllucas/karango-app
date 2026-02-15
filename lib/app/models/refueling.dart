class Refueling {
  final int id;
  final int carId;
  final DateTime dateTime;
  final int odometer;
  final int fuelId;
  final double pricePerLiter;
  final double totalCost;
  final double liters;
  final String location;
  final bool isFullTank;

  const Refueling({
    this.id = 0,
    required this.carId,
    required this.dateTime,
    required this.odometer,
    required this.fuelId,
    required this.pricePerLiter,
    required this.totalCost,
    required this.liters,
    required this.location,
    required this.isFullTank,
  });
}