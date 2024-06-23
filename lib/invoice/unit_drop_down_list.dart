import 'package:flutter/material.dart';

import '../models/unit_model.dart';

class UnitDropdown extends StatefulWidget {
  final List<UnitModel> units;
  final UnitModel? selectedUnit;
  final ValueChanged<UnitModel?> onChanged;

  const UnitDropdown({
    super.key,
    required this.units,
    this.selectedUnit,
    required this.onChanged,
  });

  @override
  _UnitDropdownState createState() => _UnitDropdownState();
}

class _UnitDropdownState extends State<UnitDropdown> {
  UnitModel? _selectedUnit;

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.selectedUnit;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<UnitModel>(
      hint: const Text('Select a Unit'),
      value: _selectedUnit,
      onChanged: (UnitModel? newValue) {
        setState(() {
          _selectedUnit = newValue;
        });
        widget.onChanged(newValue);
      },
      items: widget.units.map<DropdownMenuItem<UnitModel>>((UnitModel unit) {
        return DropdownMenuItem<UnitModel>(
          value: unit,
          child: Text(unit.unitName ?? ''),
        );
      }).toList(),
    );
  }
}