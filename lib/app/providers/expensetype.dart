
import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/expensetype.dart';

class ExpenseTypeProvider with ChangeNotifier {
  List<ExpenseType> _expenseTypes = [];
  
  Future<void> loadExpenseTypes() async {
    final dataList = await DbUtil.getData('expense_type');
    _expenseTypes = dataList
        .map(
          (item) => ExpenseType(
            id: item['id'],
            name: item['name'],
          ),
        )
        .toList();

    print('Tipos de despesa carregados: ${_expenseTypes.length}');

    if (_expenseTypes.isEmpty) {
      print('Nenhum tipo de despesa encontrado no banco de dados.');
      await DbUtil.ensureExpenseTypesData(await DbUtil.database());
      return loadExpenseTypes(); // Tente carregar novamente após garantir os dados
    } else {
      for (var expenseType in _expenseTypes) {
        print('Tipo de despesa: id=${expenseType.id}, name=${expenseType.name}');
      }
    }
    notifyListeners();
  }

  List<ExpenseType> get expenseTypes {
    return [..._expenseTypes];
  }

  Future<void> addExpenseType(ExpenseType expenseType) async {
    _expenseTypes.add(expenseType);

    DbUtil.insert('expense_type', {
      'id': expenseType.id,
      'name': expenseType.name,
    });

    notifyListeners();
  }
}