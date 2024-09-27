import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/profile_bar.dart';

class ExpiredLicensePopup extends StatefulWidget {
  final String title;
  final Widget child;
  const ExpiredLicensePopup(
      {super.key, required this.title, required this.child});

  @override
  State<ExpiredLicensePopup> createState() => _ExpiredLicensePopupState();
}

class _ExpiredLicensePopupState extends State<ExpiredLicensePopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s650,
        height: AppSize.s480,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  color: ColorManager.blueprime,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                    child: Text(
                      widget.title,
                      style: ProfileBarNameLicenseStyle.customEditTextStyle()
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}
