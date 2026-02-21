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
            fuelId: item['fuel_id'],
            pricePerLiter: item['price_per_liter'],
            totalCost: item['total_cost'],
            liters: item['liters'],
            location: item['location'],
            isFullTank: item['is_full_tank'] == 1,
            paymentMethodId: item['payment_method_id'],
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
      'fuel_id': refueling.fuelId,
      'price_per_liter': refueling.pricePerLiter,
      'total_cost': refueling.totalCost,
      'liters': refueling.liters,
      'location': refueling.location,
      'is_full_tank': refueling.isFullTank ? 1 : 0,
      'payment_method_id': refueling.paymentMethodId,
    });

    notifyListeners();
  }

  //buscar a media de consumo deste ultimo abastecimento com tank cheio
  double getAverageConsumption() {
    print('Calculando média de consumo...');
    final fullTankRefuelings =
        _refuelings.where((r) => r.isFullTank).toList();

    print('Abastecimentos com tanque cheio encontrados: ${fullTankRefuelings.length}');
    if (fullTankRefuelings.length < 2) {
      return 0.0; // Não há dados suficientes para calcular a média
    }

    // Consider only the two most recent full-tank refuelings
    fullTankRefuelings.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    final recentRefuelings = fullTankRefuelings.take(2).toList();

    final previous = recentRefuelings[1];
    final current = recentRefuelings[0];

    final totalLiters = current.liters;
    final totalDistance = current.odometer - previous.odometer;

    print('Litros abastecidos: $totalLiters');
    print('Distância percorrida: $totalDistance km');
    return totalDistance / totalLiters; // km por litro
  }

  double getTotalMonthlyCost() {
    final now = DateTime.now();
    final currentMonthRefuelings = _refuelings.where((r) =>
        r.dateTime.year == now.year && r.dateTime.month == now.month);
    return currentMonthRefuelings.fold(0.0, (sum, r) => sum + r.totalCost);
  }
}