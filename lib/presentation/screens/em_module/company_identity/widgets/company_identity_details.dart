import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
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
      required this.companyOfficeid});
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

  @override
  void initState() {
    super.initState();
    addressController.addListener(_onAddressChanged);
   //  _focusNode.addListener(() {
   //    if (_focusNode.hasFocus) {
   //      // Populate _suggestionsNotifier with suggestions when the field is focused
   //      addressController.addListener(_onAddressChanged);
   //    } else {
   //      // Clear suggestions when the field loses focus
   //      _suggestionsNotifier.value = [];
   //    }
   //  });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    addressController.removeListener(_onAddressChanged);
    addressController.dispose();
    _suggestionsNotifier.value = [];
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode.addListener(() {
  //     if (_focusNode.hasFocus) {
  //       // Populate _suggestionsNotifier with suggestions when the field is focused
  //       addressController.addListener(_onAddressChanged);
  //     } else {
  //       // Clear suggestions when the field loses focus
  //       _suggestionsNotifier.value = [];
  //     }
  //   });
  //
  //   print(":::::OFFICE ID ${widget.officeId} + ${widget.companyId}");
  // }
  //
  // // List<String> _suggestions = [];
  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   _suggestionsNotifier.value = [];
  //   //addressController.dispose();
  //   super.dispose();
  // }

  //ValueNotifier<List<String>> _suggestionsNotifier = ValueNotifier([]);

  final _suggestionsNotifier = ValueNotifier<List<String>>([]);

  // void _onAddressChanged() async {
  //   if (addressController.text.isEmpty) {
  //     _suggestionsNotifier.value = [];
  //     return;
  //   }
  //
  //   // Fetch suggestions based on the addressController's text
  //   final suggestions = await fetchSuggestions(addressController.text);
  //   _suggestionsNotifier.value = suggestions;
  //   }

  void _onAddressChanged() async {
    final query = addressController.text;

    if (query.isEmpty) {
      _suggestionsNotifier.value = [];
      return;
    }

    try {
      final suggestions = await fetchSuggestions(query);
      _suggestionsNotifier.value = suggestions;
    } catch (e) {
      print("Error fetching suggestions: $e");
      _suggestionsNotifier.value = [];
    }
  }

  //   try {
  //     // Fetch suggestions based on the addressController's text
  //     final suggestions = await fetchSuggestions(addressController.text);
  //     _suggestionsNotifier.value = suggestions;
  //   } catch (e) {
  //     // Handle error if fetching suggestions fails
  //     print("Error fetching suggestions: $e");
  //     _suggestionsNotifier.value = [];
  //   }
  // }

  // Future<List<String>> fetchSuggestions(String query) async {
  //   // Your logic to fetch suggestions goes here
  //   // This is a placeholder implementation
  //   await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  //   return ['Suggestion 1', 'Suggestion 2', 'Suggestion 3']; // Replace with actual logic
  // }

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

            List<Widget> serviceRows = [];

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
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // CheckboxConstant(
                            //   value: i + j == 0
                            //       ? checkboxValue1
                            //       : i + j == 1
                            //       ? checkboxValue2
                            //       : i + j == 2
                            //       ? checkboxValue3
                            //       : checkboxValue4,
                            //   onChanged: (newValue) {
                            //     setState(() {
                            //       if (i + j == 0) {
                            //         checkboxValue1 = newValue!;
                            //       } else if (i + j == 1) {
                            //         checkboxValue2 = newValue!;
                            //       } else if (i + j == 2) {
                            //         checkboxValue3 = newValue!;
                            //       } else {
                            //         checkboxValue4 = newValue!;
                            //       }
                            //     });
                            //   },
                            //   text: '',
                            // ),
                            // const SizedBox(width: 100),

                            CIDetailsDropdown(
                              initialValue: serviceDetail.serviceName,
                              items: dropdownItems.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onEditIconTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CIDetailsDropdownPopup(
                                      onSavePressed: () {
                                        setState(() {
                                          dropdownItems = [
                                            serviceDetail.serviceName,
                                            'HCO Number: ${hcoNumController.text}',
                                            'Medicare ID: ${medicareController.text}',
                                            'NPI Number: ${npiNumController.text}',
                                          ];
                                        });
                                      },
                                      hcoNumController: hcoNumController,
                                      medicareController: medicareController,
                                      npiNumController: npiNumController,
                                    );
                                  },
                                );
                              },
                            ),
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

                  Stack(
                    children: [
                      Container(
                        height: AppSize.s350,
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
                              children: [
                                SMTextFConst(
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
                                SMTextFConst(
                                  focusNode: _focusNode,
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  text: AppStringEM.address,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              ],
                            ),
                          ],
                        ),
                      ),

                      ValueListenableBuilder<List<String>>(
                          valueListenable: _suggestionsNotifier,
                          builder: (context, suggestions, child) {
                            if (suggestions.isEmpty) return SizedBox.shrink();

                            return Positioned(
                              top: 250, // Adjust the position as needed
                              left: 200,

                              child: Container(
                                height: 100,
                                width: 300,
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
                                  itemCount: suggestions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(suggestions[index]),
                                      onTap: () {
                                        // Update TextField with selected suggestion
                                        addressController.text = suggestions[index];
                                        // Optionally clear suggestions
                                        _suggestionsNotifier.value = [];
                                        // Unfocus the TextField if needed
                                        _focusNode.unfocus();
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                      )


                      // Suggestion list appears above the container when not empty
                      // ValueListenableBuilder<List<String>>(
                      //   valueListenable: _suggestionsNotifier,
                      //   builder: (context, suggestions, child) {
                      //     if (suggestions.isEmpty) return SizedBox.shrink();
                      //     return Positioned(
                      //       top: 250, // Adjust the position as needed
                      //       left: 200, // Align it with your container
                      //       child: Container(
                      //         height: 100,
                      //         width: 360,
                      //         decoration: BoxDecoration(
                      //           color: Colors.pink,
                      //           borderRadius: BorderRadius.circular(8),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.black26,
                      //               blurRadius: 4,
                      //               offset: Offset(0, 2),
                      //             ),
                      //           ],
                      //         ),
                      //         child: ListView.builder(
                      //           itemCount: suggestions.length,
                      //           itemBuilder: (context, index) {
                      //             return ListTile(
                      //               title: Text(
                      //                 suggestions[index],
                      //                 style: GoogleFonts.firaSans(
                      //                   fontSize: FontSize.s12,
                      //                   fontWeight: FontWeight.w700,
                      //                   color: ColorManager.mediumgrey,
                      //                   decoration: TextDecoration.none,
                      //                 ),
                      //               ),
                      //               onTap: () {
                      //
                      //                 addressController.text = suggestions[index];
                      //                 _suggestionsNotifier.value = [];
                      //                 _focusNode.unfocus();
                      //               },
                      //             );
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),

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
                              color: Colors.white,
                            ),
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
                          );
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
