import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../onboarding/download_doc_const.dart';
///download
class AcknowledgementsChildBar extends StatefulWidget {
  const AcknowledgementsChildBar({super.key});

  @override
  State<AcknowledgementsChildBar> createState() => _AcknowledgementsChildBarState();
}

class _AcknowledgementsChildBarState extends State<AcknowledgementsChildBar> {
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
  TextEditingController acknowldgementNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAckHealthRecord(context, 10, 48, 2).then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
               width: 100,
              margin: EdgeInsets.only(right: 20),
              child: CustomIconButtonConst(
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){
                      return AcknowledgementAddPopup(labelName: 'Add Acknowledgement',
                        AcknowledgementnameController: acknowldgementNameController, onSavePressed: () async{
                        },
                        child: FutureBuilder<List<EmployeeDocSetupModal>>(
                            future: getEmployeeDocSetupDropDown(context),
                            builder: (context,snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 350,
                                      height: 30,
                                      decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                    )
                                );
                              }
                              if (snapshot.data!.isEmpty) {
                                return Center(
                                  child: Text(
                                    AppString.dataNotFound,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s12,
                                      color: ColorManager.mediumgrey,
                                    ),
                                  ),
                                );
                              }
                              if(snapshot.hasData){
                                List dropDown = [];
                                int docType = 0;
                                List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                for(var i in snapshot.data!){
                                  dropDownMenuItems.add(
                                    DropdownMenuItem<String>(
                                      child: Text(i.documentName),
                                      value: i.documentName,
                                    ),
                                  );
                                }
                                return CICCDropdown(
                                    initialValue: dropDownMenuItems[0].value,
                                    onChange: (val){
                                      for(var a in snapshot.data!){
                                        if(a.documentName == val){
                                          docType = a.employeeDocMetaDataId;
                                          //docMetaId = docType;
                                        }
                                      }
                                      print(":::${docType}");
                                      //print(":::<>${docMetaId}");
                                    },
                                    items:dropDownMenuItems
                                );
                              }else{
                                return SizedBox();
                              }
                            }
                        ),);
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

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  AppString.dataNotFound,
                  style: CustomTextStylesCommon.commonStyle(
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s12,
                    color: ColorManager.mediumgrey,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: MediaQuery.of(context).size.height / 1,
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
                    final fileExtension = fileUrl.split('.').last.toLowerCase();

                    Widget fileWidget;

                    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
                      fileWidget = Image.network(
                        fileUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 25,
                            color: ColorManager.blueprime,
                          );
                        },
                      );
                    } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                      fileWidget = Icon(
                        Icons.description,
                        size: 25,
                        color: ColorManager.blueprime,
                      );
                    } else {
                      fileWidget = Icon(
                        Icons.insert_drive_file,
                        size: 25,
                        color: ColorManager.blueprime,
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Container(
                        width: AppSize.s500,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => downloadFile(fileUrl), // Use the utility function
                              child: Container(
                                width: 62,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 2, color: ColorManager.faintGrey),
                                ),
                                child: fileWidget,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                data.ReminderThreshold,
                                style: AknowledgementStyleConst.customTextStyle(context),
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
