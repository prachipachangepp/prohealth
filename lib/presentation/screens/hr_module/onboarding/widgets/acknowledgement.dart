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
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
  List<bool> _checked = [];
  List<int> _selectedDocumentIds = [];

  @override
  void initState() {
    super.initState();
    getAckHealthRecord(context, 10, 48, 2).then((data) {
      _controller.add(data);
      _checked = List.generate(data.length, (_) => false);
    }).catchError((error) {
      // Handle error
    });
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
        return RejectConfirmPopup(
            onCancel: () {
              Navigator.pop(context);
            },
            onReject: () {
              _rejectSelectedDocuments();
              Navigator.pop(context);
            });
      },
    );
  }

  Future<void> _rejectSelectedDocuments() async {
    for (var documentId in _selectedDocumentIds) {
      await rejectOnboardAckHealthPatch(context, documentId);
    }
    /// Refresh the data after rejection
    getAckHealthRecord(context, 10, 48, 2).then((data) {
      _controller.add(data);
      _checked = List.generate(data.length, (_) => false);
      _selectedDocumentIds.clear();
    }).catchError((error) {
      // Handle error
    });
  }

  void _handleApproveSelected() {
    if (_selectedDocumentIds.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ApproveConfirmPopup(
            onCancel: (){
              Navigator.pop(context);
            },
            onApprove: (){
              _approveSelectedDocuments();
              Navigator.of(context).pop();
            });
        },
    );
  }

  Future<void> _approveSelectedDocuments() async {
    for (var documentId in _selectedDocumentIds) {
      await approveOnboardAckHealthPatch(context, documentId);
    }
    /// Refresh the data after approval
    getAckHealthRecord(context, 10, 48, 2).then((data) {
      _controller.add(data);
      _checked = List.generate(data.length, (_) => false);
      _selectedDocumentIds.clear();
    }).catchError((error) {
      // Handle error
    });
  }

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
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.9,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: WrapWidget(
                childern: [
                  ...List.generate(snapshot.data!.length, (index) {
                    final data = snapshot.data![index];
                    final fileUrl = data.DocumentUrl;
                    final fileExtension = fileUrl.split('.').last.toLowerCase();

                    Widget fileWidget;

                    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
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
                    } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
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
                      children: [
                        Container(
                          width: AppSize.s500,
                          // margin: EdgeInsets.symmetric(vertical: 10),
                          // padding: EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //   color: ColorManager.white,
                          //   borderRadius: BorderRadius.circular(8),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: ColorManager.shadow.withOpacity(0.1),
                          //       spreadRadius: 1,
                          //       blurRadius: 5,
                          //       offset: Offset(0, 3),
                          //     ),
                          //   ],
                          // ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _checked[index],
                                onChanged: (value) {
                                  _handleCheckboxChanged(value, index, snapshot.data![index].employeeDocumentId);
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
                                    border: Border.all(width: 2, color: ColorManager.faintGrey),
                                  ),
                                  child: fileWidget,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  data.DocumentName,
                                  style: AknowledgementStyleConst.customTextStyle(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 15,
                  top: MediaQuery.of(context).size.width / 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ///reject
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