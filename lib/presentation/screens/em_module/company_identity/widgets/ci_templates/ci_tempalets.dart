import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

class CiTempalets extends StatefulWidget {
  const CiTempalets({super.key});

  @override
  State<CiTempalets> createState() => _CiTempaletsState();
}

class _CiTempaletsState extends State<CiTempalets> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomIconButtonConst(
                icon: Icons.add,
                text: "Add Doctype", onPressed: (){

            }),
          ),
        ],),
    );
  }
}
