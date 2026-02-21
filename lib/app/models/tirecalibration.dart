class TireCalibration {
  final int id;
  final int carId;
  final DateTime dateTime;
  final int odometer;
  final String? location;
  final String? notes;
  final List<Map<String, dynamic>>? details;

  TireCalibration({
    required this.id,
    required this.carId,
    required this.dateTime,
    required this.odometer,
    this.location,
    this.notes,
    this.details,
  });
}