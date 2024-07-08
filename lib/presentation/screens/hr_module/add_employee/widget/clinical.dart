import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'mcq_widget_add-employee.dart';

///prachi to do
class ClinicalTab extends StatefulWidget {
  @override
  State<ClinicalTab> createState() => _ClinicalTabState();
}

class _ClinicalTabState extends State<ClinicalTab> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();
  final TextEditingController _controller9 = TextEditingController();
  final TextEditingController _controller10 = TextEditingController();
  final StreamController<List<AEClinicalDiscipline>> _hrdisciplineController = StreamController<List<AEClinicalDiscipline>>();
  final StreamController<List<AEClinicalCity>> _hrCityController = StreamController<List<AEClinicalCity>>();
  final StreamController<List<AEClinicalReportingOffice>> _hrReportingOfficeController = StreamController<List<AEClinicalReportingOffice>>();
  final StreamController<List<AEClinicalZone>> _hrZoneController = StreamController<List<AEClinicalZone>>();

  String _selectedOption = 'Option 1';

  late int currentPage;

  late int itemsPerPage;

  late List<String> items;

  int? _selectedItemIndex;

  int docZoneId = 0;

  int docAddVisitTypeId = 0;

  int docVisitTypeId =0;

  int empTypeId =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HrAddEmplyClinicalDisciplinApi(context, 1).then((data){
      _hrdisciplineController.add(data);
    });
    HrAddEmplyClinicalCityApi(context);
    HrAddEmplyClinicalReportingOfficeApi(context, 11).then((data){
      _hrReportingOfficeController.add(data);
    });
    HrAddEmplyClinicalZoneApi(context, ).then((data){
      _hrZoneController.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.39;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.25;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    // FocusNode _focusNode = FocusNode();


    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.green,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ///upload photo
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.file_upload_outlined,color: Colors.white,),
                    label: Text(
                      'Upload Photo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1696C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            /// first container
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        // width: containerWidth,
                        height: containerHeight1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: Color(0xffB7B7B7),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child:
                                  FutureBuilder<List<AEClinicalDiscipline>>(
                                    future: HrAddEmplyClinicalDisciplinApi(context, 1),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            child: Container(
                                              width: 180,
                                              height: 40,
                                              decoration: BoxDecoration(color: ColorManager.faintGrey),
                                            ),
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<String> dropDownList = [];
                                        for (var i in snapshot.data!) {
                                          dropDownList.add(i.empType!);
                                        }
                                        return CustomDropdownTextField(
                                          labelText: 'Disciplines',
                                          labelStyle: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          labelFontSize: 10,
                                          items: dropDownList,
                                          onChanged: (newValue) {
                                            for (var a in snapshot.data!) {
                                              if (a.empType == newValue) {
                                                // int docType = a.employeeTypesId;
                                                // Do something with docType
                                              }
                                            }
                                          },
                                        );
                                      } else {
                                        return const Offstage();
                                      }
                                    },
                                  ),
                                  ///
                                  // FutureBuilder<List<AEClinicalDiscipline>>(
                                  //   future:  HrAddEmplyClinicalDisciplinApi(context, 1),
                                  //   builder: (context, snapshot) {
                                  //     if(snapshot.connectionState == ConnectionState.waiting){
                                  //       return Shimmer.fromColors(
                                  //           baseColor: Colors.grey[300]!,
                                  //           highlightColor: Colors.grey[100]!,
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.symmetric(horizontal: 7),
                                  //             child: Container(
                                  //               width: 180,
                                  //               height: 40,
                                  //               decoration: BoxDecoration( color: ColorManager.faintGrey,),
                                  //
                                  //             ),
                                  //           )
                                  //       );
                                  //     }
                                  //     if(snapshot.hasData){
                                  //       int docType = 0;
                                  //       List<DropdownMenuItem<String>> dropDownList =[];
                                  //       List<DropdownMenuItem<String>> dropDownAbbreviation =[];
                                  //       for(var i in snapshot.data!){
                                  //         dropDownList.add(DropdownMenuItem<String>(
                                  //           child: Text(i.empType!),
                                  //           value: i.empType,
                                  //         ));
                                  //         dropDownAbbreviation.add(
                                  //             DropdownMenuItem<String>(
                                  //               child: Text(i.abbrivation!),
                                  //               value: i.abbrivation,
                                  //             ));
                                  //       }
                                  //       return
                                  //         Padding(
                                  //           padding: const EdgeInsets.symmetric(horizontal: 7),
                                  //           child: Container(
                                  //             height: 30,
                                  //             width: 180,
                                  //             // margin: EdgeInsets.symmetric(horizontal: 20),
                                  //             padding:
                                  //             const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               border: Border.all(
                                  //                   color: const Color(0xff686464).withOpacity(0.5),
                                  //                   width: 1), // Black border
                                  //                borderRadius:
                                  //                BorderRadius.circular(5), // Rounded corners
                                  //             ),
                                  //             child: DropdownButtonFormField<String>(
                                  //               focusColor: Colors.transparent,
                                  //               icon: const Icon(
                                  //                 Icons.arrow_drop_down_sharp,
                                  //                 color: Colors.blue,
                                  //               ),
                                  //               decoration: const InputDecoration.collapsed(
                                  //                   hintText: 'Discipline'),
                                  //               items: dropDownList,
                                  //               onChanged: (newValue) {
                                  //                 for(var a in snapshot.data!){
                                  //                   if(a.empType == newValue){
                                  //                     docType = a.employeeTypesId;
                                  //                     empTypeId = docType;
                                  //                   }
                                  //                 }
                                  //               },
                                  //               value: dropDownList[0].value,
                                  //               style: GoogleFonts.firaSans(
                                  //                 fontSize: 12,
                                  //                 fontWeight: FontWeight.w600,
                                  //                 color: const Color(0xff686464),
                                  //                 decoration: TextDecoration.none,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         );
                                  //       //   CustomDropdownTextField(
                                  //       //   labelText: 'Disciplines',
                                  //       //   labelStyle: TextStyle(
                                  //       //       fontSize: 12,
                                  //       //       color: Color(0xff575757),
                                  //       //       fontWeight: FontWeight.w400),
                                  //       //   labelFontSize: 12,
                                  //       //   items: ['A', 'B', 'C', 'D'],
                                  //       // );
                                  //     }else{
                                  //       return const Offstage();
                                  //     }
                                  //   }
                                  // ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 20,
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller1,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 20,
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller2,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FutureBuilder<List<AEClinicalDiscipline>>(
                                    future: HrAddEmplyClinicalDisciplinApi(context, 1),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            child: Container(
                                              width: 180,
                                              height: 40,
                                              decoration: BoxDecoration(color: ColorManager.faintGrey),
                                            ),
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<String> dropDownList = [];
                                        for (var i in snapshot.data!) {
                                          dropDownList.add(i.empType!);
                                        }
                                        return CustomDropdownTextField(
                                          labelText: 'Speciality',
                                          labelStyle: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          labelFontSize: 10,
                                          items: dropDownList,
                                          onChanged: (newValue) {
                                            for (var a in snapshot.data!) {
                                              if (a.empType == newValue) {
                                                // int docType = a.employeeTypesId;
                                                // Do something with docType
                                              }
                                            }
                                          },
                                        );
                                      } else {
                                        return const Offstage();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 20,
                                    labelText: 'Social Security No',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller3,
                                    suffixIcon: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Primary Phone No',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller4,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Secondary Phone No',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller5,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Personal Phone No',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller6,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child:
                                  FutureBuilder<List<AEClinicalCity>>(
                                    future: HrAddEmplyClinicalCityApi(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            child: Container(
                                              width: 180,
                                              height: 40,
                                              decoration: BoxDecoration(color: ColorManager.faintGrey),
                                            ),
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<String> dropDownList = [];
                                        for (var i in snapshot.data!) {
                                          dropDownList.add(i.cityName!);
                                        }
                                        return CustomDropdownTextField(
                                          labelText: 'City',
                                          labelStyle: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          labelFontSize: 12,
                                          items: dropDownList,
                                        );
                                        } else {
                                        return const Offstage();
                                        }
                                       },
                                     ),),
                                    ///
                                   // FutureBuilder<List<AEClinicalCity>>(
                                  //     future:   HrAddEmplyClinicalCityApi(context),
                                  //     builder: (context, snapshot) {
                                  //       if(snapshot.connectionState == ConnectionState.waiting){
                                  //         return Shimmer.fromColors(
                                  //             baseColor: Colors.grey[300]!,
                                  //             highlightColor: Colors.grey[100]!,
                                  //             child: Padding(
                                  //               padding: const EdgeInsets.symmetric(horizontal: 7),
                                  //               child: Container(
                                  //                 width: 180,
                                  //                 height: 40,
                                  //                 decoration: BoxDecoration( color: ColorManager.faintGrey,),
                                  //               ),
                                  //             )
                                  //         );
                                  //       }
                                  //       if(snapshot.hasData){
                                  //         int docType = 0;
                                  //         List<DropdownMenuItem<String>> dropDownList =[];
                                  //         List<DropdownMenuItem<String>> dropDownAbbreviation =[];
                                  //         for(var i in snapshot.data!){
                                  //           dropDownList.add(DropdownMenuItem<String>(
                                  //             child: Text(i.cityName!),
                                  //             value: i.cityName,
                                  //           ));
                                  //           dropDownAbbreviation.add(
                                  //               DropdownMenuItem<String>(
                                  //                 child: Text(i.cityName!),
                                  //                 value: i.cityName,
                                  //               ));
                                  //         }
                                  //         return
                                  //           Padding(
                                  //             padding: const EdgeInsets.symmetric(horizontal: 7),
                                  //             child: Container(
                                  //               height: 30,
                                  //               width: 180,
                                  //               // margin: EdgeInsets.symmetric(horizontal: 20),
                                  //               padding:
                                  //               const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                  //               decoration: BoxDecoration(
                                  //                 color: Colors.white,
                                  //                 border: Border.all(
                                  //                     color: const Color(0xff686464).withOpacity(0.5),
                                  //                     width: 1), // Black border
                                  //                 borderRadius:
                                  //                 BorderRadius.circular(5), // Rounded corners
                                  //               ),
                                  //               child: DropdownButtonFormField<String>(
                                  //                 focusColor: Colors.transparent,
                                  //                 icon: const Icon(
                                  //                   Icons.arrow_drop_down_sharp,
                                  //                   color: Colors.blue,
                                  //                 ),
                                  //                 decoration: const InputDecoration.collapsed(
                                  //                     hintText: 'Discipline'),
                                  //                 items: dropDownList,
                                  //                 onChanged: (newValue) {
                                  //                   for(var a in snapshot.data!){
                                  //                     if(a.cityName == newValue){
                                  //                       // docType = a.employeeTypesId;
                                  //                       // empTypeId = docType;
                                  //                     }
                                  //                   }
                                  //                 },
                                  //                 value: dropDownList[0].value,
                                  //                 style: GoogleFonts.firaSans(
                                  //                   fontSize: 12,
                                  //                   fontWeight: FontWeight.w600,
                                  //                   color: const Color(0xff686464),
                                  //                   decoration: TextDecoration.none,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           );
                                  //         //   CustomDropdownTextField(
                                  //         //   labelText: 'Disciplines',
                                  //         //   labelStyle: TextStyle(
                                  //         //       fontSize: 12,
                                  //         //       color: Color(0xff575757),
                                  //         //       fontWeight: FontWeight.w400),
                                  //         //   labelFontSize: 12,
                                  //         //   items: ['A', 'B', 'C', 'D'],
                                  //         // );
                                  //       }else{
                                  //         return const Offstage();
                                  //       }
                                  //     }
                                  // ),),
                                  ///
                                  //   CustomDropdownTextField(
                                //     labelText: 'City',
                                //     labelStyle: TextStyle(
                                //         fontSize: 12,
                                //         color: Color(0xff575757),
                                //         fontWeight: FontWeight.w400),
                                //     labelFontSize: 12,
                                //     items: ['A', 'B', 'C', 'D'],
                                //   ),
                                // ),
                                Expanded(
                                  flex: 1,
                                  child: CustomDropdownTextField(
                                    labelText: 'Country',
                                    labelStyle: TextStyle(),
                                    labelFontSize: 12,
                                    items: ['A', 'B', 'C', 'D'],
                                  ),
                                ),
                                Expanded(
                          flex: 1,
                          child: FutureBuilder<List<AEClinicalZone>>(
                            future: HrAddEmplyClinicalZoneApi(context,),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['Loading...'],
                                );
                              } else if (snapshot.hasError) {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['Error'], // Placeholder item for error state
                                );
                              } else if (snapshot.hasData) {
                                List<String> dropDownList = snapshot.data!.map((zone) => zone.zoneName ?? '').toList();
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    // Handle onChanged here if needed
                                  },
                                );
                              } else {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['No Data'],
                                );
                              }
                            },
                          ),
                        ),
                                 // Expanded(
                                //   flex: 1,
                                //   child: CustomDropdownTextField(
                                //     labelText: 'Zone',
                                //     labelStyle: TextStyle(
                                //         fontSize: 12,
                                //         color: Color(0xff575757),
                                //         fontWeight: FontWeight.w400),
                                //     labelFontSize: 12,
                                //     items: ['A', 'B', 'C', 'D'],
                                //   ),
                                // ),
                                Expanded(
                                  flex: 1,
                                  child:
                                  FutureBuilder<List<AEClinicalReportingOffice>>(
                                    future: HrAddEmplyClinicalReportingOfficeApi(context, 11),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            child: Container(
                                              width: 180,
                                              height: 40,
                                              decoration: BoxDecoration(color: ColorManager.faintGrey),
                                            ),
                                          ),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<String> dropDownList = [];
                                        for (var i in snapshot.data!) {
                                          if (i.name != null) {
                                            dropDownList.add(i.name!);
                                          }
                                        }
                                        return CustomDropdownTextField(
                                          labelText: 'Reporting Office',
                                          labelStyle: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          labelFontSize: 10,
                                          items: dropDownList,
                                          onChanged: (newValue) {
                                            for (var a in snapshot.data!) {
                                              if (a.name == newValue) {
                                                 // int? docType = a.companyOfficeID;

                                              }
                                            }
                                          },
                                        );
                                      } else {
                                        return const Offstage();
                                      }
                                    },
                                  ),
                                  ///
                                  // CustomDropdownTextField(
                                  //   labelText: 'Reporting Office',
                                  //   labelStyle: TextStyle(),
                                  //   labelFontSize: 12,
                                  //   items: ['A', 'B', 'C', 'D'],
                                  // ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Personal Email',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller7,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Work Email',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller8,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Address',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller9,
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    width: textFieldWidth,
                                    height: textFieldHeight,
                                    cursorHeight: 22,
                                    labelText: 'Date of Birth',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400),
                                    controller: _controller10,
                                    suffixIcon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                    focusNode: FocusNode(),
                                    labelFontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(children: [
                              Expanded(
                                flex: 1,
                                child: CustomDropdownTextField(
                                  labelText: 'Emergency Contact',
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff575757),
                                      fontWeight: FontWeight.w400),
                                  labelFontSize: 12,
                                  items: ['A', 'B', 'C', 'D'],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container()),
                              Expanded(
                                  flex: 1,
                                  child: Container()),
                              Expanded(
                                  flex: 1,
                                  child: Container())
                            ],)
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       left: MediaQuery.of(context).size.width / 24),
                            //   child: CustomTextField(
                            //     width: textFieldWidth,
                            //     height: textFieldHeight,
                            //     cursorHeight: 22,
                            //     labelText: 'Emergency',
                            //     labelStyle: TextStyle(),
                            //     controller: _controller2,
                            //     focusNode: FocusNode(),
                            //     labelFontSize: 12,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /// second Container
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height / 70),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        // width: containerWidth,
                        height: containerHeight2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: Color(0xffB7B7B7),
                          ),
                          color: Colors.white,
                        ),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: McqWidget(
                                      title: 'Employment',
                                      items: [
                                        'Full Time',
                                        'Contract',
                                        'Part Time',
                                        'Per Diem'
                                      ],
                                      onChanged: (selectedIndex) {
                                        print('Selected index: $selectedIndex');
                                        _selectedItemIndex = selectedIndex;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: McqWidget(
                                      title: 'Status',
                                      items: ['Active', 'Trainee', 'Inactive'],
                                      onChanged: (int) {},
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: McqWidget(
                                      title: 'Flexible Coverage',
                                      items: [
                                        'Saturday',
                                        'Sunday',
                                        'Holiday',
                                        'On Call'
                                      ],
                                      onChanged: (int) {},
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: McqWidget(
                                      title: 'Service',
                                      items: [
                                        'Home Health',
                                        'Hospice',
                                        'Home Care',
                                        'Palliative Care'
                                      ],
                                      onChanged: (int) {},
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: McqWidget(
                                      title: 'Gender',
                                      items: [
                                        'Male',
                                        'Female',
                                        'Other',
                                      ],
                                      onChanged: (int) {},
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container())
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                      width: 125,
                      height: 33,
                      text: 'Add Employee',
                      style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                      ),
                      borderRadius: 12,
                      onPressed: (){})


                        ],
                      ),
            ),
          ])
      ),
    );
  }
}
