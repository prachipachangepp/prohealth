import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/references_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/references_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_reference_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/const_card_details.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class ReferencesChildTabbar extends StatefulWidget {
  final int employeeId;
  const ReferencesChildTabbar({super.key, required this.employeeId});

  @override
  State<ReferencesChildTabbar> createState() => _ReferencesChildTabbarState();
}

class _ReferencesChildTabbarState extends State<ReferencesChildTabbar> {
  final StreamController<List<ReferenceData>> referenceStreamController = StreamController<List<ReferenceData>>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titlePositionController = TextEditingController();
  TextEditingController knowPersonController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController associationLengthController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController referredBController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        ///add button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                  text: AppStringHr.add,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddReferencePopup(
                            nameController: nameController,
                            emailController: emailController,
                            titlePositionController:
                            titlePositionController,
                            knowPersonController: knowPersonController,
                            companyNameController: companyNameController,
                            associationLengthController:
                            associationLengthController,
                            mobileNumberController:
                            mobileNumberController,
                            referredBy: referredBController,
                            onpressedClose: () {},
                            onpressedSave: () async {
                              var response = await addReferencePost(
                                  context,
                                  associationLengthController.text,
                                  'Reference',
                                  companyNameController.text,
                                  emailController.text,
                                  widget.employeeId!,
                                  mobileNumberController.text,
                                  nameController.text,
                                  knowPersonController.text,
                                  titlePositionController.text);
                              Navigator.pop(context);
                              if(response.statusCode == 200 || response.statusCode == 201){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddSuccessPopup(
                                      message: 'Reference Added Successfully',
                                    );
                                  },
                                );
                              }
                            },
                            title: 'Add Reference',
                          );
                        });
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 1,
        ),
        StreamBuilder<List<ReferenceData>>(
          stream: referenceStreamController.stream,
          builder: (context,snapshot) {
            getReferences(context,widget.employeeId).then((data) {
              referenceStreamController.add(data);
            }).catchError((error) {
              // Handle error
            });
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding:const EdgeInsets.symmetric(vertical: 100),
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                ),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      AppStringHRNoData.referenceNoData,
                      style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s14,
                          color: ColorManager.mediumgrey),
                    ),
                  ));
            }
            if(snapshot.hasData){
              return Wrap(
                spacing: 10,
                  children: List.generate(snapshot.data!.length, (index){
                return CardDetails(childWidget: DetailsFormate(
                  title:'References #${index + 1}',
                    row1Child1: [
                      Text('Name :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(height: 10,),
                      Text('Title/ Position :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(height: 10,),
                      Text('Company/ Organization :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(height: 10,),
                      Text('Mobile Number :',
                          style: ThemeManagerDark.customTextStyle(context)),
                    ],
                    row1Child2: [
                      Text(snapshot.data![index].name,
                        style: ThemeManagerDarkFont.customTextStyle(context),),
                      const SizedBox(height: 10,),
                      Text(snapshot.data![index].title,
                        style: ThemeManagerDarkFont.customTextStyle(context),),
                      const SizedBox(height: 10,),
                      Text(snapshot.data![index].company,
                        style: ThemeManagerDarkFont.customTextStyle(context),),
                      const SizedBox(height: 10,),
                      Text(snapshot.data![index].mobNumber,
                        style: ThemeManagerDarkFont.customTextStyle(context),),
                    ],
                    row2Child1: [
                      Text('Email :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(height: 10,),
                      Text('How do you know this person ? :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(height: 10,),
                      Text('Length of Association :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(height: 10,),
                      SizedBox(height: 30, width: 90,)
                      // Text('Referred By',
                      //     style: ThemeManager.customTextStyle(context)),
                    ],
                    row2Child2: [
                      Text(snapshot.data![index].email,

                        style: ThemeManagerDarkFont.customTextStyle(context),),
                      const SizedBox(height: 10,),
                      Text('LinkedIn',
                        style: ThemeManagerDarkFont.customTextStyle(context),),
                      const SizedBox(height: 10,),
                      Text(snapshot.data![index].association,
                        style: ThemeManagerDarkFont.customTextStyle(context),),
                      const SizedBox(height: 10,),
                      SizedBox(height: 30, width: 90,)
                    ],
                    button: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [snapshot.data![index].approve == null ?
                      Text('Not Approved',
                          style:TextStyle(
                        fontSize: MediaQuery.of(context).size.width/120,
                        color: ColorManager.mediumgrey,
                        fontWeight: FontWeight.w600,
                      )):
                      BorderIconButton(iconData: Icons.edit_outlined,
                          buttonText: 'Edit', onPressed: (){
                            showDialog(context: context, builder: (BuildContext context){
                              return FutureBuilder<ReferencePrefillData>(
                                  future: getPrefillReferences(context,snapshot.data![index].referenceId),
                                  builder: (context,snapshotPrefill) {
                                    if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                      return Center(
                                        child: CircularProgressIndicator(color: ColorManager.blueprime,),
                                      );
                                    }
                                    var name = snapshotPrefill.data!.name;
                                    nameController = TextEditingController(text: snapshotPrefill.data!.name);

                                    var comment = snapshotPrefill.data!.comment;

                                    var email = snapshotPrefill.data!.email;
                                    emailController = TextEditingController(text: snapshotPrefill.data!.email);

                                    var title = snapshotPrefill.data!.title;
                                    titlePositionController = TextEditingController(text: snapshotPrefill.data!.title);

                                    var knowPerson = "LinkedIn";
                                    knowPersonController = TextEditingController(text:"LinkedIn");

                                    var companyName = snapshotPrefill.data!.company;
                                    companyNameController = TextEditingController(text: snapshotPrefill.data!.company);

                                    var association = snapshotPrefill.data!.association;
                                    associationLengthController = TextEditingController(text: snapshotPrefill.data!.association);
                                    var referredby = snapshotPrefill.data!.references;
                                    referredBController =TextEditingController(
                                        text: snapshotPrefill.data!.references
                                    );

                                    var references = snapshotPrefill.data!.references;
                                    var mobileNumber = snapshotPrefill.data!.mobNumber;
                                    mobileNumberController = TextEditingController(text: snapshotPrefill.data!.mobNumber);
                                    return StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return AddReferencePopup(nameController: nameController, emailController: emailController, titlePositionController: titlePositionController, knowPersonController: knowPersonController, companyNameController: companyNameController,
                                          associationLengthController: associationLengthController, mobileNumberController: mobileNumberController, referredBy: referredBController,
                                          onpressedClose: (){
                                            Navigator.pop(context);
                                          }, onpressedSave: () async{
                                            var response = await updateReferencePatch(context,
                                              snapshot.data![index].referenceId,
                                              association == associationLengthController.text ? association.toString() : associationLengthController.text,
                                              comment.toString(),
                                              companyName == companyNameController.text ? companyName.toString() : companyNameController.text,
                                              email == emailController.text ? email.toString() : emailController.text,
                                              widget.employeeId,
                                              mobileNumber == mobileNumberController.text ? mobileNumber.toString() : mobileNumberController.text,
                                              name == nameController.text ? name.toString() : nameController.text,
                                              //references.toString(),
                                              referredby== referredBController.text? referredby.toString():referredBController.text,
                                              title == titlePositionController.text ? title.toString() : titlePositionController.text,
                                            );
                                            if(response.statusCode == 200 || response.statusCode == 201){
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AddSuccessPopup(
                                                    message: 'Reference Edit Successfully',
                                                  );
                                                },
                                              );
                                            }
                                            getReferences(context,5).then((data) {
                                              referenceStreamController.add(data);
                                            }).catchError((error) {
                                              // Handle error
                                            });
                                          }, title: 'Edit Reference',);
                                      },
                                    );
                                  }
                              );
                            });
                          })
                      ],
                    )),);
              }));
            }else{
              return const SizedBox();
            }

          }
        ),
      ],
    );

  }
}
