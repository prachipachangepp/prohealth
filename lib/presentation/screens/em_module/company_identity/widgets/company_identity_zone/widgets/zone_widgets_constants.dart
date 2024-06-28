import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';

class CIZoneAddPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController zipcodeController;
  final TextEditingController? mapController;
  final TextEditingController? landmarkController;
  final TextEditingController? zoneController;
  final TextEditingController? cityController;
  final TextEditingController? countryController;
  final TextEditingController? stateController;
  final Future<void> Function() onSavePressed;
  final String title1;
  final String title2;
  final String? title3;
  final String? title4;
  final String? title5;
  final String? title6;
  final String title;

  const CIZoneAddPopup({
    Key? key,
    required this.onSavePressed,
    required this.title1,
    required this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.title6,
    required this.countynameController,
    required this.zipcodeController,
    this.mapController,
    this.landmarkController,
    this.zoneController,
    this.cityController,
    this.countryController,
    this.stateController,
    required this.title,
  }) : super(key: key);

  @override
  State<CIZoneAddPopup> createState() => _CIZoneAddPopupState();
}

class _CIZoneAddPopupState extends State<CIZoneAddPopup> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: AppSize.s400,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bluebottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        widget.title,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p3,
                  horizontal: AppPadding.p20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SMTextFConst(
                      controller: widget.countynameController,
                      keyboardType: TextInputType.text,
                      text: widget.title1,
                    ),
                    SizedBox(height: AppSize.s10),
                    SMTextFConst(
                      controller: widget.zipcodeController,
                      keyboardType: TextInputType.text,
                      text: widget.title2,
                    ),
                    if (widget.title3 != null) ...[
                      SizedBox(height: AppSize.s10),
                      SMTextFConst(
                        controller: widget.mapController!,
                        keyboardType: TextInputType.text,
                        text: widget.title3!,
                      ),
                    ],
                    if (widget.title4 != null &&
                        widget.landmarkController != null) ...[
                      SizedBox(height: AppSize.s10),
                      SMTextFConst(
                        controller: widget.landmarkController!,
                        keyboardType: TextInputType.text,
                        text: widget.title4!,
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: AppPadding.p24, top: AppPadding.p14),
                child: isLoading
                    ? SizedBox(
                    height: 25,width: 25,
                    child: CircularProgressIndicator( color: ColorManager.blueprime,))
                    : Center(
                  child: CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: AppStringEM.save,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                     await widget.onSavePressed();
                      Navigator.pop(context);
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///edit
// class CIZoneEditPopup extends StatefulWidget {
//   final TextEditingController countynameController;
//   final TextEditingController? landmarkController;
//   final VoidCallback onSavePressed;
//   final String title1;
//   final String? title2;
//   final String title;
//
//   const CIZoneEditPopup(
//       {super.key,
//       required this.countynameController,
//       this.landmarkController,
//       required this.onSavePressed,
//       required this.title1,
//       this.title2,
//         required this.title});
//
//   @override
//   State<CIZoneEditPopup> createState() => _CIZoneEditPopupState();
// }
//
// class _CIZoneEditPopupState extends State<CIZoneEditPopup> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s400,
//         height: AppSize.s210,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       widget.title,
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.close,color: ColorManager.white,),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p3,
//                 horizontal: AppPadding.p20,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SMTextFConst(
//                     controller: widget.countynameController,
//                     keyboardType: TextInputType.text,
//                     text: widget.title1,
//                   ),
//                   SizedBox(height: AppSize.s10),
//                   SMTextFConst(
//                     controller: widget.landmarkController!,
//                     keyboardType: TextInputType.text,
//                     text: widget.title2!,
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppPadding.p24),
//               child: Center(
//                 child: CustomElevatedButton(
//                   width: AppSize.s105,
//                   height: AppSize.s30,
//                   text: AppStringEM.save,
//                   onPressed: () {
//                     widget.onSavePressed();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
