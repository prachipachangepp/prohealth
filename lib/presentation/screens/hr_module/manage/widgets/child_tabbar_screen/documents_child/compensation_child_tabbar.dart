import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../../app/resources/theme_manager.dart';

class CompensationChildTabbar extends StatefulWidget {
  const CompensationChildTabbar({super.key});

  @override
  State<CompensationChildTabbar> createState() =>
      _CompensationChildTabbarState();
}

class _CompensationChildTabbarState extends State<CompensationChildTabbar> {
  TextEditingController editCompensationIdController = TextEditingController();
  TextEditingController editCompensationNameController =
      TextEditingController();
  TextEditingController compensitionAddIdController = TextEditingController();
  TextEditingController compensitionAddNameController = TextEditingController();
  final StreamController<List<OnboardingAckHealthData>> _controllerCompensation = StreamController<List<OnboardingAckHealthData>>();
  String compensationExpiryType = '';
  final StreamController<List<EmployeeDocumentModal>> _controller =
      StreamController<List<EmployeeDocumentModal>>();
  String expiryType = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // width: 100,
              margin: EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                width: 100,
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDocumedAddPopup(
                            // idController: compensitionAddIdController,
                            // nameController: compensitionAddNameController,
                            // expiryType: compensationExpiryType,
                            labelName: 'Add Compensation',
                            AcknowledgementnameController:
                            compensitionAddNameController, onSavePressed: () {  },
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
                                          child: Text(i.documentName,),
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
                            ),
                            // onSavePredded: () async {
                            //   await addEmployeeDocSetup(
                            //       context,
                            //       11,
                            //       compensitionAddNameController.text,
                            //       compensationExpiryType.toString(),
                            //       DateTime.now() as String);
                            //   Navigator.pop(context);
                            //   compensitionAddIdController.clear();
                            //   compensitionAddNameController.clear();
                            //   compensationExpiryType = '';
                            // },
                          );
                        });
                    //
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder(
            stream: _controllerCompensation.stream,
            builder: (context, snapshot) {
              getAckHealthRecord(context, 11, 36, 36).then((data) {
                _controllerCompensation.add(data);
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
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height/1,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var compaensation = snapshot.data![index];

                      var fileUrl = compaensation.DocumentUrl;
                      final fileExtension = fileUrl.split('.').last.toLowerCase();

                      Widget fileWidget;

                      if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
                        fileWidget = Image.network(
                          fileUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 45,
                              color: ColorManager.faintGrey,
                            );
                          },
                        );
                      }
                      else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                        fileWidget = Icon(
                          Icons.description,
                          size: 45,
                          color: ColorManager.faintGrey,
                        );
                      } else {
                        fileWidget = Icon(
                          Icons.insert_drive_file,
                          size: 45,
                          color: ColorManager.faintGrey,
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 100),
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.25),
                                  //spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 62,
                                        height: 45,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 2,
                                              color: ColorManager.faintGrey),
                                        ),
                                        child: Image.asset('images/Vector.png')),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'ID:${compaensation.employeeId}',
                                            style: AknowledgementStyleConst
                                                .customTextStyle(context)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(compaensation.DocumentName,
                                            style: TextStyle(
                                              fontFamily: 'FiraSans',
                                              fontSize: 10,
                                              color: Color(0xFF686464),
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                //SizedBox(width: MediaQuery.of(context).size.width/2.2,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.refresh_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        try{
                                          final String token = await TokenManager.getAccessToken();
                                          var response = await http.get(Uri.file(compaensation.DocumentUrl),headers: {
                                            'accept': 'application/json',
                                            'Authorization': 'Bearer $token',
                                            'Content-Type': 'application/json'
                                          },);
                                         // final widgets = await HTMLToPdf().convert(body);

                                          if (response.statusCode == 200) {
                                            final String content = response.body;

                                            final pdf = pw.Document();

                                            pdf.addPage(
                                              pw.Page(
                                                build: (pw.Context context) => pw.Center(
                                                  child: pw.Text(content),
                                                ),
                                              ),
                                            );

                                            await Printing.layoutPdf(
                                              onLayout: (PdfPageFormat format) async => pdf.save(),
                                            );
                                          } else {
                                            // Handle error
                                            print('Failed to load document');
                                          }

                                        }catch(e){
                                          print('Error ${e}');

                                        }
                                      },
                                      icon: Icon(
                                        Icons.print_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        downloadFile(fileUrl);
                                      },
                                      icon: Icon(
                                        Icons.save_alt_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDocumedAddPopup(
                                                // idController: compensitionAddIdController,
                                                // nameController: compensitionAddNameController,
                                                // expiryType: compensationExpiryType,
                                                labelName: 'Edit Compensation',
                                                AcknowledgementnameController:
                                                editCompensationNameController, onSavePressed: () {  },
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
                                                ),
                                                // onSavePredded: () async {
                                                //   await addEmployeeDocSetup(
                                                //       context,
                                                //       11,
                                                //       compensitionAddNameController.text,
                                                //       compensationExpiryType.toString(),
                                                //       DateTime.now() as String);
                                                //   Navigator.pop(context);
                                                //   compensitionAddIdController.clear();
                                                //   compensitionAddNameController.clear();
                                                //   compensationExpiryType = '';
                                                // },
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DeletePopup(onCancel: () {
                                                  Navigator.pop(context);
                                                }, onDelete: () {
                                                  setState(() async {

                                                    Navigator.pop(context);
                                                  });
                                                }, title: 'Delete Compensation',));
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Color(0xffFF0000),
                                      ),
                                      iconSize: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            }),
      ],
    );
  }
}
