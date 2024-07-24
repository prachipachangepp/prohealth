import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/references_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/references_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_reference_popup.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 20),
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
                            onpressedClose: () {},
                            onpressedSave: () async {
                              await addReferencePost(
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
                  child: Text(
                    AppString.dataNotFound,
                    style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey),
                  ));
            }
            if(snapshot.hasData){
              return WrapWidget(
                  childern: List.generate(snapshot.data!.length, (index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Row(
                            children: [
                              Text('References #${snapshot.data![index].referenceId}',
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  fontSize: 13,
                                  color: Color(0xFF333333),
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
                                  Text('Name',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('Title/ Position',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 15,),
                                  Text('Company/ Organization',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('Mobile Number',
                                      style: ThemeManager.customTextStyle(context)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].name,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].title,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 15,),
                                  Text(snapshot.data![index].company,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].mobNumber,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('How do you know this\nperson ?',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 5,),
                                  Text('Length of Association',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 5,),
                                  Text('Referred By',
                                      style: ThemeManager.customTextStyle(context)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].email,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text('LinkedIn',
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 15,),
                                  Text(snapshot.data![index].association,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].references,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                ],
                              ),
                            ],),
                          SizedBox(height: MediaQuery.of(context).size.height/40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButtonWidget(iconData: Icons.edit_outlined,
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

                                      var references = snapshotPrefill.data!.references;
                                      var mobileNumber = snapshotPrefill.data!.mobNumber;
                                      mobileNumberController = TextEditingController(text: snapshotPrefill.data!.mobNumber);
                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                          return AddReferencePopup(nameController: nameController, emailController: emailController, titlePositionController: titlePositionController, knowPersonController: knowPersonController, companyNameController: companyNameController,
                                              associationLengthController: associationLengthController, mobileNumberController: mobileNumberController,
                                              onpressedClose: (){
                                                Navigator.pop(context);
                                              }, onpressedSave: () async{
                                                await updateReferencePatch(context,
                                                    snapshot.data![index].referenceId,
                                                    association == associationLengthController.text ? association.toString() : associationLengthController.text,
                                                    comment.toString(),
                                                    companyName == companyNameController.text ? companyName.toString() : companyNameController.text,
                                                    email == emailController.text ? email.toString() : emailController.text,
                                                    widget.employeeId,
                                                    mobileNumber == mobileNumberController.text ? mobileNumber.toString() : mobileNumberController.text,
                                                    name == nameController.text ? name.toString() : nameController.text,
                                                    references.toString(),
                                                    title == titlePositionController.text ? title.toString() : titlePositionController.text);
                                                getReferences(context,5).then((data) {
                                                  referenceStreamController.add(data);
                                                }).catchError((error) {
                                                  // Handle error
                                                });
                                              }, title: 'Edit Reference');
                                        },
                                      );
                                    }
                                  );
                                });
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
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
