import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../em_module/company_identity/widgets/error_pop_up.dart';
import '../../../../onboarding/download_doc_const.dart';

///download


class HRDocAckStyle {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = 10;
    // MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
  }
}

class AcknowledgementsChildBar extends StatefulWidget {
  final int employeeId;
  const AcknowledgementsChildBar({super.key, required this.employeeId});

  @override
  State<AcknowledgementsChildBar> createState() =>
      _AcknowledgementsChildBarState();
}

class _AcknowledgementsChildBarState extends State<AcknowledgementsChildBar> {
  final StreamController<List<OnboardingAckHealthData>> _controller =
      StreamController<List<OnboardingAckHealthData>>();
  TextEditingController acknowldgementNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAckHealthRecord(context, AppConfig.acknowledgementDocId, widget.employeeId, "no").then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('Employee Id in documents :: ${controller.employeeId}');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                  width: 130,
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                         return FutureBuilder<List<EmployeeDocSetupModal>>(
                              future: getEmployeeDocSetupDropDown(context,AppConfig.acknowledgementDocId),
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  return AcknowledgementAddPopup(
                                    title: 'Add Acknowledgement',
                                    employeeId: widget.employeeId,
                                    // docTypeMetaIdCC: 10,
                                    // selectedSubDocId: 48,
                                    dataList: snapshot.data!,
                                  );
                                } else {
                                  return ErrorPopUp(
                                      title: "Received Error",
                                      text: snapshot.error.toString());
                                }
                              });
                        });
                    //showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {
            getAckHealthRecord(context, AppConfig.acknowledgementDocId, widget.employeeId, "no").then((data) {
              _controller.add(data);
            }).catchError((error) {
              // Handle error
            });
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                    AppStringHRNoData.ackNoData,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s14,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Wrap(
                  children: List.generate(snapshot.data!.length, (index) {
                    final data = snapshot.data![index];
                    final fileUrl = data.DocumentUrl;
                    // var decodedImage = AppFilePickerBase64.getDecodeBase64(url: fileUrl);
                    // print("Decoded Doc ${decodedImage}");
                    // try{
                    //   // var keyGenerate =  AppFilePickerBase64.mainFun(keyUrl:fileUrl);
                    //   // print("Generated file ::: ${keyGenerate.toString()}");
                    // }catch(e){
                    //   print(e);
                    // }
                    //var decodeBse64 = EncodeDecodeBase64.getDecodeBase64(fetchedUrl: "e7c0ec2f-e346-41dc-90bb-a33b2546da4d-uORbh4Ir0xlsTcArxhByr0O");
                    // print("File:::>>${decodeBse64}");
                    final fileExtension = fileUrl.split('/').last;

                    Widget fileWidget;
                    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
                      fileWidget = Image.network(
                        fileUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.file_copy_outlined,
                            //Icons.broken_image,
                            size: 25,
                            color: ColorManager.blueprime,
                          );
                        },
                      );
                    } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                      fileWidget = Icon(
                        Icons.file_copy_outlined,
                        //Icons.description,
                        size: 25,
                        color: ColorManager.blueprime,
                      );
                    } else {
                      fileWidget = Icon(
                        Icons.file_copy_outlined,
                        //Icons.insert_drive_file,
                        size: 25,
                        color: ColorManager.blueprime,
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Container(
                        width: AppSize.s500,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () =>  downloadFile(fileUrl),// Use the utility function
                              child: Container(
                                  width: 62,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 2,
                                        color: ColorManager.faintGrey),
                                  ),
                                  child: Image.asset('images/Vector.png')),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.documentFileName,
                                    style: AknowledgementStyleConst
                                        .customTextStyle(context)
                                  ),
                                  Text(
                                    data.ReminderThreshold,
                                   style: AknowledgementStyleNormal.customTextStyle(context)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
