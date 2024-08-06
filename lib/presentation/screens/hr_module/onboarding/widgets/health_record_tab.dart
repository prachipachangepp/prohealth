import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import '../../manage/const_wrap_widget.dart';
import '../approve_reject_dialog_constant.dart';
import '../download_doc_const.dart';

class HealthRecordConstant extends StatefulWidget {
  final int employeeId;
  const HealthRecordConstant({super.key, required this.employeeId});

  @override
  State<HealthRecordConstant> createState() => _HealthRecordConstantState();
}

// class _HealthRecordConstantState extends State<HealthRecordConstant> {
//   final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
//   List<bool> _checked = [];
//   //List<bool> _checked = List.generate(snapshot.data!.length, (index) => false);
//
//
//   @override
//   void initState() {
//     super.initState();
//     getAckHealthRecord(context, 1, 10, 5,'no').then((data) {
//       _controller.add(data);
//       _checked = List.generate(data.length, (_) => false);
//     }).catchError((error) {
//       // Handle error
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     return StreamBuilder<List<OnboardingAckHealthData>>(
//       stream: _controller.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: ColorManager.blueprime,
//             ),
//           );
//         }
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: TextStyle(color: Colors.red),
//             ),
//           );
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(
//             child: Text(
//               AppString.dataNotFound,
//               style: CustomTextStylesCommon.commonStyle(
//                 fontWeight: FontWeightManager.medium,
//                 fontSize: FontSize.s12,
//                 color: ColorManager.mediumgrey,
//               ),
//             ),
//           );
//         }
//         ////
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//
//
//             Wrap(
//               children: [
//                 ...List.generate(snapshot.data!.length, (index) {
//                   final data = snapshot.data![index];
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         child: Container(
//                           width: mediaQuery.width / 3,
//                           child: Row(
//                             children: [
//                               Checkbox(
//                                 value: _checked[index],
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     _checked[index] = value!;
//                                   });
//                                 },
//                               ),
//                               SizedBox(width: mediaQuery.width / 140),
//                               GestureDetector(
//                                 onTap: () => downloadFile(data.DocumentUrl),
//                                 child: Container(
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     border: Border.all(color: Color(0xffC6C6C6)),
//                                   ),
//                                   child: HealthRecordConstantWithContainer(
//                                     data.DocumentName,
//                                     data.ReminderThreshold,
//                                     Icons.description_outlined,
//                                     Color(0xff50B5E5),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               ],
//             ),
//
//             const SizedBox(height: 10,),
//             Padding(
//               padding:const EdgeInsets.only( right: 120),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   /// Reject
//                   ElevatedButton(
//                     onPressed: () => showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             height: AppSize.s181,
//                             width: AppSize.s500,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: ColorManager.bluebottom,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(8),
//                                       topRight: Radius.circular(8),
//                                     ),
//                                   ),
//                                   height: 35,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 10.0),
//                                         child: Text(
//                                           'Reject',
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.semiBold,
//                                             color: ColorManager.white,
//                                             decoration: TextDecoration.none,
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         icon: Icon(Icons.close, color: ColorManager.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: AppSize.s20),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: AppPadding.p20,
//                                     horizontal: AppPadding.p20,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         "Do you really want to reject this?",
//                                         style: GoogleFonts.firaSans(
//                                           fontSize: 14,
//                                           fontWeight: FontWeightManager.regular,
//                                           color: ColorManager.mediumgrey,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: AppPadding.p20, right: AppPadding.p20),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       SizedBox(
//                                         width: 100,
//                                         child: ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.white,
//                                             foregroundColor: Color(0xff1696C8),
//                                             side: BorderSide(color: Color(0xff1696C8)),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Cancel',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: MediaQuery.of(context).size.width / 75),
//                                       SizedBox(
//                                         width: 100,
//                                         child: ElevatedButton(
//                                           onPressed: () {},
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Color(0xff1696C8),
//                                             foregroundColor: Colors.white,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Yes',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//
//                       },
//                     ),
//                     //_handleRejectSelected(snapshot.data!),
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
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: mediaQuery.width / 75),
//                   /// Approve
//                   ElevatedButton(
//                     onPressed: () => showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             height: AppSize.s181,
//                             width: AppSize.s500,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: ColorManager.bluebottom,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(8),
//                                       topRight: Radius.circular(8),
//                                     ),
//                                   ),
//                                   height: 35,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 10.0),
//                                         child: Text(
//                                           'Approve',
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.semiBold,
//                                             color: ColorManager.white,
//                                             decoration: TextDecoration.none,
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         icon: Icon(Icons.close, color: ColorManager.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: AppSize.s20),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: AppPadding.p20,
//                                     horizontal: AppPadding.p20,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         "Do you really want to approve this?",
//                                         style: GoogleFonts.firaSans(
//                                           fontSize: 14,
//                                           fontWeight: FontWeightManager.regular,
//                                           color: ColorManager.mediumgrey,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: AppPadding.p20, right: AppPadding.p20),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       SizedBox(
//                                         width: 100,
//                                         child: ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.white,
//                                             foregroundColor: Color(0xff1696C8),
//                                             side: BorderSide(color: Color(0xff1696C8)),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Cancel',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: MediaQuery.of(context).size.width / 75),
//                                       SizedBox(
//                                         width: 100,
//                                         child: ElevatedButton(
//                                           onPressed: () {},
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Color(0xff1696C8),
//                                             foregroundColor: Colors.white,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Yes',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//
//                       },
//                     ),
//                     //_handleApproveSelected(snapshot.data!),
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
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
// }
class _HealthRecordConstantState extends State<HealthRecordConstant> {
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
  List<bool> _checked = [];
  List<int> _selectedDocumentIds = [];
  List<OnboardingAckHealthData> _fetchedData = [];

  @override
  void initState() {
    super.initState();
   _fetchData();
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
    var result = await batchRejectOnboardAckHealthPatch(context, _selectedDocumentIds);
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

  Future<void> _fetchData() async {
    try {
      var data = await getAckHealthRecord(context, 1, 10, widget.employeeId, 'no');
      _fetchedData = data;
      _controller.add(data);
      _checked = List.generate(data.length, (_) => false);
    } catch (error) {
      _controller.addError(error);
    }
  }

  Future<void> _approveSelectedDocuments() async {
    var result = await batchApproveOnboardAckHealthPatch(context, _selectedDocumentIds);
    if (result.success) {
      await _fetchData();
      setState(() {
        for (var id in _selectedDocumentIds) {
          int index = _fetchedData.indexWhere((data) => data.employeeDocumentId == id);
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


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingAckHealthData>>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Text(
                  AppString.dataNotFound,
                  style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey),
                ),
              ));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Text(
                  AppString.dataNotFound,
                  style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey),
                ),
              ));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: List.generate(snapshot.data!.length, (index) {
                final data = snapshot.data![index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        width: mediaQuery.width / 3,
                        child: Row(
                          children: [
                            Checkbox(
                              value: _checked[index],
                              onChanged: (bool? value) {
                                _handleCheckboxChanged(value, index, data.employeeDocumentId);
                              },
                            ),
                            SizedBox(width: mediaQuery.width / 140),
                            GestureDetector(
                              onTap: () => downloadFile(data.DocumentUrl),
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Color(0xffC6C6C6)),
                                ),
                                child: HealthRecordConstantWithContainer(
                                  data.DocumentName,
                                  data.ReminderThreshold,
                                  Icons.description_outlined,
                                  Color(0xff50B5E5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 120),
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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: mediaQuery.width / 75),
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
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
