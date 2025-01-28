
import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
//import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../them_manager/oasis_them_mnager.dart';
import 'green_container_constant.dart';

class UploadFilePopup extends StatefulWidget {
  const UploadFilePopup({super.key});

  @override
  State<UploadFilePopup> createState() => _UploadFilePopupState();
}

class _UploadFilePopupState extends State<UploadFilePopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: AppSize.s150,
       width: AppSize.s800,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20),
        ),
  //color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            WhiteContrainerConstwidth(
              height: AppSize.s100,
              width:AppSize.s180,
              child: Column(
                children: [
                  Image.asset("images/oasis_emr/manual_signature.png",),
                  SizedBox(height: AppSize.s20,),
                  Text("Manual Signature",style: BoldfontStyle.customTextStyle(context),)
                ],
              ),
            ),
            WhiteContrainerConstwidth(
              height: AppSize.s100,
              width:AppSize.s180,
              child: Column(
                children: [
                  Icon(Icons.camera_alt_outlined,weight: 400,color: ColorManager.mediumgrey,),
                  SizedBox(height: AppSize.s20,),
                  Text("Take a Photo",style: BoldfontStyle.customTextStyle(context),)
                ],
              ),
            ),
            WhiteContrainerConstwidth(
              height: AppSize.s100,
              width:AppSize.s180,
              child: Column(
                children: [
                  Icon(Icons.file_upload_outlined,weight: 400,color: ColorManager.mediumgrey,),
                  SizedBox(height: AppSize.s20,),
                  Text("Upload File",style: BoldfontStyle.customTextStyle(context),)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
