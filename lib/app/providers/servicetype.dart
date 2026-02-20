
import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/servicetype.dart';

class ServiceTypeProvider with ChangeNotifier {
  List<ServiceType> _serviceTypes = [];
  
  Future<void> loadServiceTypes() async {
    final dataList = await DbUtil.getData('service_type');
    _serviceTypes = dataList
        .map(
          (item) => ServiceType(
            id: item['id'],
            name: item['name'],
          ),
        )
        .toList();

    print('Tipos de serviço carregados: ${_serviceTypes.length}');

    if (_serviceTypes.isEmpty) {
      print('Nenhum tipo de serviço encontrado no banco de dados.');
      await DbUtil.ensureServiceTypesData(await DbUtil.database());
      return loadServiceTypes(); // Tente carregar novamente após garantir os dados
    } else {
      for (var serviceType in _serviceTypes) {
        print('Tipo de serviço: id=${serviceType.id}, name=${serviceType.name}');
      }
    }
    notifyListeners();
  }

  List<ServiceType> get serviceTypes {
    return [..._serviceTypes];
  }

  Future<void> addServiceType(ServiceType serviceType) async {
    _serviceTypes.add(serviceType);

    DbUtil.insert('service_type', {
      'id': serviceType.id,
      'name': serviceType.name,
    });

    notifyListeners();
  }
}