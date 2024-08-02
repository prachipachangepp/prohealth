import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/offer_letter_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/offer_letter_html_data/offer_letter_html.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/signature_screen.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../data/api_data/api_data.dart';
import '../../../manage/widgets/bottom_row.dart';
import 'multi_step_form.dart';


class OfferLetterDescriptionScreen extends StatefulWidget {
  final Uint8List? signatureBytes;

  OfferLetterDescriptionScreen({this.signatureBytes});


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
  // PlatformFile? _selectedFile;
  // Uint8List? _webImage;
  // bool _isChecked = false;
  //
  // Future<void> _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     withData: kIsWeb, // for loading file on webb
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       _selectedFile = result.files.first;
  //       if (kIsWeb) {
  //         _webImage = _selectedFile!.bytes;
  //       }
  //       print("Selected file name: ${_selectedFile!.name}");
  //       print("Selected file size: ${_selectedFile!.size} bytes");
  //       if (!kIsWeb) {
  //         print("Selected file path: ${_selectedFile!.path}");
  //       }
  //     });
  //   } else {
  //     print("File picking cancelled or failed.");
  //   }
  // }

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
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xff50B5E5),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            FutureBuilder<OfferLetterData>(
              future:GetOfferLetter(context, 43, 1 ),
              builder: (context, snapshot) {
                // if(snapshot.connectionState == ConnectionState.waiting){
                //   return CircularProgressIndicator(color: Colors.blue,);
                // }
                if (snapshot.hasData) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.height / 6,
                    child: _webImage == null
                        ? Center(
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
                                }, employeeId: 1,
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
                          style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                        : Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(
                          _webImage!,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///
            // Padding(
            //   padding: const EdgeInsets.only(left: 230.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width / 10,
            //         height: MediaQuery.of(context).size.height / 6,
            //         child: _selectedFile == null
            //             ? Center(
            //                 child: ElevatedButton(
            //                   // onPressed: _pickFile,
            //                   onPressed: () {
            //                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignaturePage()));
            //                   },
            //                   style: ElevatedButton.styleFrom(
            //                     backgroundColor: Color(0xff1696C8),
            //                     foregroundColor: Colors.white,
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                     ),
            //                   ),
            //                   child: Text(
            //                     'Upload Sign',
            //                     style: GoogleFonts.firaSans(
            //                       fontSize: 10.0,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             : Stack(
            //                 fit: StackFit.expand,
            //                 children: [
            //                   if (kIsWeb && _webImage != null)
            //                     Image.memory(
            //                       _webImage!,
            //                       fit: BoxFit.contain,
            //                     )
            //                   else if (!kIsWeb && _selectedFile != null)
            //                     Image.file(
            //                       File(_selectedFile!.path!),
            //                       fit: BoxFit.contain,
            //                     ),
            //                 ],
            //               ),
            //       ),
            //     ],
            //   ),
            // ),
            if (_selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(left: 230.0),
                child: Column(
                  children: [
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
                          style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 230.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: _clearSelectedFile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff1696C8),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Clear Selected Image',
                              style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Future<ApiData> _updateOfferFuture = updateOfferLetter(
                        context,
                         1,
                         1,
                         43,
                        "2023-01-01",
                        "2023-12-31",
                        "2024-01-01",
                         "2023-11-01",
                         true,
                         "2023-11-05",
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder<ApiData>(
                            future: _updateOfferFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasData) {
                                if (snapshot.data!.success) {
                                  return AlertDialog(
                                    title: Text('Offer Accepted Succefully', style: GoogleFonts.firaSans(
                                      color: ColorManager.primary, fontSize: 12, fontWeight: FontWeight.w700
                                    ),),
                                    content: Text( ""
                                        // snapshot.data!.message
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => MultiStepForm()),
                                          );
                                        },
                                        child: Text('OK', style: GoogleFonts.firaSans(
                                            color: ColorManager.black, fontSize: 12, fontWeight: FontWeight.w700
                                        ),),
                                      ),
                                    ],
                                  );
                                } else {
                                  return AlertDialog(
                                    title: Text('Error', style: GoogleFonts.firaSans(
                                        color: ColorManager.primary, fontSize: 12, fontWeight: FontWeight.w700
                                    ),),
                                    content: Text(snapshot.data!.message),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                           Navigator.pop(context);

                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Something went wrong'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        },
                      );
                    });
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
                    style: GoogleFonts.firaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
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
//       """
//   <p>Dear Sameer V </p>
//
//   <p>ProHealth Home Care, Inc. (“ProHealth”) is a home health care provider under the management of industry veterans with experience in assisted living, home health care, DME, hospice, skilled nursing, rehab and hospital management. ProHealth offers a full spectrum of home health services ranging from nursing assistance with everyday needs to physical therapy, occupational therapy, and speech language pathology.</p>
//
//   <p>ProHealth believes that you have the skills and qualifications necessary and is pleased to offer you the position of ST. Your base salary will be \$800009.99 on an annualized basis, subject to deduction for taxes and other withholdings as required by law or policies of the company. You are required to complete 25 patient care visits per week for the above compensation covering</p>
//
//   <ul>
//     <li><strong>City:</strong></li>
//     <li><strong>Country:</strong></li>
//     <li><strong>Zone:</strong></li>
//     <li><strong>Cities: Antelope, RioLinda:</strong></li>
//   </ul>
//
//   <p>and reporting to the Director of Patient Care Services. Your anticipated start date will be 2024-05-22</p>
//
//   <br>
//   <p>This offer and your employment relationship will be subject to the terms and conditions of this letter. If you decide to join us, your compensation will be as follows: “per visit” compensation refers to a lump sum payment as payment for all activities in connection with a visit to the patient. It is a compensation not only for the time involved in direct patient care but for travel time, charting, and communication. This position is an exempt position, which means you are being paid by the job, not by the hour, with the patient's family, physician and other health care providers as well. Future adjustments in compensation, if any, will be made by ProHealth in its sole discretion; less applicable withholdings paid in accordance with ProHealth’s normal payroll practices. <br>On Call Timing ( Only in case on on Call) </p>
//
//   <br>
//   <ul>
//     <li>Monday 5:30 pm - Tuesday 9:00 am</li>
//     <li>Tuesday 5:30 pm - Wednesday 9:00 am</li>
//     <li>Wednesday 5:30 pm - Thursday 9:00 am</li>
//     <li>Thursday 5:30 pm - Friday 9:00 am</li>
//     <li>Friday 5:30 pm - Saturday 9:00 pm</li>
//     <li>Saturday 5:30 pm - Sunday 9:00 pm</li>
//     <li>Sunday 5:30 pm - Monday 9:00 pm</li>
//   </ul>
//
//   <p>On call will take calls directly from patients; calls are paid in 15 min increments. As a Part Time (visits 15-17 a week) employee, you will not be eligible for all fringe benefits available, including company-approved paid holidays, health insurance, 401K and paid vacation in accordance with ProHealth’s benefit plans. Nurses with an average caseload of 25 visits/week qualify for full time employment. If you meet these criteria consistently, your employment status will be converted to full time and will be eligible for benefits available to other full-time employees. <br>If you accept our offer, your employment with ProHealth will be “at-will”. This means your employment is not for any specific period of time and can be terminated by you at any time for any reason. Likewise, ProHealth may terminate the employment relationship at any time, with or without cause or advance notice. In addition, ProHealth reserves the right to modify your position or duties to meet business needs and to use discretion in deciding on appropriate discipline. Any change to the at-will employment relationship must be by a specific, written agreement signed by you and ProHealth’s President. <br>This offer is contingent upon the following:</p>
//
//   <ul>
//     <li>Compliance with federal I-9 requirements (please bring suitable documentation with you on your first day of work verifying your identity and legal authorization to work in the United States); and</li>
//     <li>Mandatory Physical (within the last year). You may bring a note from your physician or you may get a physical from US Health Works prior to the Orientation Date</li>
//     <li>Mandatory TB (within the last year) OR Chest X-ray (within the last 5 years). If you don’t have one, you may get a TB or Chest X-ray test from US Health Works prior to the Orientation Date</li>
//     <li>Mandatory Drug Screen from US Health Works prior to your Orientation Date</li>
//     <li>MMR immunization or titer showing immunity prior to your Orientation Date</li>
//     <li>Varicella immunization or titer showing immunity prior to your Orientation Date</li>
//     <li>Verification of the information contained in your employment application and resume, including satisfactory references.</li>
//   </ul>
//
//   <br>
//   <p>As a necessary and material condition of employment by ProHealth, in the event that any issue between you and ProHealth or any of its employees, agents, officers, directors or affiliates, which relates to your employment with ProHealth, including, but not limited to any claims of discrimination, harassment, retaliation, statutory claims, tort claims or contract claims, must be resolved exclusively through binding arbitration. This means that you will give up significant rights, including but not limited to, the right to a jury trial. You understand that a written request for arbitration must be made to the other party within the time limits which would apply to the filing of a civil complaint in court or the complaining party will waive their right to pursue any claim. You acknowledge that by accepting employment and signing this Agreement, you and ProHealth are knowingly and voluntarily waiving the right to pursue such claims in court and instead will pursue them in arbitration. You agree that any such arbitration will be conducted using a mutually agreed upon arbitrator, that ProHealth will pay for the unique costs of arbitration, including the arbitrator’s fee, and that reasonable discovery will be available to each side. The parties agree that any remedies that would have been available in a Civil Action are available to the parties in arbitration under this agreement as determined by the arbitrator. The parties agree that the arbitrator will provide a written decision that will be subject to judicial review. If you file a complaint, which is subject to arbitration with a court, you will have to reimburse ProHealth’s costs and attorneys’ fees associated with compelling arbitration of the complaint. If any court of competent jurisdiction finds any part of this Arbitration Clause to be illegal, invalid or unenforceable, such a finding will not affect the legality, validity or enforceability of the remaining parts of the Agreement, and the illegal, invalid or unenforceable part will be stricken from the Agreement. <br>This offer letter of employment is contingent upon you agreeing to submit to and satisfactorily pass a background screening conducted by a licensed consumer reporting agency under the Fair Credit Reporting Act. This letter constitutes the entire agreement between you and ProHealth relating to this subject matter and supersedes all prior or contemporaneous agreements, understandings, negotiations or representations, whether oral or written, express or implied, on this subject. This letter may not be modified or amended except by a specific, written agreement signed by you and ProHealth’s President. <br>This offer will remain open until 2024-06-30. To indicate your acceptance of ProHealth’s offer on the terms and conditions set forth in this letter, please provide a written or We hope your employment with ProHealth will prove mutually rewarding, and we look forward to having you join us. If you have any questions, please feel free to call me at 408-451-9055.</p>
//
//   <br>
//   <p>Sincerely,
//   <br>Shivani Khare
//   <br>Director - Human Resources</p>
//
//   <br>
//   <p>The undersigned has read and understood the above-employment offer, including the at-will nature of employment and the obligation to submit any employment-related disputes to binding arbitration rather than a civil court. The undersigned understands and acknowledges that this offer supersedes all prior offers and discussions, and that there are no other terms expressed or implied other than those contained within this offer letter. The undersigned acknowledges that the employment offer is contingent upon verification of licensure, identity and employment eligibility, background check, and the pre-employment health examination and screening. By signing below, the undersigned accepts ProHealth’s offer of employment as stated herein.</p>
// """,
//BottomBarRow()
//SizedBox(height: MediaQuery.of(context).size.height/8),
// Row(
//   children: [
//     BottomBarRow()
//   ],
// )
// SizedBox(height: MediaQuery.of(context).size.height/100),