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
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../app/services/token/token_manager.dart';
import '../../../../../../data/api_data/api_data.dart';
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
  bool _isChecked = false;
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
      _isChecked = false;
    });
  }

  void _onSignatureSelected(Uint8List? image) {
    setState(() {
      _webImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Offer Letter',
                  style: FormHeading.customTextStyle(context)
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            FutureBuilder<OfferLetterData>(
              future:GetOfferLetter(context, widget.employeeId, 1 ),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Container(width: 1032,
                    height: 1190,);
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
              padding: const EdgeInsets.only(left: 180.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 200,
                    // color: Colors.yellow,
                    child: signatureBytes != null
                        ? Image.memory(signatureBytes!)
                        : Text(''),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 230.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.height / 6,
                    child:Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignaturePage(
                                onSignatureSelected: (Uint8List? selectedSignature) {
                                  setState(() {
                                    signatureBytes = selectedSignature;
                                  });
                                }, employeeId: widget.employeeId,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff1696C8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Upload Sign',
                          style: BlueButtonTextConst.customTextStyle(context)
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: ColorManager.blueprime,
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        'I agree to the terms & conditions',
                        style:onlyFormDataStyle.customTextStyle(context)
                      ),
                    ],
                  ),
                ],
              ),
            ),
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{
                      ApiData updateOfferFuture = await updateOfferLetter(
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
                      if(updateOfferFuture.statusCode == 200 || updateOfferFuture.statusCode == 201){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Offer Accepted Succefully', style: TextStyle(
                                color: ColorManager.primary, fontSize: 12, fontWeight: FontWeight.w600
                            ),),
                            content: Text( ""
                              // snapshot.data!.message
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  //String userid= await TokenManager.getUserID();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MultiStepForm(employeeID: widget.employeeId,)),
                                  );
                                },
                                child: Text('OK', style: TextStyle(
                                    color: ColorManager.black, fontSize: 12, fontWeight: FontWeight.w600
                                ),),
                              ),
                            ],
                          );
                        });
                      }else{
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Offer Already Accepted', style: TextStyle(
                                color: ColorManager.primary, fontSize: 12, fontWeight: FontWeight.w600
                            ),),
                            content: Text( ""
                              // snapshot.data!.message
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  //String userid= await TokenManager.getUserID();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MultiStepForm(employeeID: widget.employeeId,)),
                                  );
                                },
                                child: Text('OK', style:TextStyle(
                                    color: ColorManager.black, fontSize: 12, fontWeight: FontWeight.w600
                                ),),
                              ),
                            ],
                          );
                        });
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff50B5E5),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(128, 44),
                  ),
                  child: Text(
                    'Continue',
                    style:BlueButtonTextConst.customTextStyle(context)
                  ),
                ),
              ],
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
      ),
      bottomNavigationBar: BottomBarRow(),
    );
  }
}
