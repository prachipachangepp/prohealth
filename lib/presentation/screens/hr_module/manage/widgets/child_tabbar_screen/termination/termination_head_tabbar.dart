import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/termination_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/termination_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/row_container_widget_const.dart';

import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../em_module/widgets/button_constant.dart';
import '../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../em_module/widgets/header_content_const.dart';
import '../../../../register/taxtfield_constant.dart';
import '../../custom_icon_button_constant.dart';

class TerminationHeadTabbar extends StatefulWidget {
  final int employeeId;
  const TerminationHeadTabbar({super.key, required this.employeeId});

  @override
  State<TerminationHeadTabbar> createState() => _TerminationHeadTabbarState();
}

class _TerminationHeadTabbarState extends State<TerminationHeadTabbar> {
  final StreamController<List<TerminationData>> terminationStremController =
      StreamController<List<TerminationData>>();

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      //spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(right: 10),
                child: CustomIconButtonConst(
                    width: 110,
                    text: "Terminate",
                    icon: Icons.add,
                    onPressed: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (_) =>
                      //         TerminatePopup(employeeId: widget.employeeId));
                    }
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<List<TerminationData>>(
              stream: terminationStremController.stream,
              builder: (context, snapshot) {
                getTermination(context).then((data) {
                  terminationStremController.add(data);
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
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: WrapWidget(
                        childern: List.generate(snapshot.data!.length, (index) {
                      var termination = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            color: ColorManager.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 120,
                              vertical: MediaQuery.of(context).size.height / 120,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Employee #${termination.userId}',
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s13,
                                        color: ColorManager.blackfaint,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 50,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(AppString.name,
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Date of Termination',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Date of Resignation',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Date of Hire',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text(AppString.status,
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text(AppString.save,
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Phone No.',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Rehirable',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Final Address',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                          ],
                                        ),
                                        const SizedBox(width: AppSize.s25),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${termination.firstName} " +
                                                  "${termination.lastName}",
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.dateOfTermination,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.dateOfResignation,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.checkDate,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.status,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.service,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.primaryPhoneNo,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.rehirable,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.finalAddress,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 10,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(AppString.type,
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Reason',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Final Paycheck',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text(AppString.date,
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Gross Pay',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Net Pay',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Methods',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text('Materials',
                                                style:
                                                    ThemeManager.customTextStyle(
                                                        context)),
                                          ],
                                        ),
                                        const SizedBox(width: AppSize.s25),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              termination.type,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              termination.reson,
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text('\$${termination.finalPayCheck}',
                                                style: ThemeManagerDark
                                                    .customTextStyle(context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text(termination.checkDate,
                                                style: ThemeManagerDark
                                                    .customTextStyle(context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              '\$${termination.grossPay}',
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(
                                              '\$${termination.netPay}',
                                              style: ThemeManagerDark
                                                  .customTextStyle(context),
                                            ),
                                            const SizedBox(height: AppSize.s10),
                                            Text(termination.methods,
                                                style: ThemeManagerDark
                                                    .customTextStyle(context)),
                                            const SizedBox(height: AppSize.s10),
                                            Text(termination.materials,
                                                style: ThemeManagerDark
                                                    .customTextStyle(context)),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
                  );
                }
                return const SizedBox();
              }),
        ],

    );
  }
}



























class TerminatePopup extends StatefulWidget {
  final int employeeId;
  TerminatePopup({super.key, required this.employeeId});

  @override
  State<TerminatePopup> createState() => _TerminatePopupState();
}

class _TerminatePopupState extends State<TerminatePopup> {



  TextEditingController terminationdatecltr = TextEditingController();
  TextEditingController namecltr = TextEditingController();
  TextEditingController resignationdatecltr = TextEditingController();
  TextEditingController dateofhirecltr = TextEditingController();
  TextEditingController materialscltr = TextEditingController();
  TextEditingController methodscltr = TextEditingController();
  TextEditingController rehirablecltr = TextEditingController();
  TextEditingController phonenocltr = TextEditingController();
  TextEditingController finaladdrescltr = TextEditingController();
  TextEditingController finalpaycheckcltr = TextEditingController();
  TextEditingController typecltr = TextEditingController();
  TextEditingController reasoncltr = TextEditingController();
  TextEditingController statuscltr = TextEditingController();
  TextEditingController positioncltr = TextEditingController();
  TextEditingController grosspaycltr = TextEditingController();
  TextEditingController netpaycltr = TextEditingController();
  TextEditingController datecltr = TextEditingController();









  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(


        width: 800,
        height: 600,

    body: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  FirstHRTextFConst(controller: namecltr, keyboardType: TextInputType.text, text: 'Name',

                  ),
                  // Text(
                  //  "Name",
                  //   style: GoogleFonts.firaSans(
                  //       fontSize: 10.0,
                  //       fontWeight: FontWeight.w400,
                  //       color: const Color(0xff686464)),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 60),
                  // CustomTextFieldRegister(
                  //   controller: namecltr,
                  //   hintText: 'Enter Text',
                  //   hintStyle: GoogleFonts.firaSans(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.w400,
                  //     color: const Color(0xff9B9B9B),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   height: 32,
                  //   width: 300,
                  // ),

                  HeaderContentConst(
                    heading:"Termination Date",
                    content: FormField<String>(
                      builder: (FormFieldState<String> field) {
                        return SizedBox(
                          width: 354,
                          height: 30,
                          child: TextFormField(
                            controller: terminationdatecltr,
                            cursorColor: ColorManager.black,
                            style:  DocumentTypeDataStyle.customTextStyle(context),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.fmediumgrey, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.fmediumgrey, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              hintText: 'MM-DD-YYYY',
                              hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 1, color: ColorManager.fmediumgrey),
                              ),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 16),
                              suffixIcon: Icon(Icons.calendar_month_outlined,
                                  color: ColorManager.blueprime),
                              errorText: field.errorText,
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,

                                firstDate: DateTime(1901),
                                lastDate: DateTime(3101),
                              );
                              if (pickedDate != null) {
                                terminationdatecltr.text =
                                        "${pickedDate.toLocal()}"
                                            .split(' ')[0];
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please select date';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Text(
                  //   'Termination Date',
                  //   style: GoogleFonts.firaSans(
                  //       fontSize: 10.0,
                  //       fontWeight: FontWeight.w400,
                  //       color: const Color(0xff686464)),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 60),
                  // CustomTextFieldRegister(
                  //   controller: terminationdatecltr,
                  //   hintText: 'dd-mm-yyyy',
                  //   hintStyle: GoogleFonts.firaSans(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.w400,
                  //     color: Color(0xff9B9B9B),
                  //   ),
                  //   height: 32,
                  //   width: 300,
                  //   suffixIcon: IconButton(
                  //     icon: Icon(
                  //       Icons.calendar_month_outlined,
                  //       color: Color(0xff50B5E5),
                  //       size: 16,
                  //     ),
                  //     onPressed: () async {
                  //       DateTime? pickedDate =
                  //       await showDatePicker(
                  //         context: context,
                  //         initialDate: DateTime.now(),
                  //         firstDate: DateTime(2000),
                  //         lastDate: DateTime(2101),
                  //       );
                  //       if (pickedDate != null) {
                  //         terminationdatecltr.text =
                  //         "${pickedDate.toLocal()}"
                  //             .split(' ')[0];
                  //       }
                  //     },
                  //   ),
                  // ),
                  Text(
                    'Resignation Date',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  HeaderContentConst(
                    heading:"Resignation Date",
                    content: FormField<String>(
                      builder: (FormFieldState<String> field) {
                        return SizedBox(
                          width: 354,
                          height: 30,
                          child: TextFormField(
                            controller: resignationdatecltr,
                            cursorColor: ColorManager.black,
                            style:  DocumentTypeDataStyle.customTextStyle(context),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.fmediumgrey, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.fmediumgrey, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              hintText: 'MM-DD-YYYY',
                              hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 1, color: ColorManager.fmediumgrey),
                              ),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 16),
                              suffixIcon: Icon(Icons.calendar_month_outlined,
                                  color: ColorManager.blueprime),
                              errorText: field.errorText,
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,

                                firstDate: DateTime(1901),
                                lastDate: DateTime(3101),
                              );
                              if (pickedDate != null) {
                                resignationdatecltr.text =
                                "${pickedDate.toLocal()}"
                                    .split(' ')[0];
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please select date';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'Date of Hire',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  HeaderContentConst(
                    heading:"Date of Hire",
                    content: FormField<String>(
                      builder: (FormFieldState<String> field) {
                        return SizedBox(
                          width: 354,
                          height: 30,
                          child: TextFormField(
                            controller: dateofhirecltr,
                            cursorColor: ColorManager.black,
                            style:  DocumentTypeDataStyle.customTextStyle(context),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.fmediumgrey, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManager.fmediumgrey, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              hintText: 'MM-DD-YYYY',
                              hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 1, color: ColorManager.fmediumgrey),
                              ),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 16),
                              suffixIcon: Icon(Icons.calendar_month_outlined,
                                  color: ColorManager.blueprime),
                              errorText: field.errorText,
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,

                                firstDate: DateTime(1901),
                                lastDate: DateTime(3101),
                              );
                              if (pickedDate != null) {
                                dateofhirecltr.text =
                                "${pickedDate.toLocal()}"
                                    .split(' ')[0];
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please select date';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Text(
                  //   'Status',
                  //   style: GoogleFonts.firaSans(
                  //       fontSize: 10.0,
                  //       fontWeight: FontWeight.w400,
                  //       color: const Color(0xff686464)),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 60),
                  // CustomTextFieldRegister(
                  //   controller: statuscltr,
                  //   hintText: 'Enter Text',
                  //   hintStyle: GoogleFonts.firaSans(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.w400,
                  //     color: const Color(0xff9B9B9B),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   height: 32,
                  //   width: 300,
                  // ),
                  FirstHRTextFConst(controller: positioncltr, keyboardType: TextInputType.text, text: 'Position',

                  ),
                  // Text(
                  //   'Position',
                  //   style: GoogleFonts.firaSans(
                  //       fontSize: 10.0,
                  //       fontWeight: FontWeight.w400,
                  //       color: const Color(0xff686464)),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 60),
                  // CustomTextFieldRegister(
                  //   controller: positioncltr,
                  //   hintText: 'Enter Text',
                  //   hintStyle: GoogleFonts.firaSans(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.w400,
                  //     color: const Color(0xff9B9B9B),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   height: 32,
                  //   width: 300,
                  // ),

                  FirstHRTextFConst(controller: phonenocltr, keyboardType: TextInputType.number, text: 'Phone No.',

                  ),
                  // Text(
                  //   'Phone No.',
                  //   style: GoogleFonts.firaSans(
                  //       fontSize: 10.0,
                  //       fontWeight: FontWeight.w400,
                  //       color: const Color(0xff686464)),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 60),
                  // CustomTextFieldRegister(
                  //   controller: phonenocltr,
                  //   hintText: 'Enter Text',
                  //   hintStyle: GoogleFonts.firaSans(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.w400,
                  //     color: const Color(0xff9B9B9B),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   height: 32,
                  //   width: 300,
                  // ),

                  FirstHRTextFConst(controller: rehirablecltr, keyboardType: TextInputType.text, text: 'Rehirable',

                  ),
                  // Text(
                  //   'Rehirable',
                  //   style: GoogleFonts.firaSans(
                  //       fontSize: 10.0,
                  //       fontWeight: FontWeight.w400,
                  //       color: const Color(0xff686464)),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 60),
                  // CustomTextFieldRegister(
                  //   controller: rehirablecltr,
                  //   hintText: 'Enter Text',
                  //   hintStyle: GoogleFonts.firaSans(
                  //     fontSize: 10.0,
                  //     fontWeight: FontWeight.w400,
                  //     color: const Color(0xff9B9B9B),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   height: 32,
                  //   width: 300,
                  // ),

                  FirstHRTextFConst(controller: rehirablecltr, keyboardType: TextInputType.text, text: '',

                  ),
                  Text(
                    'Final Address',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: finaladdrescltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),


              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 50,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: typecltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Reason',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: reasoncltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Final Paycheck',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller:finalpaycheckcltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Date',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: datecltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Gross Pay',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: grosspaycltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Net Pay',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: netpaycltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Methods',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: methodscltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  ),
                  Text(
                    'Materials',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: materialscltr,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9B9B9B),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    height: 32,
                    width: 300,
                  )
                ],
              ),
            ],
          ),


    
        ],
      bottomButtons:   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonTransparent(
            text: AppString.cancel,
            onPressed: () async {
              Navigator.pop(context);
            },
          ),

          SizedBox(width:25),
          CustomElevatedButton(
            width: AppSize.s100,
            text: "Terminate",
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  Future.delayed(
                    const Duration(seconds: 3),
                        () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  );
                  return const AddSuccessPopup(
                    message: 'Added Successfully',
                  );
                },
              );
            },
          ),
        ],
      ),
      title: "Terminate",
    

    );
  }
}
