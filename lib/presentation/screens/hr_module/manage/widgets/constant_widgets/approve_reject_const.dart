import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class ApproveRejectConst extends StatefulWidget {
  final String titleName;
  final String bodyText;
  final Future<void> Function() onpressedSave;
   ApproveRejectConst({super.key, required this.titleName, required this.bodyText, required this.onpressedSave});

  @override
  State<ApproveRejectConst> createState() => _ApproveRejectConstState();
}

class _ApproveRejectConstState extends State<ApproveRejectConst> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(20.0),
        ),
        height: 181.0,
        width: 500.0,
        child: Stack(
          children: <Widget>[
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
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 10.0),
                    child: Text(
                        widget.titleName,
                        style:
                        PopupBlueBarText.customTextStyle(context)
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                        color:
                        ColorManager.white),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0),
                child: Text(
                    widget.bodyText,
                    textAlign: TextAlign.center,
                    style: PopupTextConst.customTextStyle(context)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: AppPadding.p24,
                  right: AppPadding.p10),
              child: Align(
                alignment:
                Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop();
                      },
                      style: ElevatedButton
                          .styleFrom(
                        elevation: 5,
                        backgroundColor:
                        Colors.white,
                        foregroundColor:
                        Color(0xff1696C8),
                        side: BorderSide(
                            color: Color(
                                0xff1696C8)),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(8),
                        ),
                      ),
                      child: Text(
                          'Cancel',
                          style:TransparentButtonTextConst.customTextStyle(context)
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(
                            context)
                            .size
                            .width /
                            75),
                    load ? SizedBox(height: 25,width: 25,
                      child: CircularProgressIndicator(color: ColorManager.blueprime,),)
                        :ElevatedButton(
                      onPressed: (){
                        setState(() {
                          load = true;
                        });
                        try{
                          widget.onpressedSave();
                          Navigator.pop(context);
                        }finally{
                          setState(() {
                            load = false;
                          });
                        }
                      },
                      style: ElevatedButton
                          .styleFrom(
                        backgroundColor:
                        Color(0xff1696C8),
                        foregroundColor:
                        Colors.white,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(8),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: BlueButtonTextConst.customTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
