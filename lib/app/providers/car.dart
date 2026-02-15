import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/car.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];

  Future<void> loadCars() async {
    final dataList = await DbUtil.getData('car');
    _cars = dataList
        .map(
          (item) => Car(
            id: item['id'],
            name: item['name'],
            plate: item['plate'],
            brand: item['brand'],
            model: item['model'],
            year: item['year'],
            tankVolume: item['tank_volume'],
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Car> get cars {
    return [..._cars];
  }

  Future<void> addCar(Car car) async {
    _cars.add(car);

    DbUtil.insert('car', {
      'id': car.id,
      'name': car.name,
      'plate': car.plate ?? '',
      'brand': car.brand,
      'model': car.model,
      'year': car.year,
      'tank_volume': car.tankVolume,
    });

    notifyListeners();
  }
}
