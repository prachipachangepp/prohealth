import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:file_picker/file_picker.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/offer_letter_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/offer_letter_html_data/offer_letter_html.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/signature_screen.dart';
import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/token/token_manager.dart';
import '../../../../../../data/api_data/api_data.dart';
import '../../../../em_module/widgets/button_constant.dart';
import '../../../manage/widgets/bottom_row.dart';
import 'multi_step_form.dart';

class OfferLetterDescriptionScreen extends StatefulWidget {
  final dynamic signatureBytes;
  final int employeeId;

  OfferLetterDescriptionScreen({this.signatureBytes, required this.employeeId});

  @override
  State<OfferLetterDescriptionScreen> createState() =>
      _OfferLetterDescriptionScreenState();
}

class _OfferLetterDescriptionScreenState
    extends State<OfferLetterDescriptionScreen> {
  PlatformFile? _selectedFile;
  Uint8List? _webImage;
  // bool _isChecked = false;
  Uint8List? signatureBytes;

  @override
  void initState() {
    super.initState();
    // Initialize the signatureBytes with the value passed from the previous screen
    signatureBytes = widget.signatureBytes;
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        if (kIsWeb) {
          _webImage = _selectedFile!.bytes;
        }
        print("Selected file name: ${_selectedFile!.name}");
        print("Selected file size: ${_selectedFile!.size} bytes");
        if (!kIsWeb) {
          print("Selected file path: ${_selectedFile!.path}");
        }
      });
    } else {
      print("File picking cancelled or failed.");
    }
  }

  int offerId = 1;

  void _clearSelectedFile() {
    setState(() {
      _selectedFile = null;
      _webImage = null;
      // _isChecked = false;
    });
  }

  void _onSignatureSelected(Uint8List? image) {
    setState(() {
      _webImage = image;
    });
  }

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Offer Letter', style: FormHeading.customTextStyle(context)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 15),

          // OfferLetterWidget(employeeId: widget.employeeId),

          FutureBuilder<OfferLetterData>(
            future: GetOfferLetter(
                context, widget.employeeId, AppConfig.templateId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: 1032,
                  height: 1190,
                );
              }
              if (snapshot.hasData) {
                offerId = snapshot.data!.offerId;
                return Container(
                  color: Colors.white,
                  width: 1032,
                  height: 1190,
                  child: Html(
                    data: """${snapshot.data!.template}""",
                    style: {
                      "p": Style(
                        fontSize: FontSize(12.0),
                        color: Color(0xff686464),
                        fontWeight: FontWeight.w400,
                      ),
                      "li": Style(
                        fontSize: FontSize(12.0),
                        color: Color(0xff686464),
                        fontWeight: FontWeight.w400,
                      ),
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: 1,
                  width: 1,
                );
              }
            },
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 100),

          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 90, // Set height to avoid zero height
                  // color: Colors.yellow,
                  child: signatureBytes != null
                      ? Image.memory(
                          signatureBytes!,
                          filterQuality: FilterQuality.high,
                        )
                      : Center(child: Text('')),
                ),

                // Container(
                //    height: 70,
                //  width: 100,
                //    color: Colors.yellow,
                //   child: signatureBytes != null
                //       ? Image.memory(signatureBytes!)
                //       : Text(''),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  const EdgeInsets.only(left: 250),
                child: Container(
                    width: 250,
                    height: 40,
                    // color: Colors.cyanAccent,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignaturePage(
                              onSignatureSelected:
                                  (Uint8List? selectedSignature) {
                                setState(() {
                                  signatureBytes = selectedSignature;
                                });
                              },
                              employeeId: widget.employeeId,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff50B5E5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Upload Sign',
                          style: BlueButtonTextConst.customTextStyle(context)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 250),
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: ColorManager.blueprime,
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            Text(
                              'I agree to the terms & conditions',
                              style: onlyFormDataStyle.customTextStyle(context),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _isChecked
                                ? () async {
                                    ApiData updateOfferFuture =
                                        await updateOfferLetter(
                                      context,
                                      offerId,
                                      1,
                                      widget.employeeId,
                                      "2023-01-01",
                                      "2023-12-31",
                                      "2024-01-01",
                                      "2023-11-01",
                                      true,
                                      "2023-11-05",
                                    );
                                    if (updateOfferFuture.statusCode == 200 ||
                                        updateOfferFuture.statusCode == 201) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmationPopup(
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirm: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiStepForm(
                                                          employeeID: widget
                                                              .employeeId),
                                                ),
                                              );
                                            },
                                            title: 'Offer Letter',
                                            containerText:
                                                'Offer Accepted Successfully',
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmationPopup(
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirm: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiStepForm(
                                                          employeeID: widget
                                                              .employeeId),
                                                ),
                                              );
                                            },
                                            title: 'Offer Letter',
                                            containerText:
                                                'Offer Already Accepted',
                                          );
                                        },
                                      );
                                    }
                                  }
                                : null, // Disable the button if checkbox is not checked
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              ///
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => MultiStepForm()),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xff50B5E5),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 32, vertical: 16),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         minimumSize: Size(128, 44),
              //       ),
              //       child: Text(
              //         'Continue',
              //         style: GoogleFonts.firaSans(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500,
              //             color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ]),
      ),
      bottomNavigationBar: BottomBarRow(),
    );
  }
}

class ConfirmationPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final bool? loadingDuration;
  final String title;
  final String containerText;

  const ConfirmationPopup({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    this.loadingDuration,
    required this.title,
    required this.containerText,
  });

  @override
  State<ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s350,
        height: AppSize.s181,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      widget.title,
                      style: PopupBlueBarText.customTextStyle(context),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15),
              child: Row(
                children: [
                  Text(
                    widget.containerText,
                    textAlign: TextAlign.center,
                    style: ConstTextFieldRegister.customTextStyle(context),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: ColorManager.bluebottom,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style:
                            TransparentButtonTextConst.customTextStyle(context),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppPadding.p20),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppPadding.p24, right: AppPadding.p10),
                  child: Center(
                    child: widget.loadingDuration == true
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ),
                          )
                        : CustomElevatedButton(
                            width: AppSize.s105,
                            height: AppSize.s30,
                            text: 'Confirm',
                            onPressed: () {
                              // Execute the confirm action and navigate
                              widget.onConfirm();
                            },
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
