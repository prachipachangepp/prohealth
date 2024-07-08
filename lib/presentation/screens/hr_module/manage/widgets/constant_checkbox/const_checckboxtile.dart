import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class CheckboxTile extends StatefulWidget {
  final String title;
  final bool initialValue;
  final Function(bool)? onChanged;

  CheckboxTile({
    required this.title,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  _CheckboxTileState createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title,style: TextStyle(fontSize: AppSize.s10,fontWeight: FontWeightManager.bold),),
      leading: Checkbox(
        activeColor: ColorManager.blueprime,
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value!;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(_value);
          }
        },
      ),
    );
  }
}
