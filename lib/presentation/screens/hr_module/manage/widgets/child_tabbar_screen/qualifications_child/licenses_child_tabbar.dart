import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/qulification_licenses_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/new_org_doc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_licences_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/const_card_details.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/manage/qualification_licenses.dart';
import '../../custom_icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class LicensesChildTabbar extends StatelessWidget {
  final int employeeId;
   LicensesChildTabbar({super.key, required this.employeeId});

  String _trimAddress(String address) {
    const int maxLength = 35;
    if (address.length > maxLength) {
      return '${address.substring(0, maxLength)}...';
    }
    return address;
  }

  OverlayEntry? _overlayEntry;

  bool _isOverlayVisible = false;

  // OverlayEntry _createOverlayEntry(BuildContext context, Offset position, String text) {
  @override
  Widget build(BuildContext context) {
    final licenseProviderState = Provider.of<HrManageProvider>(context,listen: false);
    final LayerLink _layerLink = LayerLink();
    final StreamController<List<QulificationLicensesFilteredData>> streamController = StreamController<List<QulificationLicensesFilteredData>>();
    TextEditingController livensureController = TextEditingController();
    TextEditingController issueDateController = TextEditingController();
    TextEditingController expiryDateController = TextEditingController();
    TextEditingController issuingOrganizationController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController numberIDController = TextEditingController();
    String docName ='Select';
    String docNameadd ='Select';
    String docNameEdit ='';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FutureBuilder<List<NewOrgDocument>>(
                  future: getNewOrgDocfetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 200),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return  Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10)),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: Text("No licenses available",style: DocumentTypeDataStyle.customTextStyle(context),)),
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
                     // docName = snapshot.data![0].docName;
                      return CICCDropdown(
                          width: 200,
                       initialValue: docName,
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
              SizedBox(width: 10),
              ///Add button
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButtonConst(
                    text: AppStringHr.add,
                    icon: Icons.add,
                    onPressed: () {
                      livensureController.clear();
                      issueDateController.clear();
                      expiryDateController.clear();
                      issuingOrganizationController.clear();
                      countryController.clear();
                      numberIDController.clear();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddLicencesPopup(
                              onpressedClose: () {
                                // Navigator.pop(context);
                              },
                              title: 'Add License', employeeId: employeeId,
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 1,
        // ),
        StreamBuilder<List<QulificationLicensesFilteredData>>(
            stream: streamController.stream,
            builder: (context,snapshot) {
              getEmployeeLicensesFilteredData(context,employeeId,docName).then((data) {
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
              if (snapshot.data!.isEmpty ) {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        AppStringHRNoData.licenseNoData,
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    ));
              }
              if(snapshot.hasData){
                return WrapWidget(
                    children: List.generate(snapshot.data!.length, (index){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        licenseProviderState.trimOrgString(snapshot.data![index].org ?? '--');
                      });
                      return CardDetails(childWidget: DetailsFormate(
                        titleRow: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                        'License #${index + 1}',
                                // 'Employment #${snapshot.data![index].employmentId}',
                                style: BoxHeadingStyle.customTextStyle(context)),
                            if (snapshot.data![index].approved != null && snapshot.data![index].approved == true)
                              BorderIconButton(iconData: Icons.edit_outlined, buttonText: "Edit",
                                onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FutureBuilder<QulificationLicensesPreFillData>(
                                      future:getEmployeeLicensesPreFill(context,snapshot.data![index].licenseId),
                                      builder: (context,snapshotPrefill) {
                                        if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                          return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                        }
                                        var country = snapshotPrefill.data!.country;
                                        countryController = TextEditingController(text: snapshotPrefill.data!.country);

                                        var expDate = snapshotPrefill.data!.expData;
                                        expiryDateController = TextEditingController(text: snapshotPrefill.data!.expData);

                                        var issueDate = snapshotPrefill.data!.issueDate;
                                        issueDateController = TextEditingController(text: snapshotPrefill.data?.issueDate);

                                        var licensure = snapshotPrefill.data!.licenure;
                                        livensureController = TextEditingController(text: snapshotPrefill.data?.licenure);


                                        var licenseNumber = snapshotPrefill.data!.licenseNumber;
                                        numberIDController = TextEditingController(text: snapshotPrefill.data!.licenseNumber);

                                        docNameEdit = snapshotPrefill.data!.documentType;
                                        var org = snapshotPrefill.data!.org;
                                        issuingOrganizationController = TextEditingController(text: snapshotPrefill.data!.org);

                                        var licenseUrl = snapshotPrefill.data!.licenseUrl;

                                        return EditLicencesPopup(
                                          LivensureController: livensureController,
                                          issueDateController: issueDateController,
                                          expiryDateController: expiryDateController,
                                          issuingOrganizationController: issuingOrganizationController,
                                          countryController: countryController,
                                          numberIDController: numberIDController,
                                          onpressedClose: () {
                                            // Navigator.pop(context);
                                          },
                                          onpressedSave: () async {
                                            var response = await updateLicensePatch(context,
                                                snapshot.data![index].licenseId,
                                                country == countryController.text ? country.toString() : countryController.text,
                                                employeeId,
                                                expDate == expiryDateController.text ? expDate.toString() : expiryDateController.text,
                                                issueDate == issueDateController.text ? issueDate.toString() : issueDateController.text,
                                                licenseUrl,
                                                licensure == livensureController.text ? licensure : livensureController.text,
                                                licenseNumber == numberIDController.text ? licenseNumber.toString() : numberIDController.text,
                                                org == issuingOrganizationController.text ? org : issuingOrganizationController.text,
                                                docNameEdit.toString());

                                            if(response.statusCode == 200 || response.statusCode == 201){
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AddSuccessPopup(
                                                    message: 'Licenses Edited Successfully',
                                                  );
                                                },
                                              );
                                            }else if(response.statusCode == 400 || response.statusCode == 404){
                                              // Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) => const FourNotFourPopup(),
                                              );
                                            }
                                            else {
                                              //Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) => FailedPopup(text: response.message),
                                              );
                                            }
                                          },
                                          title: 'Edit License',
                                          licenseId: snapshot.data![index].licenseId,
                                          documentName: snapshotPrefill.data!.documentName,
                                          child: FutureBuilder<List<NewOrgDocument>>(
                                              future: getNewOrgDocfetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 200),
                                              builder: (context,snapshot) {
                                                if(snapshot.connectionState == ConnectionState.waiting){
                                                  return Container(
                                                    // width: 200,
                                                    height: 30,
                                                    width: MediaQuery.of(context).size.width / 6,
                                                    decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.circular(10)),
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
                                                    // width: 200,
                                                      width: MediaQuery.of(context).size.width / 6,
                                                      initialValue: docNameEdit,

                                                      onChange: (val){
                                                        for(var a in snapshot.data!){
                                                          if(a.docName == val){
                                                            docType = a.docName;
                                                            docNameEdit = docType;
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
                                      }
                                    );
                                  });
                            })
                          ],
                        ),
                        title: 'License #${index + 1}',
                        row1Child1: [
                          Text('Licensure/Certification :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: 10,),
                          Text('Issuing Organization :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: 10,),
                          Text('Country :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: 10,),
                          Text('Number/ID :',
                              style: ThemeManagerDark.customTextStyle(context)),
                        ],
                        row1Child2: [
                          Text(snapshot.data![index].licenure,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: 10,),
                          MouseRegion(
                            onHover: (event){
                              licenseProviderState.showOverlay(context, event.position, snapshot.data![index].org ?? '--');
                            },
                            onExit: (_) {
                              licenseProviderState.removeOverlay();
                            },
                            child: CompositedTransformTarget(link: _layerLink,
                              child: Text(
                                licenseProviderState.trimmedOrg,
                                style: ThemeManagerDarkFont.customTextStyle(context),
                              ),),
                          ),
                          // Text(_trimAddress(snapshot.data![index].org),
                          //   style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: 10,),
                          Text(snapshot.data![index].country,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: 10,),
                          Text(snapshot.data![index].licenseNumber,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                        ],
                        row2Child1: [
                          Text('Issue Date :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: 10,),
                          Text('End Date :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: 50,)
                        ],
                        row2Child2: [
                          Text(snapshot.data![index].issueDate,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: 10,),
                          Text(snapshot.data![index].expData,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: 50,)
                        ],
                        button: Align(
                          alignment:Alignment.centerRight,
                            child: snapshot.data![index].approved == null ? Text('Not Approved',style:TextStyle(
                              fontSize: 12,
                              color: ColorManager.mediumgrey,
                              fontWeight: FontWeight.w600,
                            )):snapshot.data![index].approved == false ?Text('Rejected',style:TextStyle(
                              fontSize: 12,
                              color: ColorManager.mediumgrey,
                              fontWeight: FontWeight.w600,
                            )) :Text('Approved',style:TextStyle(
                              fontSize: 12,
                              color: ColorManager.blueprime,
                              fontWeight: FontWeight.w600,
                            ))
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     snapshot.data![index].approved == false ?
                        //     CustomIconButton(text: 'Reject', color: ColorManager.white,textColor: ColorManager.blueprime,onPressed: () async{
                        //       await rejectLicensePatch(context, snapshot.data![index].licenseId);
                        //     }) :SizedBox() ,
                        //     const SizedBox(width: 5,),
                        //     snapshot.data![index].approved == true ?
                        //     Text('Approved',
                        //         textAlign: TextAlign.center,
                        //         style: CustomTextStylesCommon.commonStyle(
                        //             fontSize: FontSize.s12,
                        //             fontWeight: FontWeightManager.bold,
                        //             color: ColorManager.blueprime)) :  CustomIconButton(
                        //         text: 'Approve', onPressed: () async{
                        //       await approveLicensePatch(context, snapshot.data![index].licenseId);
                        //     })
                        //   ],
                        // )
                      ));
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                      //   child: Container(
                      //     //height:300,
                      //     width: MediaQuery.of(context).size.width/2.5,
                      //     decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.withOpacity(0.5),
                      //           spreadRadius: 1,
                      //           blurRadius: 4,
                      //           offset: const Offset(0, 4),
                      //         ),
                      //       ],
                      //       color: Colors.white,
                      //       borderRadius: const BorderRadius.all(Radius.circular(12)),
                      //     ),
                      //     // height:  MediaQuery.of(context).size.height/3.5,
                      //     height: MediaQuery.of(context).size.height/3.9,
                      //     padding: EdgeInsets.all(5),
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: MediaQuery.of(context).size.width / 80,
                      //         vertical: MediaQuery.of(context).size.height / 120,
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Text(
                      //                   'License #${index + 1}',
                      //                   // 'License #${snapshot.data![index].licenseId}',
                      //                   style:BoxHeadingStyle.customTextStyle(context)),
                      //             ],
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text('Licensure/Certification :',
                      //                       style: ThemeManagerDark.customTextStyle(context)),
                      //                   const SizedBox(height: 10,),
                      //                   Text('Issuing Organization :',
                      //                       style: ThemeManagerDark.customTextStyle(context)),
                      //                   const SizedBox(height: 10,),
                      //                   Text('Country :',
                      //                       style: ThemeManagerDark.customTextStyle(context)),
                      //                   const SizedBox(height: 10,),
                      //                   Text('Number/ID :',
                      //                       style: ThemeManagerDark.customTextStyle(context)),
                      //                 ],),
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(snapshot.data![index].licenure,
                      //                     style: ThemeManagerDarkFont.customTextStyle(context),),
                      //                   const SizedBox(height: 10,),
                      //                   Text(snapshot.data![index].org,
                      //                     style: ThemeManagerDarkFont.customTextStyle(context),),
                      //                   const SizedBox(height: 10,),
                      //                   Text(snapshot.data![index].country,
                      //                     style: ThemeManagerDarkFont.customTextStyle(context),),
                      //                   const SizedBox(height: 10,),
                      //                   Text(snapshot.data![index].licenseNumber,
                      //                     style: ThemeManagerDarkFont.customTextStyle(context),),
                      //                 ],
                      //               ),
                      //               Column(
                      //                 children: [
                      //                   Text('Issue Date :',
                      //                       style: ThemeManagerDark.customTextStyle(context)),
                      //                   const SizedBox(height: 10,),
                      //                   Text('End Date :',
                      //                       style: ThemeManagerDark.customTextStyle(context)),
                      //                   const SizedBox(height: 50,)
                      //                 ],
                      //               ),
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(snapshot.data![index].issueDate,
                      //                     style: ThemeManagerDarkFont.customTextStyle(context),),
                      //                   const SizedBox(height: 10,),
                      //                   Text(snapshot.data![index].expData,
                      //                     style: ThemeManagerDarkFont.customTextStyle(context),),
                      //                   const SizedBox(height: 50,)
                      //
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //
                      //           ///approve reject button
                      //           // Row(
                      //           //   mainAxisAlignment: MainAxisAlignment.end,
                      //           //   children: [
                      //           //     snapshot.data![index].approved == false ?
                      //           //     CustomIconButton(text: 'Reject', color: ColorManager.white,textColor: ColorManager.blueprime,onPressed: () async{
                      //           //       await rejectLicensePatch(context, snapshot.data![index].licenseId);
                      //           //     }) :SizedBox() ,
                      //           //     const SizedBox(width: 5,),
                      //           //     snapshot.data![index].approved == true ?
                      //           //     Text('Approved',
                      //           //         textAlign: TextAlign.center,
                      //           //         style: CustomTextStylesCommon.commonStyle(
                      //           //             fontSize: FontSize.s12,
                      //           //             fontWeight: FontWeightManager.bold,
                      //           //             color: ColorManager.blueprime)) :  CustomIconButton(
                      //           //         text: 'Approve', onPressed: () async{
                      //           //       await approveLicensePatch(context, snapshot.data![index].licenseId);
                      //           //     })
                      //           //   ],
                      //           // )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // );
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