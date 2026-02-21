import 'package:flutter/foundation.dart';
import 'package:karango_app/app/core/db.dart';
import 'package:karango_app/app/models/tirecalibrationdetail.dart';

class TireCalibrationDetailProvider with ChangeNotifier {
  List<TireCalibrationDetail> _tireCalibrations = [];

  Future<void> loadTireCalibrations() async {
    final dataList = await DbUtil.getData('tire_calibration_detail');
    _tireCalibrations = dataList
        .map(
          (item) => TireCalibrationDetail(
            id: item['id'],
            calibrationId: item['calibration_id'],
            position: item['position'],
            pressure: item['pressure'],
          ),
        )
        .toList();
  }

  Future<List<TireCalibrationDetail>> loadTireCalibrationsByCalibrationId(int calibrationId) async {
    final dataList = await DbUtil.getData('tire_calibration_detail');
    _tireCalibrations = dataList
        .where((item) => item['calibration_id'] == calibrationId)
        .map(
          (item) => TireCalibrationDetail(
            id: item['id'],
            calibrationId: item['calibration_id'],
            position: item['position'],
            pressure: item['pressure'],
          ),
        )
        .toList();
    return _tireCalibrations;
  }
}
