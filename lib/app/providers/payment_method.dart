
import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/payment_method.dart';

class PaymentMethodProvider with ChangeNotifier {
  List<PaymentMethodType> _paymentMethods = [];
  
  Future<void> loadPaymentMethods() async {
    final dataList = await DbUtil.getData('payment_method');
    _paymentMethods = dataList
        .map(
          (item) => PaymentMethodType(
            id: item['id'],
            name: item['name'],
          ),
        )
        .toList();

    print('Tipos de pagamento carregados: ${_paymentMethods.length}');

    if (_paymentMethods.isEmpty) {
      print('Nenhum tipo de pagamento encontrado no banco de dados.');
      await DbUtil.ensurePaymentMethodsData(await DbUtil.database());
      return loadPaymentMethods(); // Tente carregar novamente após garantir os dados
    } else {
      for (var paymentMethod in _paymentMethods) {
        print('Tipo de pagamento: id=${paymentMethod.id}, name=${paymentMethod.name}');
      }
    }
    notifyListeners();
  }

  List<PaymentMethodType> get paymentMethods {
    return [..._paymentMethods];
  }

  Future<void> addPaymentMethod(PaymentMethodType paymentMethod) async {
    _paymentMethods.add(paymentMethod);

    DbUtil.insert('payment_method', {
      'id': paymentMethod.id,
      'name': paymentMethod.name,
    });

    notifyListeners();
  }
}