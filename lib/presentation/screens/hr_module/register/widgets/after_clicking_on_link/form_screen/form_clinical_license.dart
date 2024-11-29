import 'dart:async';

//import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import '../../../../../../../app/constants/app_config.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/clinical_licenses_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/form_health_record_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../../../widgets/error_popups/failed_popup.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class Clinical_licenses extends StatefulWidget {
  final int employeeID;
  final Function onSave;
  final Function onBack;
  const Clinical_licenses(
      {super.key,
      required this.employeeID,
      required this.onSave,
      required this.onBack,
      required this.context});

  final BuildContext context;
  @override
  State<Clinical_licenses> createState() => _Clinical_licensesState();
}

class _Clinical_licensesState extends State<Clinical_licenses> {
  final StreamController<List<HREmployeeDocumentModal>> healthrecord =
      StreamController<List<HREmployeeDocumentModal>>();

  bool _loading = false;
  bool isLoading = false;
  Uint8List? finalPathDl;
  String? fileNameDl;

  //
  Uint8List? finalPathPl;
  String? fileNamePl;

  String _trimSummery(String address) {
    const int maxLength = 16;
    if (address.length > maxLength) {
      return '${address.substring(0, maxLength)}...';
    }
    return address;
  }
  TextEditingController expirydatecontrollerdl = TextEditingController();
  TextEditingController expirydatecontrollerpl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text('Clinical License',
                style: FormHeading.customTextStyle(context)),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE6F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Kindly Upload The Driving License And Practitioner License Compulsory',
              textAlign: TextAlign.center,
              style: ZoneDataStyle.customTextStyle(context),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Container(
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: const Color(0xffB1B1B1)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Driving License',
                                      // document.docName,
                                      style: AllPopupHeadings.customTextStyle(
                                          context),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 8),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Expiry Date',
                                          style: onlyFormDataStyle
                                              .customTextStyle(context),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        CustomTextFieldRegister(
                                          width: 200,
                                          controller: expirydatecontrollerdl,
                                          hintText: 'yyyy-mm-dd',
                                          hintStyle: onlyFormDataStyle
                                              .customTextStyle(context),
                                          height: 30,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.calendar_month_outlined,
                                              color: Color(0xff50B5E5),
                                              size: 16,
                                            ),
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              if (pickedDate != null) {
                                                expirydatecontrollerdl.text =
                                                    "${pickedDate.toLocal()}"
                                                        .split(' ')[0];
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Upload Immunization records in pdf, jpg or png  format',
                                      style: onlyFormDataStyle
                                          .customTextStyle(context),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        // color: Colors.pink,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffB1B1B1)),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        FilePickerResult?
                                                            result =
                                                            await FilePicker
                                                                .platform
                                                                .pickFiles(
                                                                    type: FileType
                                                                        .custom,
                                                                    allowedExtensions: [
                                                              'pdf'
                                                            ]);

                                                        if (result != null) {
                                                          final file = result
                                                              .files.first;
                                                          setState(() {
                                                            fileNameDl =
                                                                file.name;
                                                            finalPathDl =
                                                                file.bytes;
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        "Choose File",
                                                        style: onlyFormDataStyle
                                                            .customTextStyle(
                                                                context),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xffD9D9D9),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // If a file is picked, display the file name, otherwise show 'No file selected'
                                                  _loading
                                                      ? SizedBox(
                                                          width: 25,
                                                          height: 25,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ColorManager
                                                                .blueprime,
                                                          ),
                                                        )
                                                      : (fileNameDl != null &&
                                                              fileNameDl!
                                                                  .isNotEmpty)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                _trimSummery('$fileNameDl'),
                                                                style: onlyFormDataStyle
                                                                    .customTextStyle(
                                                                        context),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'No file chosen',
                                                                style: onlyFormDataStyle
                                                                    .customTextStyle(
                                                                        context),
                                                              ),
                                                            ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: const Color(0xffB1B1B1)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Practitioner License',
                                      // document.docName,
                                      style: AllPopupHeadings.customTextStyle(
                                          context),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 8),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Expiry Date',
                                          style: onlyFormDataStyle
                                              .customTextStyle(context),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        CustomTextFieldRegister(
                                          width: 200,
                                          controller: expirydatecontrollerpl,
                                          hintText: 'yyyy-mm-dd',
                                          hintStyle: onlyFormDataStyle
                                              .customTextStyle(context),
                                          height: 30,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.calendar_month_outlined,
                                              color: Color(0xff50B5E5),
                                              size: 16,
                                            ),
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );
                                              if (pickedDate != null) {
                                                expirydatecontrollerpl.text =
                                                    "${pickedDate.toLocal()}"
                                                        .split(' ')[0];
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Upload Immunization records in pdf, jpg or png  format',
                                      style: onlyFormDataStyle
                                          .customTextStyle(context),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        // color: Colors.pink,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffB1B1B1)),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        FilePickerResult?
                                                            result =
                                                            await FilePicker
                                                                .platform
                                                                .pickFiles(
                                                                    type: FileType
                                                                        .custom,
                                                                    allowedExtensions: [
                                                              'pdf'
                                                            ]);

                                                        if (result != null) {
                                                          final file = result
                                                              .files.first;
                                                          setState(() {
                                                            fileNamePl =
                                                                file.name;
                                                            finalPathPl =
                                                                file.bytes;
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        "Choose File",
                                                        style: onlyFormDataStyle
                                                            .customTextStyle(
                                                                context),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xffD9D9D9),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // If a file is picked, display the file name, otherwise show 'No file selected'
                                                  _loading
                                                      ? SizedBox(
                                                          width: 25,
                                                          height: 25,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ColorManager
                                                                .blueprime,
                                                          ),
                                                        )
                                                      : (fileNamePl != null &&
                                                              fileNamePl!
                                                                  .isNotEmpty)
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                _trimSummery('$fileNamePl'),   //'$fileNamePl',
                                                                style: onlyFormDataStyle
                                                                    .customTextStyle(
                                                                        context),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'No file chosen',
                                                                style: onlyFormDataStyle
                                                                    .customTextStyle(
                                                                        context),
                                                              ),
                                                            ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          /////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //color: Colors.white,
                width: 117,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onBack();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: ColorManager.bluebottom,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    'Previous',
                    style: TransparentButtonTextConst.customTextStyle(context),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              isLoading
                  ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    )
                  : CustomButton(
                      width: 117,
                      height: 30,
                      text: 'Save',
                      style: BlueButtonTextConst.customTextStyle(context),
                      borderRadius: 12,
                      onPressed: () async {
                        setState(() {
                          isLoading = true; // Start loading
                        });

    try {
      var response = await postDrivinglicenseData(
        context,
        expirydatecontrollerdl.text,
        '',
        widget.employeeID,
        '',
        fileNameDl!,
      );
      await uploadDocumentsDL(
          context: context,
          drivingLicenceId: response.drivingLicenceId!,
          documentFile: finalPathDl!,
          documentName: fileNameDl!);

      var responsePL = await postpractitionerLicenseData(
        context,
        expirydatecontrollerpl.text,
        '',
        widget.employeeID,
        '',
        fileNamePl!,
      );
      await uploadDocumentsPL(
          context: context,
          practitionerLicenceId:
          responsePL.practitionerLicenceId!,
          documentFile: finalPathPl!,
          documentName: fileNamePl!);


      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AddSuccessPopup(
            message: 'Clinical License Data Saved',
          );
        },
      );
      await widget.onSave();
    }
    catch(e){
      await showDialog(
        context: context,
        builder: (BuildContext context) => FailedPopup(text: "Something Went Wrong"),
      );
    }
                        setState(() {
                          isLoading = false; // End loading
                        });

                      },

                      child: Text(
                        'Save',
                        style: BlueButtonTextConst.customTextStyle(context),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
