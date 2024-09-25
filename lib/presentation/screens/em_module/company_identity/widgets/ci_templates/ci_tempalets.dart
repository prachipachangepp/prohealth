import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButtonConst(
                  width: 130,
                    icon: Icons.add,
                    text: "Add Template", onPressed: () {},
                    ),
              ],
            ),
          ),
          Center(child:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 140),
            child: Text(
              "No Templates available!",
              style:  TextStyle(
              fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.mediumgrey
            ),),
          )),
        ],
      ),
    );
  }
}
