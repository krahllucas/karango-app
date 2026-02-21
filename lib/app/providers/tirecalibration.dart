
import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/tirecalibration.dart';

class TireCalibrationProvider with ChangeNotifier {
  List<TireCalibration> _tireCalibrations = [];

  Future<void> loadTireCalibrations() async {
    final dataList = await DbUtil.getData('tire_calibration');
    _tireCalibrations = dataList
        .map(
          (item) => TireCalibration(
            id: item['id'],
            carId: item['car_id'],
            dateTime: DateTime.parse(item['date_time']),
            odometer: item['odometer'],
            location: item['location'],
            notes: item['notes'],
            details: [], // Carregamento dos detalhes pode ser implementado posteriormente
          ),
        )
        .toList();
  }

  List<TireCalibration> get tireCalibrations {
    return [..._tireCalibrations];
  }

  int get lastCalibrationDays {
    if (_tireCalibrations.isEmpty) return 0;
    final lastCalibration = _tireCalibrations.last;
    return DateTime.now().difference(lastCalibration.dateTime).inDays;
  }

  Future<void> addTireCalibration(TireCalibration tireCalibration) async {
    _tireCalibrations.add(tireCalibration);

    DbUtil.insert('tire_calibration', {
      'id': tireCalibration.id,
      'car_id': tireCalibration.carId,
      'date_time': tireCalibration.dateTime.toIso8601String(),
      'odometer': tireCalibration.odometer,
      'location': tireCalibration.location,
      'notes': tireCalibration.notes,
    });


    tireCalibration.details?.forEach((detail) {
      DbUtil.insert('tire_calibration_detail', {
        'calibration_id': tireCalibration.id,
        'position': detail['position'],
        'pressure': detail['pressure'],
      });
    });

    notifyListeners();
  }

}