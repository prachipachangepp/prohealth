import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/qulification_licenses_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_licences_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/manage/qualification_licenses.dart';
import '../../custom_icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class LicensesChildTabbar extends StatefulWidget {
  final int employeeId;
  const LicensesChildTabbar({super.key, required this.employeeId});

  @override
  State<LicensesChildTabbar> createState() => _LicensesChildTabbarState();
}

class _LicensesChildTabbarState extends State<LicensesChildTabbar> {
  final StreamController<List<QulificationLicensesData>> streamController = StreamController<List<QulificationLicensesData>>();
  TextEditingController livensureController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController issuingOrganizationController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController numberIDController = TextEditingController();
  String docName ='';
  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FutureBuilder<List<SelectDocuments>>(
                future: selectDocument(context),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: AppSize.s350,
                          height: AppSize.s30,
                          decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                        )
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Offstage()
                    );
                  }
                  if(snapshot.hasData){
                    List dropDown = [];
                    String docType = '';
                    List<DropdownMenuItem<String>> dropDownMenuItems = [];
                    for(var i in snapshot.data!){
                      dropDownMenuItems.add(
                        DropdownMenuItem<String>(
                          child: Text(i.docName),
                          value: i.docName,
                        ),
                      );
                    }
                    return CICCDropdown(
                        width: AppSize.s200,
                        initialValue: dropDownMenuItems[0].value,
                        onChange: (val){
                          for(var a in snapshot.data!){
                            if(a.docName == val){
                              docType = a.docName;
                              docName = docType;
                              //docMetaId = docType;
                            }
                          }
                          print(":::${docType}");
                          // print(":::<>${docMetaId}");
                        },
                        items:dropDownMenuItems
                    );
                  }else{
                    return SizedBox();
                  }
                }
            ),
            SizedBox(width: AppSize.s20),
            Container(
              width: AppSize.s100,
              margin: EdgeInsets.only(right: 20),
              child: CustomIconButtonConst(
                  text: AppStringHr.add,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddLicencesPopup(
                            LivensureController: livensureController,
                            issueDateController: issueDateController,
                            expiryDateController: expiryDateController,
                            issuingOrganizationController:
                            issuingOrganizationController,
                            countryController: countryController,
                            numberIDController: numberIDController,
                            onpressedClose: () {
                              Navigator.pop(context);
                            },
                            onpressedSave: () async {
                              await addLicensePost(context, countryController.text, widget.employeeId!, expiryDateController.text, issueDateController.text,
                                  'url', livensureController.text, numberIDController.text, docName.toString(), docName.toString());
                              Navigator.pop(context);
                            },
                            title: 'Add Licence',
                            child: FutureBuilder<List<SelectDocuments>>(
                                future: selectDocument(context),
                                builder: (context,snapshot) {
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: AppSize.s350,
                                          height: AppSize.s30,
                                          decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                        )
                                    );
                                  }
                                  if (snapshot.data!.isEmpty) {
                                    return Center(
                                        child: Offstage()
                                    );
                                  }
                                  if(snapshot.hasData){
                                    List dropDown = [];
                                    String docType = '';
                                    List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                    for(var i in snapshot.data!){
                                      dropDownMenuItems.add(
                                        DropdownMenuItem<String>(
                                          child: Text(i.docName),
                                          value: i.docName,
                                        ),
                                      );
                                    }
                                    return CICCDropdown(
                                        width: AppSize.s200,
                                        initialValue: dropDownMenuItems[0].value,
                                        onChange: (val){
                                          for(var a in snapshot.data!){
                                            if(a.docName == val){
                                              docType = a.docName;
                                              docName = docType;
                                              //docMetaId = docType;
                                            }
                                          }
                                          print(":::${docType}");
                                          // print(":::<>${docMetaId}");
                                        },
                                        items:dropDownMenuItems
                                    );
                                  }else{
                                    return SizedBox();
                                  }
                                }
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s1,
        ),
        StreamBuilder<List<QulificationLicensesData>>(
          stream: streamController.stream,
          builder: (context,snapshot) {
            getEmployeeLicenses(context,widget.employeeId).then((data) {
              streamController.add(data);
            }).catchError((error) {
              // Handle error
            });
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
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
                        color: ColorManager.mediumgrey),
                  ));
            }
            if(snapshot.hasData){
              return Wrap(
                spacing: 10,
                  children:
                  List.generate(snapshot.data!.length, (index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                      child: Container(
                        //height:300,
                        width: MediaQuery.of(context).size.width/2.5,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        height:  MediaQuery.of(context).size.height/3.3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 80,
                            vertical: MediaQuery.of(context).size.height / 120,
                          ),
                          child: Column(
                            children: [
                               Row(
                                children: [
                                  Text('License #${snapshot.data![index].licenseId}',
                                    style: TextStyle(
                                      fontFamily: 'FiraSans',
                                      fontSize: FontSize.s13,
                                      color: ColorManager.blackfaint,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/50,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Licensure/Certification',
                                          style: ThemeManager.customTextStyle(context)),
                                      const SizedBox(height: AppSize.s10),
                                      Text('Issuing Organization',
                                          style: ThemeManager.customTextStyle(context)),
                                      const SizedBox(height: AppSize.s10),
                                      Text('Country',
                                          style: ThemeManager.customTextStyle(context)),
                                      const SizedBox(height: AppSize.s10),
                                      Text('Number/ID',
                                          style: ThemeManager.customTextStyle(context)),
                                    ],),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![index].licenure,
                                        style: ThemeManagerDark.customTextStyle(context),),
                                      const SizedBox(height: AppSize.s10),
                                      Text(snapshot.data![index].org,
                                        style: ThemeManagerDark.customTextStyle(context),),
                                      const SizedBox(height: AppSize.s10),
                                      Text(snapshot.data![index].country,
                                        style: ThemeManagerDark.customTextStyle(context),),
                                      const SizedBox(height: AppSize.s10),
                                      Text(snapshot.data![index].licenseNumber,
                                        style: ThemeManagerDark.customTextStyle(context),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Issue Date',
                                          style: ThemeManager.customTextStyle(context)),
                                      const SizedBox(height: AppSize.s10),
                                      Text('End Date',
                                          style: ThemeManager.customTextStyle(context)),
                                      const SizedBox(height: AppSize.s50)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![index].issueDate,
                                        style: ThemeManagerDark.customTextStyle(context),),
                                      const SizedBox(height: AppSize.s10),
                                      Text(snapshot.data![index].expData,
                                        style: ThemeManagerDark.customTextStyle(context),),
                                      const SizedBox(height: AppSize.s50,)

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height/40,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  snapshot.data![index].approved == false ?
                                  CustomIconButton(text: 'Reject', color: ColorManager.white,textColor: ColorManager.blueprime,onPressed: () async{
                                    await rejectLicensePatch(context, snapshot.data![index].licenseId);
                                  }) :SizedBox() ,
                                  const SizedBox(width: AppSize.s5),
                                  snapshot.data![index].approved == true ?
                                  Text('Approved',
                                      textAlign: TextAlign.center,
                                      style: CustomTextStylesCommon.commonStyle(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.bold,
                                          color: ColorManager.blueprime)) :  CustomIconButton(
                                      text: 'Approve', onPressed: () async{
                                    await approveLicensePatch(context, snapshot.data![index].licenseId);
                                  })
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              );
            }
            else{
              return const SizedBox();
            }
          }
        ),
      ],
    );
  }
}