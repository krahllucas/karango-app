
import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/fuel.dart';

class FuelProvider with ChangeNotifier {
  List<Fuel> _fuels = [];
  
  Future<void> loadFuels() async {
    final dataList = await DbUtil.getData('fuel');
    _fuels = dataList
        .map(
          (item) => Fuel(
            id: item['id'],
            name: item['name'],
            type: item['type'],
          ),
        )
        .toList();

    print('Combustíveis carregados: ${_fuels.length}');

    if (_fuels.isEmpty) {
      print('Nenhum combustível encontrado no banco de dados.');
      await DbUtil.ensureFuelData(await DbUtil.database());
      return loadFuels(); // Tente carregar novamente após garantir os dados
    } else {
      for (var fuel in _fuels) {
        print('Combustível: id=${fuel.id}, name=${fuel.name}, type=${fuel.type}');
      }
    }
    notifyListeners();
  }

  List<Fuel> get fuels {
    return [..._fuels];
  }

  List<Fuel> getFuelsByTypes(List<int> types) {
    return _fuels.where((fuel) => types.contains(fuel.type)).toList();
  }

  Future<void> addFuel(Fuel fuel) async {
    _fuels.add(fuel);

    DbUtil.insert('fuel', {
      'id': fuel.id,
      'name': fuel.name,
      'type': fuel.type,
    });

    notifyListeners();
  }
}