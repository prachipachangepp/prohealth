import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/whitelabelling_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/home_hr.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import 'dart:async';


class CCSuccessPopup extends StatefulWidget {
  const CCSuccessPopup({super.key});

  @override
  State<CCSuccessPopup> createState() => _CCSuccessPopupState();
}

class _CCSuccessPopupState extends State<CCSuccessPopup> {


  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Success",
                      style:CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s14,
                          color: ColorManager.white
                      ),
                      // style: GoogleFonts.firaSans(
                      //   fontSize: FontSize.s14,
                      //   fontWeight: FontWeightManager.semiBold,
                      //   color: ColorManager.white,
                      //   decoration: TextDecoration.none,
                      // ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> WhitelabellingScreen()));
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close,color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Text('Save Successfully \nThank You.',textAlign: TextAlign.center,
                  style:CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.s14,
                      color: ColorManager.mediumgrey
                  ),),
              ),
            ),
            Spacer(),

            //
          ],
        ),
      ),
    );
  }
}

class EditSuccessPopup extends StatefulWidget {
  final String message;

  const EditSuccessPopup({super.key, required this.message});

  @override
  State<EditSuccessPopup> createState() => _EditSuccessPopupState();
}

class _EditSuccessPopupState extends State<EditSuccessPopup> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Success",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Text('Submitted Successfully \nThank You.',textAlign: TextAlign.center,
                  style:CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s16,
                      color: ColorManager.mediumgrey
                  ),),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class VendorSelectNoti extends StatefulWidget {
  final String message;
  const VendorSelectNoti({super.key, required this.message});

  @override
  State<VendorSelectNoti> createState() => _VendorSelectNotiState();
}

class _VendorSelectNotiState extends State<VendorSelectNoti> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Required",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Center(
                  child: Text(widget.message == ""?'Added Successfully \nThank You.':widget.message,textAlign: TextAlign.center,
                    style:GoogleFonts.firaSans(
                        fontWeight:FontWeight.w500,
                        fontSize: FontSize.s14,
                        color: ColorManager.mediumgrey
                    ),),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class AddSuccessPopup extends StatefulWidget {
  final String message;

  const AddSuccessPopup({super.key, required this.message});

  @override
  State<AddSuccessPopup> createState() => _AddSuccessPopupState();
}

class _AddSuccessPopupState extends State<AddSuccessPopup> {



  @override
  void initState() {
    super.initState();

    // Timer(Duration(seconds: 3), () {
    //   if (Navigator.of(context).canPop()) {
    //     Navigator.of(context).pop();
    //   }
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Success",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Center(
                  child: Text(widget.message == ""?'Added Successfully \nThank You.':widget.message,textAlign: TextAlign.center,
                    style:GoogleFonts.firaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.s14,
                        color: ColorManager.mediumgrey
                    ),),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}


class CountySuccessPopup extends StatefulWidget {
  final String message;

  const CountySuccessPopup({super.key, required this.message});

  @override
  State<CountySuccessPopup> createState() => _CountySuccessPopupState();
}

class _CountySuccessPopupState extends State<CountySuccessPopup> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Success",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Text('Save Successfully \nThank You.',textAlign: TextAlign.center,
                  style:CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize.s14,
                      color: ColorManager.mediumgrey
                  ),),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}



