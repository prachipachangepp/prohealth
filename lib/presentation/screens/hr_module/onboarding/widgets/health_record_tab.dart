import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/services/base64/download_file_base64.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import '../approve_reject_dialog_constant.dart';
import '../download_doc_const.dart';

class HealthRecordConstant extends StatefulWidget {
  final int employeeId;
  const HealthRecordConstant({super.key, required this.employeeId});

  @override
  State<HealthRecordConstant> createState() => _HealthRecordConstantState();
}

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
      var data = await getAckHealthRecord(context,AppConfig.healthDocId, widget.employeeId, 'no');
      data.sort((a, b) {
        if (a.approved == true && b.approved != true) {
          return -1;
        } else if (a.approved != true && b.approved == true) {
          return 1;
        } else {
          return 0;
        }
      });

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
      print(result.message);
    }
  }


  @override
  Widget build(BuildContext context) {
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
                    AppStringHRNoData.noOnboardHealth,
                  style: AllNoDataAvailable.customTextStyle(context)
                ),
              ));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Text(
                    AppStringHRNoData.noOnboardHealth,
                  style: AllNoDataAvailable.customTextStyle(context)
                ),
              ));
        }
        return Padding(
          padding: const EdgeInsets.only(left: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  ...List.generate(snapshot.data!.length, (index) {
                    final data = snapshot.data![index];
                    final fileUrl = data.DocumentUrl;
                    final fileExtension = fileUrl.split('/').last;
                    Widget fileWidget;
                    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
                      fileWidget = Image.network(
                        fileUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('images/Vector.png');
                          //   Icon(
                          //   Icons.description_outlined,
                          //   size: 25,
                          //   color: ColorManager.blueprime,
                          // );
                        },
                      );
                    } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                      fileWidget = Image.asset('images/Vector.png');
                      //     Icon(
                      //   Icons.description_outlined,
                      //   size: 25,
                      //   color: ColorManager.blueprime,
                      // );
                    } else {
                      fileWidget = Image.asset('images/Vector.png');
                      //     Icon(
                      //   Icons.description_outlined,
                      //   size: 25,
                      //   color: ColorManager.blueprime,
                      // );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Row(
                              children: [
                                data.approved == true
                                    ? Container(
                                    width: AppSize.s31,
                                    child:  CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.green,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ))
                                    : Checkbox(
                                  value: _checked[index],
                                  onChanged: data.approved == null
                                      ? (value) {
                                    _handleCheckboxChanged(
                                        value,
                                        index,
                                        snapshot.data![index].employeeDocumentId);
                                  }
                                      : null,
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () =>  downloadFile(fileUrl),
                                      //DowloadFile().downloadPdfFromBase64(fileExtension,"Health"),
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
                                    data.documentFileName,
                                    style: AknowledgementStyleConst.customTextStyle(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s25),
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
                    Container(
                      width: 85,
                      child: ElevatedButton(
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
                          style: TransparentButtonTextConst.customTextStyle(context)
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
                        style: BlueButtonTextConst.customTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
