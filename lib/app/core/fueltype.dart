
class Fueltype {
  static const int gasoline = 1;
  static const int ethanol = 2;
  static const int diesel = 3;

  static String getFuelName(int fuelType) {
    switch (fuelType) {
      case gasoline:
        return 'Gasolina';
      case ethanol:
        return 'Etanol';
      case diesel:
        return 'Diesel';
      default:
        return 'Desconecido';
    }
  }

  static Map<int, String> get fuelTypes {
    return {
      gasoline: 'Gasolina',
      ethanol: 'Etanol',
      diesel: 'Diesel',
    };
  }
}