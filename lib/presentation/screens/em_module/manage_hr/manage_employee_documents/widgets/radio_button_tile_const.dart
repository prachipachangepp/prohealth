import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';

class CustomRadioListTile extends StatefulWidget {
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final String title;

  const CustomRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}
class _CustomRadioListTileState extends State<CustomRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
      child: Row(
         //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Radio<String>(
           splashRadius: 0,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
          ),
          // const SizedBox(width: 0),
          Text(
            widget.title,
            style: DocumentTypeDataStyle.customTextStyle(context),
          ),
        SizedBox( width: AppSize.s40,)
        ],
      ),
    );
  }
}
