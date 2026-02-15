
import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/refueling.dart';

class RefuelingProvider extends ChangeNotifier {
  List<Refueling> _refuelings = [];

  Future<void> loadRefuelings() async {
    final dataList = await DbUtil.getData('refueling');
    _refuelings = dataList
        .map(
          (item) => Refueling(
            id: item['id'],
            carId: item['car_id'],
            dateTime: DateTime.parse(item['date_time']),
            odometer: item['odometer'],
            fuelType: item['fuel_type'],
            pricePerLiter: item['price_per_liter'],
            totalCost: item['total_cost'],
            liters: item['liters'],
            location: item['location'],
            isFullTank: item['is_full_tank'] == 1,
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Refueling> get refuelings {
    return [..._refuelings];
  }

  Future<void> addRefueling(Refueling refueling) async {
    _refuelings.add(refueling);

    DbUtil.insert('refueling', {
      'id': refueling.id,
      'car_id': refueling.carId,
      'date_time': refueling.dateTime.toIso8601String(),
      'odometer': refueling.odometer,
      'fuel_type': refueling.fuelType,
      'price_per_liter': refueling.pricePerLiter,
      'total_cost': refueling.totalCost,
      'liters': refueling.liters,
      'location': refueling.location,
      'is_full_tank': refueling.isFullTank ? 1 : 0,
    });

    notifyListeners();
  }
}