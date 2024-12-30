import 'package:flutter/material.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/insurance/primary_mamager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../textfield_dropdown_constant/double_date_picker_textfield.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../../../widgets/constant_widgets/dropdown_constant_sm.dart';
import '../../../intake_flow_contgainer_const.dart';

class IntakeInsurancePrimaryScreen extends StatefulWidget {
  final int patientId;
  const IntakeInsurancePrimaryScreen({super.key, required this.patientId});

  @override
  State<IntakeInsurancePrimaryScreen> createState() => _IntakeInsurancePrimaryScreenState();
}

class _IntakeInsurancePrimaryScreenState extends State<IntakeInsurancePrimaryScreen> {

  String? varifiedinsurance;
  String? eligiblityStatus;
  String? selectedState;
  String? selectedCity;
  String? selectedCategory;

  TextEditingController primaryinsuranceController =TextEditingController();
  TextEditingController prnameController =TextEditingController();
  TextEditingController prstreetController =TextEditingController();
  TextEditingController prcodeController =TextEditingController();
  TextEditingController suiteAptController =TextEditingController();
  TextEditingController cityController =TextEditingController();
  TextEditingController stateController =TextEditingController();
  TextEditingController zipcodeController =TextEditingController();
  TextEditingController typeController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController categoryController =TextEditingController();
  TextEditingController authorisationController =TextEditingController();
  TextEditingController effectiveFromController =TextEditingController();
  TextEditingController effectiveToController =TextEditingController();
  TextEditingController groupNbrController =TextEditingController();
  TextEditingController groupNameController =TextEditingController();
  TextEditingController policyHICNbrController =TextEditingController();
  //TextEditingController eligiblityStatusController =TextEditingController();
  TextEditingController insuranceVerifiedController =TextEditingController();
  TextEditingController commentController =TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();
  List<DropdownMenuItem<String>> primaryDropDownList = [];
  List<String> primaryValue = ['Value 1', 'Value 2', 'Value 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              IntakeFlowContainerConst(
                height: AppSize.s580,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: CustomDropdownTextFieldsm(
                                items: ['Value 1','Value 2','Value 3'],
                                onChanged: (newValue) {
                                },
                                headText: 'Primary Insurance',
                              ),
                              // SchedularTextField(
                              //   controller: primaryinsuranceController,
                              //
                              //     labelText: 'Primary Insurance')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: prnameController,
                                  labelText: AppString.name)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: prstreetController,
                                  labelText: AppString.street)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: prcodeController,
                                  labelText: AppString.code)
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                controller: suiteAptController,
                                  labelText: 'Suite/Apt #')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: SchedularTextField(
                                controller: cityController,
                                labelText: 'City')
                            // FutureBuilder<List<CityData>>(
                            //   future: getCityDropDown(context),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return SchedularTextField(
                            //         controller: dummyCtrl,
                            //         labelText: 'City',
                            //         suffixIcon: Icon(Icons.arrow_drop_down,
                            //           color: ColorManager.blueprime,),);
                            //     }
                            //     if (snapshot.hasData) {
                            //       List<DropdownMenuItem<String>> dropDownList = [];
                            //
                            //
                            //       for (var i in snapshot.data!) {
                            //         dropDownList.add(DropdownMenuItem<String>(
                            //           child: Text(i.cityName!),
                            //           value: i.cityName,
                            //         ));
                            //       }
                            //
                            //
                            //       return CustomDropdownTextFieldsm(
                            //         dropDownMenuList: dropDownList,
                            //         onChanged: (newValue) {
                            //           for (var a in snapshot.data!) {
                            //             if (a.cityName == newValue) {
                            //               selectedCity = a.cityName!;
                            //               //country = a
                            //               // int? docType = a.companyOfficeID;
                            //             }
                            //           }
                            //         },
                            //         headText: 'City',
                            //       );
                            //
                            //
                            //     } else {
                            //       return const Offstage();
                            //     }
                            //   },
                            // ),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child:SchedularTextField(
                                controller: stateController,
                                labelText: 'State')
                            // FutureBuilder<List<StateData>>(
                            //   future: getStateDropDown(context),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return SchedularTextField(
                            //         controller: dummyCtrl,
                            //         labelText: 'State',
                            //         suffixIcon: Icon(Icons.arrow_drop_down,
                            //           color: ColorManager.blueprime,),);
                            //     }
                            //     if (snapshot.hasData) {
                            //       List<DropdownMenuItem<String>> dropDownList = [];
                            //
                            //
                            //       for (var i in snapshot.data!) {
                            //         dropDownList.add(DropdownMenuItem<String>(
                            //           child: Text(i.name!!),
                            //           value: i.name!,
                            //         ));
                            //       }
                            //
                            //       return CustomDropdownTextFieldsm(
                            //         dropDownMenuList:dropDownList,
                            //         onChanged: (newValue) {
                            //           for (var a in snapshot.data!) {
                            //             if (a.name == newValue) {
                            //               selectedState = a.name!;
                            //               //country = a
                            //               // int? docType = a.companyOfficeID;
                            //             }
                            //           }
                            //         },
                            //         headText: 'State',
                            //       );
                            //     } else {
                            //       return const Offstage();
                            //     }
                            //   },
                            // ),

                          ),
                          SizedBox(width: AppSize.s35),

                          Flexible(child: SchedularTextFieldWithButton(
                            textController: zipcodeController,
                            labelText: AppString.zip_code,
                            initialValue: '2656845121',
                            buttonText: 'View Zone',
                          )),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                controller: typeController,
                                  labelText:AppString.type)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  phoneField: true,
                                controller: phoneController,
                                  labelText:'Phone')
                          ),
                          SizedBox(width: AppSize.s35),

                          // Flexible(
                          //   child: FutureBuilder<List<CategoryData>>(
                          //     future: getCategoryDropDown(context),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.connectionState ==
                          //           ConnectionState.waiting) {
                          //         return SchedularTextField(
                          //           controller: dummyCtrl,
                          //           labelText: 'Category',
                          //           suffixIcon: Icon(Icons.arrow_drop_down,
                          //             color: ColorManager.blueprime,),);
                          //       }
                          //       if (snapshot.hasData) {
                          //         List<DropdownMenuItem<String>> dropDownList = [];
                          //
                          //
                          //         for (var i in snapshot.data!) {
                          //           dropDownList.add(DropdownMenuItem<String>(
                          //             child: Text(i.idText!),
                          //             value: i.idText,
                          //           ));
                          //         }
                          //
                          //
                          //         return CustomDropdownTextFieldsm(
                          //           dropDownMenuList: dropDownList,
                          //
                          //           onChanged: (newValue) {
                          //             for (var a in snapshot.data!) {
                          //               if (a.idText == newValue) {
                          //                 selectedCategory = a.idText!;
                          //                 //country = a
                          //                 // int? docType = a.companyOfficeID;
                          //               }
                          //             }
                          //           },
                          //           headText: 'Category',
                          //         );
                          //
                          //
                          //       } else {
                          //         return const Offstage();
                          //       }
                          //     },
                          //   ),
                          //
                          //
                          // ),

                          Flexible(
                            child: SchedularTextField(
                              controller: dummyCtrl,
                              labelText: '',
                              hintText: 'NPI#',
                            ),
                          ),

                          // Flexible(
                          //
                          //
                          //
                          //   child: FutureBuilder<List<CategoryData>>(
                          //     future: getCategoryDropDown(context),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.connectionState ==
                          //           ConnectionState.waiting) {
                          //         return SchedularTextField(
                          //           controller: dummyCtrl,
                          //           labelText: 'Category',
                          //           suffixIcon: Icon(Icons.arrow_drop_down,
                          //             color: ColorManager.blueprime,),);
                          //       }
                          //       if (snapshot.hasData) {
                          //         List<String> dropDownList = [];
                          //         for (var i in snapshot.data!) {
                          //           dropDownList.add(i.idText!);
                          //         }
                          //
                          //         return SizedBox(
                          //           height: 27,
                          //           child: DropdownButtonFormField<String>(
                          //             decoration: InputDecoration(
                          //               labelText: 'category',
                          //               labelStyle: GoogleFonts.firaSans(
                          //                 fontSize: 10.0,
                          //                 fontWeight: FontWeight.w400,
                          //                 color: ColorManager.greylight,
                          //               ),
                          //               focusedBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager
                          //                         .containerBorderGrey),
                          //               ),
                          //               border: OutlineInputBorder(
                          //                 borderRadius:
                          //                 BorderRadius.circular(4.0),
                          //                 borderSide: const BorderSide(
                          //                     color: Colors.grey),
                          //               ),
                          //               contentPadding:
                          //               const EdgeInsets.symmetric(
                          //                 //   //  vertical: 5,
                          //                   horizontal: 12),
                          //             ),
                          //             // value: selectedCountry,
                          //             icon: Icon(
                          //               Icons.arrow_drop_down,
                          //               color: ColorManager.blueprime,
                          //             ),
                          //             iconSize: 24,
                          //             elevation: 16,
                          //             style: GoogleFonts.firaSans(
                          //               fontSize: 10.0,
                          //               fontWeight: FontWeight.w400,
                          //               color: const Color(0xff686464),
                          //             ),
                          //
                          //             onChanged: (newValue) {
                          //               for (var a in snapshot.data!) {
                          //                 if (a.idText == newValue) {
                          //                   selectedCategory = a.idText!;
                          //                   //country = a
                          //                   // int? docType = a.companyOfficeID;
                          //                 }
                          //               }
                          //             },
                          //             items: dropDownList.map((String value) {
                          //               return DropdownMenuItem<String>(
                          //                 value: value,
                          //                 child: Text(
                          //                   value,
                          //                   style: GoogleFonts.firaSans(
                          //                     fontSize: 12,
                          //                     color: Color(0xff575757),
                          //                     fontWeight: FontWeight.w400,
                          //                   ),
                          //                 ),
                          //               );
                          //             }).toList(),
                          //           ),
                          //         );
                          //       } else {
                          //         return const Offstage();
                          //       }
                          //     },
                          //   ),
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //     // child: SchedularDropdown(
                          //     //   labelText: AppString.category,
                          //     //     items: ['Option 1', 'Option 2', 'Option 3'], onChanged: (newValue) {  },
                          //     // )
                          // ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: authorisationController,
                                  labelText:'Authorisation')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s6),
                      Row(
                        children: [
                          Flexible(
                           child: Container(),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Container(),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Container(
                             // color: ColorManager.red,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Check PECOS eligibility status", style: TextStyle(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.blueprime,
                                    decoration: TextDecoration.none,
                                  ),),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Container(),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: DoubleDatePickerTextField(
                                  labelText: 'Effective from',
                                  isDate: true,
                                startDateController: effectiveFromController,
                                endDateController: effectiveToController,)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: groupNbrController,
                                  labelText:'Group #')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: groupNameController,
                                  labelText: 'Group Name')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: policyHICNbrController,
                                  labelText:'Policy/ HIC #')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: FutureBuilder<List<EligiblityStatusData>>(
                              future: getEligiblityStatusDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                   // hintText: "Select",
                                    labelText:'Eligibility Status',
                                   // suffixIcon: Icon(Icons.arrow_drop_down, color: ColorManager.blueprime,),
                                  );
                                }
                                if (snapshot.hasData) {
                                  // List<String> dropDownList = [];
                                  // for (var i in snapshot.data!) {
                                  //   dropDownList.add(i.idText!);
                                  // }

                                  List<DropdownMenuItem<String>> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(DropdownMenuItem<String>(
                                      child: Text(i.idText!),
                                      value: i.idText,
                                    ));
                                  }
                                  return CustomDropdownTextFieldsm(
                                dropDownMenuList: dropDownList,

                                onChanged: (newValue) {
                                  for (var a in snapshot.data!) {
                                    if (a.idText == newValue) {
                                      eligiblityStatus = a.idText!;
                                      //country = a
                                      // int? docType = a.companyOfficeID;
                                    }
                                  }
                                },
                                headText: 'Eligibility Status',
                              );
                                  // return SizedBox(
                                  //   height: 27,
                                  //   child: DropdownButtonFormField<String>(
                                  //     decoration: InputDecoration(
                                  //       labelText: 'Eligibility Status',
                                  //       labelStyle: GoogleFonts.firaSans(
                                  //         fontSize: 10.0,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: ColorManager.greylight,
                                  //       ),
                                  //       focusedBorder: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //             color: ColorManager
                                  //                 .containerBorderGrey),
                                  //       ),
                                  //       border: OutlineInputBorder(
                                  //         borderRadius:
                                  //         BorderRadius.circular(4.0),
                                  //         borderSide: const BorderSide(
                                  //             color: Colors.grey),
                                  //       ),
                                  //       contentPadding:
                                  //       const EdgeInsets.symmetric(
                                  //         //   //  vertical: 5,
                                  //           horizontal: 12),
                                  //     ),
                                  //     // value: selectedCountry,
                                  //     icon: Icon(
                                  //       Icons.arrow_drop_down,
                                  //       color: ColorManager.blueprime,
                                  //     ),
                                  //     iconSize: 24,
                                  //     elevation: 16,
                                  //     style: GoogleFonts.firaSans(
                                  //       fontSize: 10.0,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: const Color(0xff686464),
                                  //     ),
                                  //
                                  //     onChanged: (newValue) {
                                  //       for (var a in snapshot.data!) {
                                  //         if (a.idText == newValue) {
                                  //           eligiblityStatus = a.idText!;
                                  //           //country = a
                                  //           // int? docType = a.companyOfficeID;
                                  //         }
                                  //       }
                                  //     },
                                  //     items: dropDownList.map((String value) {
                                  //       return DropdownMenuItem<String>(
                                  //         value: value,
                                  //         child: Text(
                                  //           value,
                                  //           style: GoogleFonts.firaSans(
                                  //             fontSize: 12,
                                  //             color: Color(0xff575757),
                                  //             fontWeight: FontWeight.w400,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }).toList(),
                                  //   ),
                                  // );
                                } else {
                                  return const Offstage();
                                }
                              },
                            ),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) { return Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Insurance Verified',
                                      style: AllPopupHeadings.customTextStyle(context)
                                  ),
                                  SizedBox(height: 1),
                                  Row(
                                    children: [
                                      CustomRadioListTile(
                                        title:'Yes',
                                        value: 'Yes',
                                        groupValue: varifiedinsurance,
                                        onChanged: (value) {
                                          setState(() {
                                            varifiedinsurance = value;
                                          });
                                        },
                                      ),

                                      CustomRadioListTile(
                                        title:'No',
                                        value: 'No',
                                        groupValue: varifiedinsurance,
                                        onChanged: (value) {
                                          setState(() {
                                            varifiedinsurance = value;
                                          });
                                        },
                                      ),


                                      // Radio<String>(
                                      //   value: 'Yes',
                                      //   groupValue: varifiedinsurance,
                                      //   onChanged: (value) => setState(() => varifiedinsurance = value),
                                      // ),
                                      // Text(AppString.yes,
                                      //     style: GoogleFonts.firaSans(
                                      //         fontSize: FontSize.s14
                                      //         , fontWeight: FontWeightManager.regular)
                                      // ),
                                      // SizedBox(width: MediaQuery.of(context).size.width/100),
                                      // Radio<String>(
                                      //   value: 'No',
                                      //   groupValue: varifiedinsurance,
                                      //   onChanged: (value) => setState(() => varifiedinsurance = value),
                                      // ),
                                      // Text(AppString.no,
                                      //     style: GoogleFonts.firaSans(
                                      //         fontSize: FontSize.s14
                                      //         , fontWeight: FontWeightManager.regular)

                                      SizedBox(width: MediaQuery.of(context).size.width/100),
                                      TextButton(
                                        onPressed: () => setState(() => varifiedinsurance = null), // Clear selection
                                        child: Text(
                                          'Clear',
                                          style: DocumentTypeDataStyle.customTextStyle(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ); },

                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [

                          Flexible(
                            child: SchedularTextField(
                                controller: groupNbrController,
                                labelText:'Comments'),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          // Flexible(
                          //   child: Container(
                          //
                          //     height: AppSize.s99,
                          //     child: TextFormField(
                          //       controller: commentController,
                          //       maxLines: 3,
                          //       cursorColor: Colors.black,
                          //       decoration: InputDecoration(
                          //         labelText: 'Comments',
                          //         labelStyle: GoogleFonts.firaSans(
                          //           fontSize: FontSize.s10,
                          //           fontWeight: FontWeightManager.regular,
                          //           color: ColorManager.greylight,
                          //         ),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(8.0),
                          //           borderSide: BorderSide(
                          //             color: ColorManager.containerBorderGrey,
                          //             width: 1.0,
                          //           ),
                          //         ),
                          //         enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(8.0),
                          //           borderSide: BorderSide(
                          //             color: ColorManager.containerBorderGrey,
                          //             width: 1.0,
                          //           ),
                          //         ),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(8.0),
                          //           borderSide: BorderSide(
                          //             color: ColorManager.containerBorderGrey,
                          //             width: 1.0,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ///buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    //color: Colors.white,
                    width: 117,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: (){
                        // widget.onBack();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: ColorManager.bluebottom,
                            width: 1,
                          ),
                        ),),
                      child: Text('Cancel',
                        style: TransparentButtonTextConst.customTextStyle(context),
                      ),),
                  ),
                  const SizedBox(
                    width: 30,
                  ),

                  // Text('Status Completed',
                  //   style: GoogleFonts.firaSans(
                  //       decoration: TextDecoration.none,
                  //       fontSize: FontSize.s14,
                  //       fontWeight: FontWeightManager.bold,
                  //       color: ColorManager.greenDark
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  CustomButton(
                    width: 117,
                    height: 30,
                    onPressed: () async {
                      await postIPrimaryScreen(
                        context,
                        widget.patientId,
                        primaryinsuranceController.text,
                        prnameController.text,
                        prstreetController.text,
                        prcodeController.text,
                        suiteAptController.text,
                        selectedCity.toString(),
                        selectedState.toString(),
                        zipcodeController.text,
                        typeController.text,
                        phoneController.text,
                        selectedCategory.toString(),
                        authorisationController.text,
                        //"2024-08-09",
                        effectiveFromController.text,
                        //"2024-08-09",
                        effectiveToController.text,
                        groupNbrController.text,
                        groupNameController.text,
                        policyHICNbrController.text,
                        eligiblityStatus.toString(),
                        varifiedinsurance.toString(),
                        commentController.text,


                      );
                      print("${effectiveFromController.text}");
                      print("${effectiveToController.text}");

                    },
                    child: Text(
                      AppString.save,
                      style:BlueButtonTextConst.customTextStyle(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height:AppSize.s10),
            ],
          ),
        ),
      ),
    );
  }
}