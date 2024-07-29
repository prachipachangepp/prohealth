import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/approve_reject_dialog_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../manage/const_wrap_widget.dart';

///saloni
class AcknowledgementTab extends StatefulWidget {
  const AcknowledgementTab({Key? key}) : super(key: key);

  @override
  State<AcknowledgementTab> createState() => _AcknowledgementTabState();
}

class _AcknowledgementTabState extends State<AcknowledgementTab> {
  final StreamController<List<OnboardingAckHealthData>> _controller =
      StreamController<List<OnboardingAckHealthData>>();
  List<OnboardingAckHealthData> _fetchedData = [];
  List<bool> _checked = [];
  List<int> _selectedDocumentIds = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      var data = await getAckHealthRecord(context, 12, 37, 36);
      _fetchedData = data;
      _controller.add(data);
      _checked = List.generate(data.length, (_) => false);
    } catch (error) {
      _controller.addError(error);
    }
  }

  void _handleCheckboxChanged(bool? value, int index, int employeeDocumentId) {
    setState(() {
      _checked[index] = value!;
      if (value) {
        _selectedDocumentIds.add(employeeDocumentId);
      } else {
        _selectedDocumentIds.remove(employeeDocumentId);
      }
    });
  }

  void _handleRejectSelected() {
    if (_selectedDocumentIds.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RejectConfirmPopup(onCancel: () {
          Navigator.pop(context);
        }, onReject: () {
          _rejectSelectedDocuments();
          Navigator.pop(context);
        });
      },
    );
  }

  Future<void> _rejectSelectedDocuments() async {
    var result =
        await batchRejectOnboardAckHealthPatch(context, _selectedDocumentIds);
    if (result.success) {
      await _fetchData();
      setState(() {
        _selectedDocumentIds.clear();
      });
    } else {
      // Handle error
      print(result.message);
    }
  }

  void _handleApproveSelected() {
    if (_selectedDocumentIds.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ApproveConfirmPopup(onCancel: () {
          Navigator.pop(context);
        }, onApprove: () {
          _approveSelectedDocuments();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Future<void> _approveSelectedDocuments() async {
    var result =
        await batchApproveOnboardAckHealthPatch(context, _selectedDocumentIds);
    if (result.success) {
      await _fetchData();
      setState(() {
        for (var id in _selectedDocumentIds) {
          int index =
              _fetchedData.indexWhere((data) => data.employeeDocumentId == id);
          if (index != -1) {
            _checked[index] = false;
          }
        }
        _selectedDocumentIds.clear();
      });
    } else {
      // Handle error
      print(result.message);
    }
  }
/////////////
  //////////////prajwal
  //
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OnboardingAckHealthData>>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.blueprime,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              AppString.dataNotFound,
              style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 150),
          child: Column(
            children: [
              Wrap(
                  children: [
                  ...List.generate(snapshot.data!.length, (index) {
                    final data = snapshot.data![index];
                    final fileUrl = data.DocumentUrl;
                    final fileExtension =
                        fileUrl.split('.').last.toLowerCase();

                    Widget fileWidget;

                    if (['jpg', 'jpeg', 'png', 'gif']
                        .contains(fileExtension)) {
                      fileWidget = Image.network(
                        fileUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            size: 25,
                            color: ColorManager.blueprime,
                          );
                        },
                      );
                    } else if (['pdf', 'doc', 'docx']
                        .contains(fileExtension)) {
                      fileWidget = Icon(
                        Icons.insert_drive_file,
                        size: 25,
                        color: ColorManager.blueprime,
                      );
                    } else {
                      fileWidget = Icon(
                        Icons.file_present,
                        size: 25,
                        color: ColorManager.blueprime,
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                           // color: Colors.blue,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _checked[index],
                                  onChanged: (value) {
                                    _handleCheckboxChanged(
                                        value,
                                        index,
                                        snapshot
                                            .data![index].employeeDocumentId);
                                  },
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => downloadFile(fileUrl),
                                  child: Container(
                                    width: 62,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorManager.faintGrey),
                                    ),
                                    child: fileWidget,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    data.DocumentName,
                                    style: AknowledgementStyleConst
                                        .customTextStyle(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _handleRejectSelected,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xff1696C8),
                        side: BorderSide(color: Color(0xff1696C8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 75),
                    ElevatedButton(
                      onPressed: _handleApproveSelected,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1696C8),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Approve',
                        style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0, right: 120),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return Dialog(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(12.0),
              //                 ),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(20.0),
              //                   ),
              //                   height: 181.0,
              //                   width: 500.0,
              //                   child: Stack(
              //                     children: <Widget>[
              //                       Container(
              //                         decoration: BoxDecoration(
              //                           color: ColorManager.bluebottom,
              //                           borderRadius: BorderRadius.only(
              //                             topLeft: Radius.circular(8),
              //                             topRight: Radius.circular(8),
              //                           ),
              //                         ),
              //                         height: 35,
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.only(
              //                                   left: 10.0),
              //                               child: Text(
              //                                 'Reject',
              //                                 style: GoogleFonts.firaSans(
              //                                   fontSize: FontSize.s12,
              //                                   fontWeight:
              //                                       FontWeightManager.semiBold,
              //                                   color: ColorManager.white,
              //                                   decoration: TextDecoration.none,
              //                                 ),
              //                               ),
              //                             ),
              //                             IconButton(
              //                               onPressed: () {
              //                                 Navigator.pop(context);
              //                               },
              //                               icon: Icon(Icons.close,
              //                                   color: ColorManager.white),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       Align(
              //                         alignment: Alignment.centerLeft,
              //                         child: Padding(
              //                           padding:
              //                               const EdgeInsets.only(left: 20.0),
              //                           child: Text(
              //                             "Do you really want to,reject this?",
              //                             textAlign: TextAlign.center,
              //                             style: GoogleFonts.firaSans(
              //                               fontSize: 14,
              //                               fontWeight:
              //                                   FontWeightManager.regular,
              //                               color: ColorManager.mediumgrey,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       Padding(
              //                         padding: const EdgeInsets.only(
              //                             bottom: AppPadding.p24,
              //                             right: AppPadding.p10),
              //                         child: Align(
              //                           alignment: Alignment.bottomRight,
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.end,
              //                             children: [
              //                               ElevatedButton(
              //                                 onPressed: () {
              //                                   Navigator.of(context).pop();
              //                                 },
              //                                 style: ElevatedButton.styleFrom(
              //                                   elevation: 5,
              //                                   backgroundColor: Colors.white,
              //                                   foregroundColor:
              //                                       Color(0xff1696C8),
              //                                   side: BorderSide(
              //                                       color: Color(0xff1696C8)),
              //                                   shape: RoundedRectangleBorder(
              //                                     borderRadius:
              //                                         BorderRadius.circular(8),
              //                                   ),
              //                                 ),
              //                                 child: Text(
              //                                   'Cancel',
              //                                   style: GoogleFonts.firaSans(
              //                                     fontSize: 10.0,
              //                                     fontWeight: FontWeight.w700,
              //                                   ),
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                   width: MediaQuery.of(context)
              //                                           .size
              //                                           .width /
              //                                       75),
              //                               ElevatedButton(
              //                                 onPressed: () async {
              //                                   await _handleRejectSelected;
              //                                   Navigator.of(context).pop();
              //                                 },
              //                                 style: ElevatedButton.styleFrom(
              //                                   backgroundColor:
              //                                       Color(0xff1696C8),
              //                                   foregroundColor: Colors.white,
              //                                   shape: RoundedRectangleBorder(
              //                                     borderRadius:
              //                                         BorderRadius.circular(8),
              //                                   ),
              //                                 ),
              //                                 child: Text(
              //                                   'Yes',
              //                                   style: GoogleFonts.firaSans(
              //                                     fontSize: 10.0,
              //                                     fontWeight: FontWeight.w700,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         }, //_handleRejectSelected,
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.white,
              //           foregroundColor: Color(0xff1696C8),
              //           side: BorderSide(color: Color(0xff1696C8)),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         child: Text(
              //           'Reject',
              //           style: GoogleFonts.firaSans(
              //             fontSize: 10.0,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: MediaQuery.of(context).size.width / 75),
              //       ElevatedButton(
              //         onPressed: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return Dialog(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(12.0),
              //                 ),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(20.0),
              //                   ),
              //                   height: 181.0,
              //                   width: 500.0,
              //                   child: Stack(
              //                     children: <Widget>[
              //                       Container(
              //                         decoration: BoxDecoration(
              //                           color: ColorManager.bluebottom,
              //                           borderRadius: BorderRadius.only(
              //                             topLeft: Radius.circular(8),
              //                             topRight: Radius.circular(8),
              //                           ),
              //                         ),
              //                         height: 35,
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.only(
              //                                   left: 20.0),
              //                               child: Text(
              //                                 'Approve',
              //                                 style: GoogleFonts.firaSans(
              //                                   fontSize: FontSize.s12,
              //                                   fontWeight:
              //                                       FontWeightManager.semiBold,
              //                                   color: ColorManager.white,
              //                                   decoration: TextDecoration.none,
              //                                 ),
              //                               ),
              //                             ),
              //                             IconButton(
              //                               onPressed: () {
              //                                 Navigator.pop(context);
              //                               },
              //                               icon: Icon(Icons.close,
              //                                   color: ColorManager.white),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       Align(
              //                         alignment: Alignment.centerLeft,
              //                         child: Padding(
              //                           padding:
              //                               const EdgeInsets.only(left: 20.0),
              //                           child: Text(
              //                             "Do you really want to,approve this?",
              //                             textAlign: TextAlign.center,
              //                             style: GoogleFonts.firaSans(
              //                               fontSize: 14,
              //                               fontWeight:
              //                                   FontWeightManager.regular,
              //                               color: ColorManager.mediumgrey,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       Padding(
              //                         padding: const EdgeInsets.only(
              //                             bottom: AppPadding.p24,
              //                             right: AppPadding.p10),
              //                         child: Align(
              //                           alignment: Alignment.bottomRight,
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.end,
              //                             children: [
              //                               ElevatedButton(
              //                                 onPressed: () {
              //                                   Navigator.of(context).pop();
              //                                 },
              //                                 style: ElevatedButton.styleFrom(
              //                                   elevation: 5,
              //                                   backgroundColor: Colors.white,
              //                                   foregroundColor:
              //                                       Color(0xff1696C8),
              //                                   side: BorderSide(
              //                                       color: Color(0xff1696C8)),
              //                                   shape: RoundedRectangleBorder(
              //                                     borderRadius:
              //                                         BorderRadius.circular(8),
              //                                   ),
              //                                 ),
              //                                 child: Text(
              //                                   'Cancel',
              //                                   style: GoogleFonts.firaSans(
              //                                     fontSize: 10.0,
              //                                     fontWeight: FontWeight.w700,
              //                                   ),
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                   width: MediaQuery.of(context)
              //                                           .size
              //                                           .width /
              //                                       75),
              //                               ElevatedButton(
              //                                 onPressed: () async {
              //                                   await _handleApproveSelected;
              //                                   Navigator.of(context).pop();
              //                                 },
              //                                 style: ElevatedButton.styleFrom(
              //                                   backgroundColor:
              //                                       Color(0xff1696C8),
              //                                   foregroundColor: Colors.white,
              //                                   shape: RoundedRectangleBorder(
              //                                     borderRadius:
              //                                         BorderRadius.circular(8),
              //                                   ),
              //                                 ),
              //                                 child: Text(
              //                                   'Yes',
              //                                   style: GoogleFonts.firaSans(
              //                                     fontSize: 10.0,
              //                                     fontWeight: FontWeight.w700,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         }, //_handleApproveSelected,
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Color(0xff1696C8),
              //           foregroundColor: Colors.white,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         child: Text(
              //           'Approve',
              //           style: GoogleFonts.firaSans(
              //             fontSize: 10.0,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  ///////////////////////
  /////////////////
  ///////////
  ///
  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder<List<OnboardingAckHealthData>>(
  //     stream: _controller.stream,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: ColorManager.blueprime,
  //           ),
  //         );
  //       }
  //       if (snapshot.hasError) {
  //         return Center(
  //           child: Text(
  //             'Error: ${snapshot.error}',
  //             style: TextStyle(color: Colors.red),
  //           ),
  //         );
  //       }
  //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //         return Center(
  //           child: Text(
  //             AppString.dataNotFound,
  //             style: CustomTextStylesCommon.commonStyle(
  //               fontWeight: FontWeightManager.medium,
  //               fontSize: FontSize.s12,
  //               color: ColorManager.mediumgrey,
  //             ),
  //           ),
  //         );
  //       }
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 15),
  //         child: Column(
  //           children: [
  //             Container(
  //              // color: pink,
  //               height: 500,//MediaQuery.of(context).size.height / 2,
  //               padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
  //               decoration: BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.25),
  //                     spreadRadius: 1,
  //                     blurRadius: 4,
  //                     offset: Offset(0, 5),
  //                   ),
  //                 ],
  //                 color: Colors.blueGrey,
  //                 borderRadius: BorderRadius.all(Radius.circular(12)),
  //               ),
  //               child: WrapWidget(
  //                 childern: [
  //                   ...List.generate(snapshot.data!.length, (index) {
  //                     final data = snapshot.data![index];
  //                     final fileUrl = data.DocumentUrl;
  //                     final fileExtension = fileUrl.split('.').last.toLowerCase();
  //
  //                     Widget fileWidget;
  //
  //                     if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
  //                       fileWidget = Image.network(
  //                         fileUrl,
  //                         fit: BoxFit.cover,
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return Icon(
  //                             Icons.image,
  //                             size: 25,
  //                             color: ColorManager.blueprime,
  //                           );
  //                         },
  //                       );
  //                     } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
  //                       fileWidget = Icon(
  //                         Icons.insert_drive_file,
  //                         size: 25,
  //                         color: ColorManager.blueprime,
  //                       );
  //                     } else {
  //                       fileWidget = Icon(
  //                         Icons.file_present,
  //                         size: 25,
  //                         color: ColorManager.blueprime,
  //                       );
  //                     }
  //
  //                     return Column(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 40),
  //                           child: Container(
  //                             ////////
  //                             color:Colors.blue,
  //                             width: MediaQuery.of(context).size.width / 3,
  //                             child: Row(
  //                               children: [
  //                                 Checkbox(
  //                                   value: _checked[index],
  //                                   onChanged: (value) {
  //                                     _handleCheckboxChanged(value, index, snapshot.data![index].employeeDocumentId);
  //                                   },
  //                                 ),
  //                                 SizedBox(width: 10),
  //                                 GestureDetector(
  //                                   onTap: () => downloadFile(fileUrl),
  //                                   child: Container(
  //                                     width: 62,
  //                                     height: 45,
  //                                     decoration: BoxDecoration(
  //                                       borderRadius: BorderRadius.circular(4),
  //                                       border: Border.all(width: 2, color: ColorManager.faintGrey),
  //                                     ),
  //                                     child: fileWidget,
  //                                   ),
  //                                 ),
  //                                 SizedBox(width: 10),
  //                                 Expanded(
  //                                   child: Text(
  //                                     data.DocumentName,
  //                                     style: AknowledgementStyleConst.customTextStyle(context),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(height: 10),
  //                       ],
  //                     );
  //                   }),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 20.0, right: 120),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: _handleRejectSelected,
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.white,
  //                       foregroundColor: Color(0xff1696C8),
  //                       side: BorderSide(color: Color(0xff1696C8)),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                     child: Text(
  //                       'Reject',
  //                       style: GoogleFonts.firaSans(
  //                         fontSize: 10.0,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: MediaQuery.of(context).size.width / 75),
  //                   ElevatedButton(
  //                     onPressed: _handleApproveSelected,
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Color(0xff1696C8),
  //                       foregroundColor: Colors.white,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                     child: Text(
  //                       'Approve',
  //                       style: GoogleFonts.firaSans(
  //                         fontSize: 10.0,
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
          //  ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
