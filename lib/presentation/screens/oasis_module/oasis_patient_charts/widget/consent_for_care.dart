import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/resources/color.dart';
//import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../them_manager/oasis_them_mnager.dart';
import '../../widgets/constant/getx_oasis.dart';
import '../../widgets/constant/green_container_constant.dart';
import '../../widgets/constant/other_popup.dart';
import '../../widgets/constant/upload_file_popup.dart';

class ConsentForCare extends StatefulWidget {
  const ConsentForCare({super.key});

  @override
  State<ConsentForCare> createState() => _ConsentForCareState();
}

class _ConsentForCareState extends State<ConsentForCare> {

  bool isChecked1 = false;
  bool isChecked2 = false;
  TextEditingController reasonController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  //TextEditingController secNumController = TextEditingController();
  String? emptype = "Yes";
  String? pickedFileName;
  dynamic pickedFile;



  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        pickedFileName = result.files.first.name;
        pickedFile = result.files.first.bytes;
      });
      // PlatformFile file = result.files.first;
      print('File picked: ${pickedFileName}');
    } else {
      // User canceled the picker
    }
  }


  String? pickedFileNameAA;
  dynamic pickedFileAA;
  Future<void> _handleFileUploadAA() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        pickedFileNameAA = result.files.first.name;
        pickedFileAA = result.files.first.bytes;
      });
      // PlatformFile file = result.files.first;
      print('File picked: ${pickedFileNameAA}');
    } else {
      // User canceled the picker
    }
  }



  @override
  Widget build(BuildContext context) {
  // Get.put(TermsController());
    final CheckboxController checkboxController = Get.put(CheckboxController());
    // RxBool isChecked = false.obs;
    // RxBool isCheck = false.obs;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 50,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GreenContrainerConst(
                height: 110,
                child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(child: Text("| hereby give my voluntary consent for ProHealth Home Care, Inc. to provide care and treatment to me in my home as directed by my physician. The initial services to be provided have been explained to me and include:",
                      style: Normalfontstyle.customTextStyle(context),))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomCheckBoxListTile(
                        title: 'Nurse',
                        isChecked: checkboxController.isChecked,
                        onChanged: (value) {
                          checkboxController.toggleCheckbox(value);
                        },
                          ),
                          CustomCheckBoxListTile(
                            title: 'PT',
                            isChecked: checkboxController.pt,
                            onChanged: (value) {
                              checkboxController.toggleCheckpt(value);
                            },
                          ),
                      CustomCheckBoxListTile(
                        title: 'OT',
                        isChecked: checkboxController.ot,
                        onChanged: (value) {
                          checkboxController.toggleCheckboxot(value);
                        },
                      ),
                      CustomCheckBoxListTile(
                        title: 'SLP',
                        isChecked: checkboxController.slp,
                        onChanged: (value) {
                          checkboxController.toggleCheckslp(value);
                        },
                      ),
                      CustomCheckBoxListTile(
                        title: 'MSW',
                        isChecked: checkboxController.msw,
                        onChanged: (value) {
                          checkboxController.toggleCheckmsw(value);
                        },
                      ),
                      CustomCheckBoxListTile(
                        title: 'Aide',
                        isChecked: checkboxController.aide,
                        onChanged: (value) {
                          checkboxController.toggleCheckaide(value);
                        },
                      ),
                      CustomCheckBoxListTile(
                        title: 'Other',
                        isChecked: checkboxController.other,
                        onChanged: (value) {
                          checkboxController.toggleCheckother(value);
                          if (value) {
                            // Show the dialog box when checked
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OtherPopup();
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),


                ],
              ),

              ),
              SizedBox(height: 20),
              Text("Release Of Information",style: BoldfontStyle.customTextStyle(context),),
              SizedBox(height: 20),
              Text("I authorize ProHealth Home Care to use and disclose protected health information (PHI) about me for the purposes of treatment, payment, and health care operations. The agency uses an electronic health record and may, either on paper or through a secure web-based portal, release PHI to or receive PHI from physicians, hospitals, other health care providers, family members and others involved in my plan of care, assisted living facilities, third party payers, and regulatory agencies as necessary for my care or to process my claims.",
              style: Normalfontstyle.customTextStyle(context) ,),
              SizedBox(height: 30),
              GreenContrainerConst(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Liability For Payment",style: BoldfontStyle.customTextStyle(context),),
                  SizedBox(height: 20),
                  Text("I certify that the information given by me in applying for payment under Title XVIII of the Social Security Act and/or from any third party payer is correct. | request that payment of authorizedbenefits from Medicare, Medicaid, or other responsible payers be made on my behalf of ProHealth Home Care.",
                  style:Normalfontstyle.customTextStyle(context) ,),
                  SizedBox(height: 20,),
                  Flexible(
                    child: Row(
                      children: [
                        Text("I",style: BoldfontStyle.customTextStyle(context),),
                        CustomCheckBoxListTile(
                          title: 'am',
                          isChecked: checkboxController.am,
                          onChanged: (value) {
                            checkboxController.toggleCheckam(value);
                          },
                        ),
                        CustomCheckBoxListTile(
                          title: 'am not',
                          isChecked: checkboxController.not,
                          onChanged: (value) {
                            checkboxController.toggleChecknot(value);
                          },
                        ),
                        Text("a participating member of an HMO (health maintenance organization). If I enroll in one, I will immediately notify the home care agency. ",
                          style: Normalfontstyle.customTextStyle(context),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Wrap(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "If I have ",
                              style: Normalfontstyle.customTextStyle(context),
                            ),
                            TextSpan(
                              text: "Medicare benefits, ",
                              style: BoldfontStyle.customTextStyle(context),
                            ),
                            TextSpan(
                              text: "| understand that Medicare payments will be accepted as payment in full unless the agency notifies me in writing that the services will not be covered by Medicare",
                              style: Normalfontstyle.customTextStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),

                  // Row(
                  //   children: [
                  //     Text("If I have ",
                  //         style:AllHRTableData.customTextStyle(context),
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     Text("Medicare benefits,",
                  //       style: DefineWorkWeekStyle.customTextStyle(context),
                  //     ),
                  //     Text("| understand that Medicare payments will be accepted as payment in full unless the agency notifies me in writing that the services will not be covered by Medicare",
                  //         style:AllHRTableData.customTextStyle(context),overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ],
                  // ),
                  Text("I understand that while I am under the agency's plan of care, the agency will coordinate all medically necessary therapy services and medical supplies for me. Should I arrange for these services or supplies on my own, I understand that Medicare will not reimburse me or my supplier, and I will be responsible for their cost.",
                      style:Normalfontstyle.customTextStyle(context)
                  ),
                  SizedBox(height: 20,),
                  Wrap(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "If I have other ",
                              style: Normalfontstyle.customTextStyle(context),
                            ),
                            TextSpan(
                              text: "health insurance, ",
                              style: BoldfontStyle.customTextStyle(context),
                            ),
                            TextSpan(
                              text: "I may be responsible for the co-payments and any charges that my insurance will not cover. Those costs will be itemized and explained to me on a separateClient Service Agreement.",
                              style: Normalfontstyle.customTextStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Expected payer source(s) for my home care services include: ", style: Normalfontstyle.customTextStyle(context),),
                  SizedBox(height: 20),
                  CustomCheckBoxListTile(
                    title: 'MEDICARE',
                    isChecked: checkboxController.medicare,
                    onChanged: (value) {
                      checkboxController.toggleCheckmedicare(value);
                    },
                  ),
                  CustomCheckBoxListTile(
                    title: 'MEDICAID',
                    isChecked: checkboxController.medicaid,
                    onChanged: (value) {
                      checkboxController.toggleCheckmedicaid(value);
                    },
                  ),
                  CustomCheckBoxListTile(
                    title: 'OTHER',
                    isChecked: checkboxController.Other,
                    onChanged: (value) {
                      checkboxController.toggleCheckOther(value);
                      if (value) {
                        // Show the dialog box when checked
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return OtherPopup();
                          },
                        );
                      }
                    },
                  ),
                ],

              ),),
              SizedBox(height: 20,),
              GreenContrainerConst(
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  Text("Consent to Photograph", style: BoldfontStyle.customTextStyle(context),),
                    SizedBox(height: 15,),
                  Text("I hereby consent to allow the agency to use my photograph for identification purposes and/or for documenting my medical condition.", style: Normalfontstyle.customTextStyle(context),),
                    SizedBox(height:15,),
                    Row(
                      children: [
                        Container(
                          //color: Colors.white,
                          width: 117,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(backgroundColor: ColorManager.bluebottom,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                // side: BorderSide(
                                //   color: ColorManager.bluebottom,
                                //   width: 1,
                                // ),
                              ),),
                            child: Text('Yes',
                              style:BluebuttonStyle.customTextStyle(context)
                            ),),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          //color: Colors.white,
                          width: 117,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                // side: BorderSide(
                                //   color: ColorManager.bluebottom,
                                //   width: 1,
                                // ),
                              ),),
                            child: Text('NO',
                              style: BoldfontStyle.customTextStyle(context),
                            ),),
                        ),
                      ],
                    ),


              ],),),

          SizedBox(height: 20,),
          GreenContrainerConst(
            height:300,child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Advance Directives",style: BoldfontStyle.customTextStyle(context),),
              SizedBox(height: 20,),
              Text("I Currently have a: ", style: Normalfontstyle.customTextStyle(context),),
              SizedBox(height: 15),
              CustomCheckBoxListTile(
                title: 'Living Will',
                isChecked: checkboxController.will,
                onChanged: (value) {
                  checkboxController.toggleCheckwill(value);
                },
              ),
              CustomCheckBoxListTile(
                title: 'DNR/POLST',
                isChecked: checkboxController.dnr,
                onChanged: (value) {
                  checkboxController.toggleCheckdnr(value);
                },
              ),
              CustomCheckBoxListTile(
                title: 'Health Care Power of Attorney',
                isChecked: checkboxController.healthcare,
                onChanged: (value) {
                  checkboxController.toggleCheckhealthcare(value);
                },
              ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text("Copies Requested for Agency records:", style: Normalfontstyle.customTextStyle(context),),
                EMRCustomRadioListTile(
                  title: 'Yes',
                  value: 'Yes',
                  groupValue: emptype,
                  onChanged: (value) {
          setState(() {
            emptype = value;
          });
                  },
                ),
                EMRCustomRadioListTile(
                  title: 'No',
                  value: 'No',
                  groupValue: emptype,
                  onChanged: (value) {
          setState(() {
            emptype = value;
          });
                  },
                ),
              ],
            ),
          ),

              CustomCheckBoxListTile(
                title: 'I do not currently have advance directives',
                isChecked: checkboxController.directives,
                onChanged: (value) {
                  checkboxController.toggleCheckdirectives(value);
                },
              ),

            ],
          ),),

              SizedBox(height: 20),
              Text("Non- Discrimination ",style: BoldfontStyle.customTextStyle(context),),
              SizedBox(height: 20),
              Text("ProHealth Home Care does not refuse service to patients or in any other way discriminate against any person on the basis of age, sex, disability, race, color, religion, ancestry, or national origin, in accordance with the Civil Rights Act of 1964, Section 504 of the Rehabilitation Act of 1973, the Age Discrimination Act of 1975, and the Americans with Disabilities Act of 1990.", style: Normalfontstyle.customTextStyle(context) ,),
              SizedBox(height: 20),

              GreenContrainerConst(
                height:350,child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Acknowledgement Of Receipt by Patient",style: BoldfontStyle.customTextStyle(context),),
                  SizedBox(height: 20,),
                  Text("I certify that I have received the following Patient Documents and/or Policies from ProHealth Home Care, Inc.:", style: Normalfontstyle.customTextStyle(context),),
                  SizedBox(height: 15),
                  CustomCheckBoxListTile(
                    title: 'Notice of Privacy Practices',
                    isChecked: checkboxController.notice,
                    onChanged: (value) {
                      checkboxController.toggleChecknotice(value);
                    },
                  ),
                  CustomCheckBoxListTile(
                    title: 'OASIS Notice & Privacy Act Statement — Health Care Records',
                    isChecked: checkboxController.oasis,
                    onChanged: (value) {
                      checkboxController.toggleCheckoasis(value);
                    },
                  ),
                  CustomCheckBoxListTile(
                    title: 'Patient Rights and Responsibilities',
                    isChecked: checkboxController.patientright,
                    onChanged: (value) {
                      checkboxController.toggleCheckpatientright(value);
                    },
                  ),
                  CustomCheckBoxListTile(
                    title: 'Patient Information, Emergency Preparedness',
                    isChecked: checkboxController.patientinfo,
                    onChanged: (value) {
                      checkboxController.toggleCheckpatientinfo(value);
                    },
                  ), CustomCheckBoxListTile(
                    title: 'Advance Directives: ProHealth Policy & California Probate Code',
                    isChecked: checkboxController.advdirectives,
                    onChanged: (value) {
                      checkboxController.toggleCheckadvdirectives(value);
                    },
                  ), CustomCheckBoxListTile(
                    title: 'Home Safety Assessment and Recommendations',
                    isChecked: checkboxController.homesafety,
                    onChanged: (value) {
                      checkboxController.toggleCheckhomesafety(value);
                    },
                  ),


                  CustomCheckBoxListTile(
                    title: 'Other',
                    isChecked: checkboxController.OTHER,
                    onChanged: (value) {
                      checkboxController.toggleCheckOTHER(value);
                    },
                  ),

                ],
              ),),
              SizedBox(height: 20,),
              WhiteContrainerConst(
          height: 650,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("I have had an opportunity to review this document and ask questions to assist me in understanding my rights relative to the protection of my health information. I am satisfied with the explanation provided to me and I am confident that the provider is committed to protecting my health Information."
                    , style: Normalfontstyle.customTextStyle(context),),

                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Text("Does the patient have the capacity to sign? ",style: BoldfontStyle.customTextStyle(context),),
                      SizedBox(width: 10,),Container(
                        //color: Colors.white,
                        width: 117,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: (){

                          },
                          style: ElevatedButton.styleFrom(backgroundColor: ColorManager.bluebottom,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              // side: BorderSide(
                              //   color: ColorManager.bluebottom,
                              //   width: 1,
                              // ),
                            ),),
                          child: Text('Yes',
                            style:BluebuttonStyle.customTextStyle(context)
                          ),),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        //color: Colors.white,
                        width: 117,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: (){

                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              // side: BorderSide(
                              //   color: ColorManager.bluebottom,
                              //   width: 1,
                              // ),
                            ),),
                          child: Text('NO',
                            style: BoldfontStyle.customTextStyle(context),
                          ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("Patient Signature ",style: BoldfontStyle.customTextStyle(context),),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        child: CustomIconButtonEMR(
                          text: 'Upload Signature',
                          onPressed: ()async{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return UploadFilePopup();
                              },);
                          },
                          icon: Icons.file_upload_outlined,
                        ),
                      ),
                      SizedBox(width: 20),
                      pickedFileName == null
                          ? Container(
                        width: 150, // Set fixed width for the container
                        height: 40, // Set height to match the button
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.mediumgrey, width: 1),
                          borderRadius: BorderRadius.circular(8), // Make the corners circular with a radius of 5
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'No file chosen',
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : Container(
                        width: 150, // Set fixed width for the container
                        height: 40, // Set height to match the button
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.mediumgrey, width: 1),
                          borderRadius: BorderRadius.circular(8), // Make the corners circular with a radius of 5
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          pickedFileName!.length > 15
                              ? pickedFileName!.substring(0, 15) + '...' // Truncate text if more than 15 characters
                              : pickedFileName!,
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                          overflow: TextOverflow.ellipsis, // Ensure ellipsis appears if text overflows
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),


                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 40,
                  //       child: CustomIconButtonEMR(text: 'Upload Signature', onPressed: _handleFileUpload,
                  //       icon: Icons.file_upload_outlined,),
                  //     ),
                  //     SizedBox(width: 20,),
                  //     pickedFileName == null ? const Offstage():Align(
                  //       alignment: Alignment.centerRight,
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(right: 60),
                  //         child: Text(pickedFileName!,style:TextStyle(
                  //             fontSize: FontSize.s10,
                  //             color: ColorManager.mediumgrey
                  //         ),),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 30,),
                  Text("A legally authorized representative may sign if the beneficiary is unable to sign. ",style: BoldfontStyle.customTextStyle(context),),
                  SizedBox(height: 30,),
                  Text("The provider has provided me with an opportunity to review this document and ask questions to assist me in understanding his/her privacy rights, I am satisfied with the explanations provided to me and I am confident that the provider is committed to protecting health information : ",style: BoldfontStyle.customTextStyle(context),),

                  SizedBox(height: 30,),
                  Text("Authorized Representative’s Signature: ",style: BoldfontStyle.customTextStyle(context),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        child: CustomIconButtonEMR(

                          text: 'Upload Signature',
                          onPressed: ()async{
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return UploadFilePopup();
                          },);
                          },
                          icon: Icons.file_upload_outlined,
                        ),
                      ),
                      SizedBox(width: 20),
                      pickedFileNameAA == null
                          ? Container(
                        width: 150, // Set fixed width for the container
                        height: 40, // Set height to match the button
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.mediumgrey, width: 1),
                          borderRadius: BorderRadius.circular(8), // Make the corners circular with a radius of 5
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'No file chosen',
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : Container(
                        width: 150, // Set fixed width for the container
                        height: 40, // Set height to match the button
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.mediumgrey, width: 1),
                          borderRadius: BorderRadius.circular(8), // Make the corners circular with a radius of 5
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          pickedFileNameAA!.length > 15
                              ? pickedFileNameAA!.substring(0, 15) + '...' // Truncate text if more than 15 characters
                              : pickedFileNameAA!,
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey,
                          ),
                          overflow: TextOverflow.ellipsis, // Ensure ellipsis appears if text overflows
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const  EdgeInsets.symmetric(vertical: 4),
                                  child: Text("Reason Patient is unable to sign:" ,style: BoldfontStyle.customTextStyle(context),),
                                ),
                                SizedBox(height:15 ,),
                                Padding(
                                  padding: const  EdgeInsets.symmetric(vertical: 6),
                                  child: Text("Relationship to patient:" ,style: BoldfontStyle.customTextStyle(context),),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Text("Printed Name of Authorized \nRepresentative:" ,style: BoldfontStyle.customTextStyle(context),),
                                )
                              ],
                            ),

                            SizedBox(width: 10,),
                            Column(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                EMRTextFConst(
                                  //width: MediaQuery.of(context).size.width /5,
                                  width:AppSize.s310,
                                  controller: reasonController, keyboardType: TextInputType.text, ),
                                SizedBox(height: 10,),
                                // EMRTextFConst(controller: nameController, keyboardType: TextInputType.text,),
                                CustomDropdownTextFieldEMR(
                                 // width: MediaQuery.of(context).size.width /5,
                                  width:AppSize.s310,
                                  height: 30,
                                  items: ['Aunt/Uncle','Child','Cousin'],
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10,),
                                EMRTextFConst(
                                  width:AppSize.s310,
                                  //width: MediaQuery.of(context).size.width /5,
                                  controller: nameController, keyboardType: TextInputType.text,)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        child: Center(
                          child: Row(
                            children: [
                              Text("Date",style: BoldfontStyle.customTextStyle(context),),
                              SizedBox(width: 10,),
                              EMRTextFConst(
                                width:AppSize.s310,
                               // width: MediaQuery.of(context).size.width /5,
                                controller: dateController, keyboardType: TextInputType.text,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),),

              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //color: Colors.white,
                    width: 137,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: ColorManager.bluebottom,
                          //   width: 1,
                          // ),
                        ),),
                      child: Text('save and close',
                        style: BoldfontStyle.customTextStyle(context),
                      ),),
                  ), SizedBox(width: 20,),
                  Container(
                    //color: Colors.white,
                    width: 117,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: ColorManager.bluebottom,
                          //   width: 1,
                          // ),
                        ),),
                      child: Text('Submit',
                        style: BoldfontStyle.customTextStyle(context),
                      ),),
                  ), SizedBox(width: 20,),
                  Container(
                    //color: Colors.white,
                    width: 117,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(backgroundColor: ColorManager.bluebottom,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // side: BorderSide(
                          //   color: ColorManager.bluebottom,
                          //   width: 1,
                          // ),
                        ),),
                      child: Text('Next',

                        style:BluebuttonStyle.customTextStyle(context)
                      ),),
                  ),


                ],
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      )
    );
  }
}




class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink
    );
  }
}





class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green
    );
  }
}




class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent
    );
  }
}
