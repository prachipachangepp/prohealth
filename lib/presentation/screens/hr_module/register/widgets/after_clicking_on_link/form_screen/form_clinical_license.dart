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
import '../../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/form_health_record_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHREmployeeDoc(
      context,
      AppConfig.empdocumentTypeMetaDataId,
      1,
      20,
    ).then((data) {
      healthrecord.add(data);
    }).catchError((error) {});
  }

  List<String> _fileNames = [];
  List<int> docSetupId = [];
  bool _loading = false;
  bool isLoading = false;
  ////////////////////////////////////

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
  var finalPath;
  // PlatformFile? fileName;

  Future<WebFile> saveFileFromBytes(dynamic bytes, String fileName) async {
    // Get the directory to save the file.
    final blob = html.Blob(bytes);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create the file.
    //final anchor = html.AnchorElement(href: url)..setAttribute("download", fileName)..click();
    final file = html.File([blob], fileName);
    // Write the bytes to the file.
    print(file.toString());
    return WebFile(file, url);
  }

  Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
    // Create a Blob from the bytes
    final blob = html.Blob([bytes]);

    // Create an object URL from the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a File from the Blob
    final file = html.File([blob], fileName);

    print("XFILE ${url}");

    // Return the XFile created from the object URL
    return XFile(url);
  }

  Future<Uint8List> loadFileBytes() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/somefile.txt');
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      throw Exception('File not found');
    }
  }

  List<Uint8List?> finalPaths = [];

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
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          SingleChildScrollView(
            child: Container(
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
                          border: Border.all(
                              color: const Color(
                                  0xffB1B1B1)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            ' Expiry Date',
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
                                                            type:
                                                                FileType.custom,
                                                            allowedExtensions: [
                                                              'pdf'
                                                            ],
                                                          );
                                                          if (result != null) {
                                                            try {
                                                              Uint8List? bytes =
                                                                  result
                                                                      .files
                                                                      .first
                                                                      .bytes;
                                                              if (bytes !=
                                                                  null) {
                                                                // setState(() {
                                                                // // Update the file name and file bytes in respective lists
                                                                // if (_fileNames.length <= index) {
                                                                // _fileNames.add(result.files.first.name);
                                                                // } else {
                                                                // _fileNames[index] = result.files.first.name;
                                                                // }
                                                                //
                                                                // if (finalPaths.length <= index) {
                                                                // finalPaths.add(bytes);
                                                                // } else {
                                                                // finalPaths[index] = bytes;
                                                                // }
                                                                // });
                                                              }
                                                            } catch (e) {
                                                              print(e);
                                                            }
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
                                                        : (fileName != null &&
                                                                fileName
                                                                    .isNotEmpty)
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  '$fileName',
                                                                  style: onlyFormDataStyle
                                                                      .customTextStyle(
                                                                          context),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
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
                          border: Border.all(
                              color: const Color(
                                  0xffB1B1B1)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Practioner License',
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
                                            '  Expiry Date',
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
                                                        onPressed: () async {},
                                                        // {
                                                        // FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                        // type: FileType.custom,
                                                        // allowedExtensions: ['pdf'],
                                                        // );
                                                        // if (result != null) {
                                                        // try {
                                                        // Uint8List? bytes = result.files.first.bytes;
                                                        // if (bytes != null) {
                                                        // setState(() {
                                                        // // Update the file name and file bytes in respective lists
                                                        // if (_fileNames.length <= index) {
                                                        // _fileNames.add(result.files.first.name);
                                                        // } else {
                                                        // _fileNames[index] = result.files.first.name;
                                                        // }
                                                        //
                                                        // if (finalPaths.length <= index) {
                                                        // finalPaths.add(bytes);
                                                        // } else {
                                                        // finalPaths[index] = bytes;
                                                        // }
                                                        // });
                                                        // }
                                                        // } catch (e) {
                                                        // print(e);
                                                        // }
                                                        // }
                                                        // },
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
                                                        : (fileName != null &&
                                                                fileName
                                                                    .isNotEmpty)
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  '$fileName',
                                                                  style: onlyFormDataStyle
                                                                      .customTextStyle(
                                                                          context),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
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
                )
                // StreamBuilder<List<HREmployeeDocumentModal>>(
                //   stream: healthrecord.stream,
                //   // builder: getHREmployeeDoc(
                //   //     context, AppConfig.empdocumentTypeMetaDataId, 1, 20),
                //
                //
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else if (snapshot.hasError) {
                //       return Text("Error :${snapshot.error}");
                //     } else {
                //       List<HREmployeeDocumentModal> documents = snapshot.data!;
                //
                //       // Ensure _fileNames is at least as long as documents
                //       if (_fileNames.length < documents.length) {
                //         _fileNames.addAll(List.generate(
                //           documents.length - _fileNames.length,
                //               (index) => '', // Or any default value
                //         ));
                //       }
                //
                //       if (finalPaths.length < documents.length) {
                //         finalPaths.addAll(
                //           List.generate(documents.length - finalPaths.length, (_) => null),
                //         );
                //       }
                //       return
                //         ListView.builder(
                //      itemCount: documents.length,
                //         //itemCount: 2,
                //         itemBuilder: (context, index) {
                //           final document = documents[index];
                //           final fileName =
                //           _fileNames.isNotEmpty && index < _fileNames.length
                //               ? _fileNames[index]
                //               : null;
                //           // Assign or retrieve the docSetupId dynamically here
                //           int setupId = document.employeeDocTypesetupId; // Assuming 'setupId' is a property of the document
                //           print("Document");
                //
                //           // If you need to create your own logic, you could do something like:
                //           // int setupId = index + 1; // Just an example: setupId starts at 1 for the first item
                //
                //           if (docSetupId.length <= index) {
                //             docSetupId.add(setupId);
                //             print('Document ${docSetupId}');
                //           } else {
                //             docSetupId[index] = setupId;
                //           }
                //           return Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 150, vertical: 10),
                //             child: Container(
                //               height: 120,
                //               decoration: BoxDecoration(
                //                 color: ColorManager.white,
                //                 borderRadius: BorderRadius.circular(4),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: ColorManager.grey.withOpacity(0.5),
                //                     spreadRadius: 1,
                //                     blurRadius: 4,
                //                     offset: Offset(0, 2),
                //                   ),
                //                 ],
                //               ),
                //               child: Padding(
                //                 padding:  EdgeInsets.all(15),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                  // crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Column(
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Text(
                //                               'Practioner License',
                //                              // document.docName,
                //                               style: AllPopupHeadings.customTextStyle(context),
                //                             ),
                //                           ],
                //                         ),
                //                        // SizedBox(height: 8),
                //                         Row(
                //                           children: [
                //                             Column(
                //                               crossAxisAlignment: CrossAxisAlignment.start,
                //                               children: [
                //                                 Text(
                //                                   'Expiry Date',
                //                                   style: onlyFormDataStyle.customTextStyle(context),
                //                                 ),
                //                                 SizedBox(
                //                                   height: 4,
                //                                 ),
                //                                 CustomTextFieldRegister(
                //                                   width: 200,
                //                                   controller: expirydatecontroller,
                //                                   hintText: 'yyyy-mm-dd',
                //                                   hintStyle: onlyFormDataStyle.customTextStyle(context),
                //                                   height: 30,
                //                                   suffixIcon: IconButton(
                //                                     icon: Icon(
                //                                       Icons.calendar_month_outlined,
                //                                       color: Color(0xff50B5E5),
                //                                       size: 16,
                //                                     ),
                //                                     onPressed: () async {
                //                                       DateTime? pickedDate =
                //                                       await showDatePicker(
                //                                         context: context,
                //                                         initialDate: DateTime.now(),
                //                                         firstDate: DateTime(2000),
                //                                         lastDate: DateTime(2101),
                //                                       );
                //                                       if (pickedDate != null) {
                //                                         expirydatecontroller.text =
                //                                         "${pickedDate.toLocal()}"
                //                                             .split(' ')[0];
                //                                       }
                //                                     },
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                     // SizedBox(width: 20),
                //                     Column(
                //                       crossAxisAlignment: CrossAxisAlignment.end,
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Text(
                //                               'Upload Immunization records in pdf, jpg or png  format',
                //                               style:  onlyFormDataStyle.customTextStyle(context),
                //                             ),
                //                             Padding(
                //                               padding: const EdgeInsets.all(8),
                //                               child: Container(
                //                                // color: Colors.pink,
                //                                 child: Row(
                //                                   children: [
                //                                     Container(
                //                                       decoration: BoxDecoration(
                //                                         border: Border.all(color: const Color(0xffB1B1B1)),
                //                                         borderRadius: BorderRadius.circular(8),
                //                                       ),
                //                                       child: Row(
                //                                         children: [
                //                                           Padding(
                //                                             padding: const EdgeInsets.all(8.0),
                //                                             child: ElevatedButton(
                //                                               onPressed: () async {
                //                                                 FilePickerResult? result = await FilePicker.platform.pickFiles(
                //                                                   type: FileType.custom,
                //                                                   allowedExtensions: ['pdf'],
                //                                                 );
                //                                                 if (result != null) {
                //                                                   try {
                //                                                     Uint8List? bytes = result.files.first.bytes;
                //                                                     if (bytes != null) {
                //                                                       setState(() {
                //                                                         // Update the file name and file bytes in respective lists
                //                                                         if (_fileNames.length <= index) {
                //                                                           _fileNames.add(result.files.first.name);
                //                                                         } else {
                //                                                           _fileNames[index] = result.files.first.name;
                //                                                         }
                //
                //                                                         if (finalPaths.length <= index) {
                //                                                           finalPaths.add(bytes);
                //                                                         } else {
                //                                                           finalPaths[index] = bytes;
                //                                                         }
                //                                                       });
                //                                                     }
                //                                                   } catch (e) {
                //                                                     print(e);
                //                                                   }
                //                                                 }
                //                                               },
                //                                               child: Text(
                //                                                 "Choose File",
                //                                                 style: onlyFormDataStyle.customTextStyle(context),
                //                                               ),
                //                                               style: ElevatedButton.styleFrom(
                //                                                 backgroundColor: Color(0xffD9D9D9),
                //                                                 shape: RoundedRectangleBorder(
                //                                                   borderRadius: BorderRadius.circular(8.0),
                //                                                 ),
                //                                               ),
                //                                             ),
                //                                           ),
                //                                           // If a file is picked, display the file name, otherwise show 'No file selected'
                //                                           _loading
                //                                               ? SizedBox(
                //                                             width: 25,
                //                                             height: 25,
                //                                             child: CircularProgressIndicator(
                //                                               color: ColorManager.blueprime,
                //                                             ),
                //                                           )
                //                                               : (fileName != null && fileName.isNotEmpty)
                //                                               ? Padding(
                //                                             padding: const EdgeInsets.all(8.0),
                //                                             child: Text(
                //                                               '$fileName',
                //                                               style: onlyFormDataStyle.customTextStyle(context),
                //                                             ),
                //                                           )
                //                                               : Padding(
                //                                             padding: const EdgeInsets.all(8.0),
                //                                             child: Text(
                //                                               'No file chosen',
                //                                               style: onlyFormDataStyle.customTextStyle(context),
                //                                             ),
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                             )
                //
                //
                //                           ],
                //                         ),
                //
                //
                //
                //
                //
                //
                //
                //                       ],
                //                     )
                //
                //
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     }
                //   },
                // ),
                ),
          ),
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
                        await widget.onSave();
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
