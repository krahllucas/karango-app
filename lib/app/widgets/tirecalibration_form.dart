import 'package:flutter/material.dart';

class TireCalibrationFormWidget extends StatefulWidget {
  const TireCalibrationFormWidget({
    super.key,
    required this.tireCount,
  });

  final int tireCount;

  @override
  State<TireCalibrationFormWidget> createState() => TireCalibrationFormWidgetState();
}

class TireCalibrationFormWidgetState extends State<TireCalibrationFormWidget> {
  late final List<TextEditingController> _tireControllers;

  @override
  void initState() {
    super.initState();
    _tireControllers = List.generate(
      widget.tireCount,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final controller in _tireControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> getTireDetails() {
    return List.generate(
      _tireControllers.length,
      (index) => {
        'position': 'p${index + 1}',
        'pressure': double.tryParse(_tireControllers[index].text) ?? 0.0,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _tireControllers.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tireControllers[i],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.tireCount == 2
                          ? (i == 0 ? 'Dianteiro' : 'Traseiro')
                          : widget.tireCount == 4
                              ? (i == 0
                                  ? 'Dianteiro Esq.'
                                  : i == 2
                                      ? 'Traseiro Esq.'
                                      : 'Pneu ${i + 1}')
                              : 'Pneu ${i + 1}',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                if (i + 1 < _tireControllers.length) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _tireControllers[i + 1],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: widget.tireCount == 2
                            ? (i == 0 ? 'Traseiro' : 'Dianteiro')
                            : widget.tireCount == 4
                                ? (i == 0
                                    ? 'Dianteiro Dir.'
                                    : i == 2
                                        ? 'Traseiro Dir.'
                                        : 'Pneu ${i + 2}')
                                : 'Pneu ${i + 2}',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
