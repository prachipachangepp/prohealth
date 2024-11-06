import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';

import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../widgets/button_constant.dart';
import 'checkbox_constant.dart';

class CIDetailsScreen extends StatefulWidget {
  CIDetailsScreen(
      {super.key,
      required this.officeId,
      required this.docTD,
      required this.companyId,
      required int companyID,
      required this.companyOfficeid,
      required this.stateName,
      required this.countryName});
  final String stateName;
  final String countryName;
  final int companyId;
  final int docTD;
  final int companyOfficeid;
  final String officeId;

  @override
  State<CIDetailsScreen> createState() => _CIDetailsScreenState();
}

class _CIDetailsScreenState extends State<CIDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController secNumberController = TextEditingController();
  TextEditingController primNumController = TextEditingController();
  TextEditingController altNumController = TextEditingController();
  TextEditingController primeFaxController = TextEditingController();
  TextEditingController secFaxController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hcoNumController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController npiNumController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  late final Future<ManageDetails> _companyDetailsFuture;
  //  final StreamController<List<ManageDetails>> _companyDetailsFuture =
  //  StreamController<List<ManageDetails>>();
//List<bool> checkboxValues = [];
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  final FocusNode _focusNode = FocusNode();

  List<String> dropdownItems1 = [
    'Home Health',
    'HCO Number: 254612',
    'Medicare ID: MPID123',
    'NPI Number: 1234567890',
  ];

  List<String> dropdownItems2 = [
    'Home Care',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
  ];

  List<String> dropdownItems3 = [
    'Hospice',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
  ];

  List<String> dropdownItems4 = [
    'Palliative Care',
    'HCO Number 254612',
    'Medicare ID MPID123',
    'NPI Number 1234567890',
  ];
  void updateDropdownItems1() {
    setState(() {
      dropdownItems1 = [
        'Home Health',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  void updateDropdownItems2() {
    setState(() {
      dropdownItems2 = [
        'Home Care',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  void updateDropdownItems3() {
    setState(() {
      dropdownItems3 = [
        'Hospice',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }

  void updateDropdownItems4() {
    setState(() {
      dropdownItems4 = [
        'Palliative Care',
        'HCO Number ${hcoNumController.text}',
        'Medicare ID ${medicareController.text}',
        'NPI Number ${npiNumController.text}',
      ];
    });
  }


  String latitude = '';
  String longitude = '';
  bool isChecked = false;
  Future<void> updateServices(
      int officeServiceId,
      String officeId,
      String serviceName,
      String serviceId,
      String npiNum,
      String medicareNum,
      String hcoNumber) async {
    await patchCompanyOfficeService(context, officeServiceId, officeId,
        serviceName, serviceId, npiNum, medicareNum, hcoNumber);
    setState(() {
      companyDetailGetAll(context, widget.officeId);
    });
  }

  Future<void> deleteService(int officeServiceId) async {
    await deleteCompanyOfficeService(context, officeServiceId);
    setState(() {
      companyDetailGetAll(context, widget.officeId);
    });
  }
 bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<ManageDetails?>(
        future: companyDetailGetAll(context, widget.officeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            // Initialize controllers with fetched data
            nameController.text = snapshot.data!.officeName;
            primNumController.text = snapshot.data!.priNumber;
            secNumberController.text = snapshot.data!.secNumber;
            altNumController.text = snapshot.data!.alternateNumber;
            addressController.text = snapshot.data!.address;
            emailController.text = snapshot.data!.email;
            primeFaxController.text = snapshot.data!.primaryFax;
            secFaxController.text = snapshot.data!.secondaryFax;
            stateNameController.text = snapshot.data!.stateName;
            countryNameController.text = snapshot.data!.countryName;
            latitude = snapshot.data!.lat;
            longitude = snapshot.data!.long;

            List<Widget> serviceRows = [];
            print('Fetched lat lng ${latitude} + ${longitude}');

            for (int i = 0; i < snapshot.data!.serviceDetails!.length; i += 2) {
              List<Widget> rowChildren = [];

              for (int j = 0; j < 2; j++) {
                if (i + j < snapshot.data!.serviceDetails!.length) {
                  var serviceDetail = snapshot.data!.serviceDetails![i + j];
                  npiNumController.text = serviceDetail.npiNum;
                  hcoNumController.text = serviceDetail.hcoNum;
                  medicareController.text = serviceDetail.medicareNum;
                  List<String> dropdownItems = [
                    serviceDetail.serviceName,
                    'HCO Number: ${serviceDetail.hcoNum}',
                    'Medicare ID: ${serviceDetail.medicareNum}',
                    'NPI Number: ${serviceDetail.npiNum}',
                  ];

                  rowChildren.add(
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 25, left: 25, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:70),
                              child: Container(
                                height: 170,
                                width: 400,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.white),
                                child: Column(
                                  children: [
                                    Container(
                                      height: AppSize.s40,
                                      width: AppSize.s450,
                                      decoration: BoxDecoration(
                                        color: ColorManager.blueprime,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Container(
                                                    width: 300,
                                                    child: Text(serviceDetail
                                                        .serviceName,style: GoogleFonts.firaSans(fontSize: AppSize.s12,fontWeight: FontWeightManager.medium,color: Colors.white),),
                                                    // CheckboxTileDetails(
                                                    //   title: serviceDetail
                                                    //       .serviceName,
                                                    //   initialValue: isChecked,
                                                    //   onChanged: (value) {
                                                    //     setState(() {
                                                    //       isChecked = !isChecked;
                                                    //     });
                                                    //   },
                                                    // )
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    splashColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return DialogueTemplate(
                                                              width: AppSize.s420,
                                                              height: 250,
                                                              body: [
                                                                FirstSMTextFConst(
                                                                  controller:
                                                                      hcoNumController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  text:
                                                                      'HCO Number',
                                                                ),
                                                              ],
                                                              bottomButtons: CustomElevatedButton(
                                                                      width: AppSize
                                                                          .s105,
                                                                      height:
                                                                          AppSize
                                                                              .s30,
                                                                      text: AppStringEM
                                                                          .save, //submit
                                                                      onPressed:
                                                                          () async {
                                                                        await updateServices(
                                                                            serviceDetail
                                                                                .officeServiceId,
                                                                            widget
                                                                                .officeId,
                                                                            serviceDetail
                                                                                .serviceName,
                                                                            serviceDetail
                                                                                .serviceId,
                                                                            serviceDetail
                                                                                .npiNum,
                                                                            serviceDetail
                                                                                .medicareNum,
                                                                            hcoNumController
                                                                                .text);
                                                                        hcoNumController
                                                                            .clear();
                                                                        Navigator.pop(
                                                                            context);
                                                                        showDialog(
                                                                          context: context,
                                                                          builder: (BuildContext context) {
                                                                            return AddSuccessPopup(
                                                                              message: 'Service edited successfully.',
                                                                            );
                                                                          },
                                                                        );

                                                                      }),
                                                              title:
                                                                  'Edit Service',
                                                            );
                                                          });
                                                    },
                                                    icon: Icon(
                                                        Icons
                                                            .mode_edit_outline_outlined,
                                                        size: 20,
                                                        color: Colors.white),
                                                  ),
                                                  // SizedBox(width:2),
                                                  IconButton(
                                                    splashColor:
                                                    Colors.transparent,
                                                    hoverColor:
                                                    Colors.transparent,
                                                    highlightColor:
                                                    Colors.transparent,
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            StatefulBuilder(
                                                              builder: (BuildContext context, void Function(void Function()) setState) {
                                                                return DeletePopup(
                                                                    title: DeletePopupString.deleteholiday,
                                                                    loadingDuration: _isLoading,
                                                                    onCancel: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    }, onDelete:
                                                                    () async {
                                                                  setState(() {
                                                                    _isLoading = true;
                                                                  });
                                                                  try {
                                                                    await deleteService(
                                                                        serviceDetail.officeServiceId);
                                                                    //companyDetailGetAll(context, widget.officeId);
                                                                  } finally {
                                                                    setState(() {
                                                                      _isLoading = false;
                                                                    });
                                                                    Navigator.pop(context);
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                      );
                                                      // showDialog(
                                                      //     context: context,
                                                      //     builder: (context) =>
                                                      //         DeletePopup(
                                                      //             title:
                                                      //                 'Delete Service',
                                                      //             onCancel:
                                                      //                 () {
                                                      //               Navigator.pop(
                                                      //                   context);
                                                      //             },
                                                      //             onDelete:
                                                      //                 () async {
                                                      //               await deleteService(
                                                      //                   serviceDetail.officeServiceId);
                                                      //               //companyDetailGetAll(context, widget.officeId);
                                                      //               Navigator.pop(
                                                      //                   context);
                                                      //             }));
                                                    },
                                                    icon: Icon(
                                                        Icons
                                                            .delete_outline_outlined,
                                                        size: 20,
                                                        color:
                                                        Colors.white),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    /// HCO number
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'HCO Number :',
                                            style: ConstTextFieldRegister.customTextStyle(context),
                                          ),
                                          Text(
                                            "${hcoNumController.text}",
                                            style: ConstTextFieldRegister.customTextStyle(context),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Divider
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Divider(
                                        color: ColorManager.faintGrey,
                                        thickness: 1,
                                      ),
                                    ),

                                    /// Medicare ID
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Medicare ID :',
                                            style: ConstTextFieldRegister.customTextStyle(context),
                                          ),
                                          Text(
                                            "${medicareController.text}",
                                            style:ConstTextFieldRegister.customTextStyle(context),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Divider
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Divider(
                                        color: ColorManager.faintGrey,
                                        thickness: 0.5,
                                      ),
                                    ),

                                    /// NPI Number
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'NPI Number :',
                                            style: ConstTextFieldRegister.customTextStyle(context),
                                          ),
                                          Text(
                                            "${npiNumController.text}",
                                            style: ConstTextFieldRegister.customTextStyle(context),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                            // CIDetailsDropdown(
                            //   initialValue: serviceDetail.serviceName,
                            //   items: dropdownItems.map((item) {
                            //     return DropdownMenuItem(
                            //       value: item,
                            //       child: Text(item),
                            //     );
                            //   }).toList(),
                            //   onEditIconTap: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return CIDetailsDropdownPopup(
                            //           onSavePressed: () {
                            //             setState(() {
                            //               dropdownItems = [
                            //                 serviceDetail.serviceName,
                            //                 'HCO Number: ${hcoNumController.text}',
                            //                 'Medicare ID: ${medicareController.text}',
                            //                 'NPI Number: ${npiNumController.text}',
                            //               ];
                            //             });
                            //           },
                            //           hcoNumController: hcoNumController,
                            //           medicareController: medicareController,
                            //           npiNumController: npiNumController,
                            //         );
                            //       },
                            //     );
                            //   },
                            // ),
                            //const SizedBox(width: 100),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }

              serviceRows.add(Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: rowChildren,
              ));
            }

            return Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 12.4,
                right: MediaQuery.of(context).size.width / 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p20),
                    child: Row(
                      children: [
                        Text(
                          AppStringEM.details,
                          style: CompanyIdentityManageHeadings.customTextStyle(
                              context),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: AppSize.s367,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: ColorManager.black.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.15),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      color: ColorManager.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FirstSMTextFConst(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.officename,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConstPhone(
                              controller: secNumberController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.secNum,
                            ),
                            const SizedBox(height: AppSize.s10),
                            FirstSMTextFConst(
                              controller: stateNameController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.stateName,
                            ),

                            // AddressInput(controller: addressController),
                            // SMTextFConst(
                            //
                            //   controller: addressController,
                            //   keyboardType: TextInputType.text,
                            //   text: AppStringEM.address,
                            // ),
                            const SizedBox(height: AppSize.s10),
                            AddressInput(
                              controller: addressController,
                              onSuggestionSelected: (selectedSuggestion) {
                                // Handle the selected suggestion here
                                print("Selected suggestion: $selectedSuggestion");
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SMTextFConstPhone(
                              controller: primNumController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.primNum,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConstPhone(
                              controller: altNumController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.alternatephone,
                            ),
                            const SizedBox(height: AppSize.s10),
                            SMTextFConst(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.primarymail,
                            ),
                            const SizedBox(height: AppSize.s10),
                            FirstSMTextFConst(
                              controller: countryNameController,
                              keyboardType: TextInputType.text,
                              text: AppStringEM.countryName,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // if (_suggestions.isNotEmpty)
                  //   Positioned(
                  //     top: 60, // Adjust as needed
                  //     left: 0,
                  //     child: Container(
                  //       height: 100,
                  //       width: 320,
                  //       decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.circular(8),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.black26,
                  //             blurRadius: 4,
                  //             offset: Offset(0, 2),
                  //           ),
                  //         ],
                  //       ),
                  //       child: ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: _suggestions.length,
                  //         itemBuilder: (context, index) {
                  //           return ListTile(
                  //             title: Text(
                  //               _suggestions[index],
                  //               style: AllPopupHeadings.customTextStyle(context),
                  //             ),
                  //             onTap: () {
                  //               FocusScope.of(context).unfocus();
                  //               addressController.text = _suggestions[index];
                  //               setState(() {
                  //                 _suggestions.clear();
                  //               });
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),

                  /// Service List
                  if (snapshot.data!.serviceDetails != null &&
                      snapshot.data!.serviceDetails!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Services',
                            style:
                                CompanyIdentityManageHeadings.customTextStyle(
                                    context),
                          ),
                          const SizedBox(height: AppSize.s10),
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: serviceRows,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: AppSize.s10),

                  /// Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: AppStringEM.save,
                        onPressed: () async {
                          await patchCompanyOffice(
                              context,
                              widget.companyOfficeid,
                              widget.officeId,
                              primNumController.text,
                              secNumberController.text,
                              primeFaxController.text,
                              secFaxController.text,
                              altNumController.text,
                              emailController.text,
                              nameController.text,
                              addressController.text,
                              latitude,
                              longitude,
                              "",
                              stateNameController.text,
                              countryNameController.text);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddSuccessPopup(
                                message: 'Edited successfully.',
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}



///Address suggestion

class AddressInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSuggestionSelected; // Callback to notify parent

  AddressInput({required this.controller, this.onSuggestionSelected});

  @override
  _AddressInputState createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCountyNameChanged);
    super.dispose();
  }

  void _onCountyNameChanged() async {
    final query = widget.controller.text;
    if (query.isEmpty) {
      setState(() {
        _suggestions.clear();
      });
      return;
    }

    final suggestions = await fetchSuggestions(query);
    setState(() {
      _suggestions = suggestions.isNotEmpty && suggestions[0] != query ? suggestions : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SMTextFConst(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          text: AppStringEM.address,
        ),
        if (_suggestions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top:50),
            child: Container(
              height: 60,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _suggestions[index],
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      widget.controller.text = _suggestions[index];
                      setState(() {
                        _suggestions.clear();
                      });
                      // Call the callback with the selected suggestion
                      if (widget.onSuggestionSelected != null) {
                        widget.onSuggestionSelected!(_suggestions[index]);
                      }
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}


