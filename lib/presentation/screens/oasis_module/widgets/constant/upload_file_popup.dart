
import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
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
        height: 150,
       width: 800,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20),
        ),
  //color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            WhiteContrainerConstwidth(
              height: 100,
              width:180,
              child: Column(
                children: [
                  Image.asset("images/oasis_emr/manual_signature.png",),
                  SizedBox(height: 20,),
                  Text("Manual Signature",style: DefineWorkWeekStyle.customTextStyle(context),)
                ],
              ),
            ),
            WhiteContrainerConstwidth(
              height: 100,
              width:180,
              child: Column(
                children: [
                  Icon(Icons.camera_alt_outlined,weight: 400,color: ColorManager.mediumgrey,),
                  SizedBox(height: 20,),
                  Text("Take a Photo",style: DefineWorkWeekStyle.customTextStyle(context),)
                ],
              ),
            ),
            WhiteContrainerConstwidth(
              height: 100,
              width:180,
              child: Column(
                children: [
                  Icon(Icons.file_upload_outlined,weight: 400,color: ColorManager.mediumgrey,),
                  SizedBox(height: 20,),
                  Text("Upload File",style: DefineWorkWeekStyle.customTextStyle(context),)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
