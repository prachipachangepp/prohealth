import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/health_record_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import '../../manage/const_wrap_widget.dart';
import '../download_doc_const.dart';
import '../qualification_const_bar/widgets/qualification_tab_constant.dart';
///
class HealthRecordConstant extends StatefulWidget {
  const HealthRecordConstant({super.key});

  @override
  State<HealthRecordConstant> createState() => _HealthRecordConstantState();
}

class _HealthRecordConstantState extends State<HealthRecordConstant> {
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
  List<bool> _checked = [];

  @override
  void initState() {
    super.initState();
    getAckHealthRecord(context, 1, 10, 5).then((data) {
      _controller.add(data);
      _checked = List.generate(data.length, (_) => false);
    }).catchError((error) {
      // Handle error
    });
  }

  void _handleApproveSelected(List<OnboardingAckHealthData> data) {
    // Implement your approve API logic here for selected items
    List<OnboardingAckHealthData> selectedData = [];
    for (int i = 0; i < _checked.length; i++) {
      if (_checked[i]) {
        selectedData.add(data[i]);
      }
    }
    // Call your approve API with selectedData
  }

  void _handleRejectSelected(List<OnboardingAckHealthData> data) {
    // Implement your reject API logic here for selected items
    List<OnboardingAckHealthData> selectedData = [];
    for (int i = 0; i < _checked.length; i++) {
      if (_checked[i]) {
        selectedData.add(data[i]);
      }
    }
    // Call your reject API with selectedData
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Container(
                          width: mediaQuery.width / 3,
                          child: Row(
                            children: [
                              Checkbox(
                                value: _checked[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _checked[index] = value!;
                                  });
                                },
                              ),
                              SizedBox(width: mediaQuery.width / 140),
                              GestureDetector(
                                onTap: () => downloadFile(data.DocumentUrl), // Use the utility function
                                child: Container(
                                  width: mediaQuery.width / 8,
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
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ///reject
                      ElevatedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  height: 150.0,
                                  width: 300.0,
                                  child: Stack(
                                    children: <Widget>[
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
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                'Reject',
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s12,
                                                  fontWeight: FontWeightManager.semiBold,
                                                  color: ColorManager.white,
                                                  decoration: TextDecoration.none,
                                                ),
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
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Do you really want to,\nreject this?",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 14,
                                            fontWeight: FontWeightManager.regular,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Color(0xff1696C8),
                                                  side: BorderSide(color: Color(0xff1696C8)),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width / 75),
                                              ElevatedButton(
                                                onPressed: (){},
                                                // onPressed: () async {
                                                //   await rejectOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                                //   getOnboardingQualificationEmp(context, 1).then((data) {
                                                //     qualificationempStreamController.add(data);
                                                //   }).catchError((error) {});
                                                //   Navigator.of(context).pop();
                                                // },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xff1696C8),
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Yes',
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                            //_handleRejectSelected(snapshot.data!),
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
                      ///approve
                      ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 150.0,
                                width: 300.0,
                                child: Stack(
                                  children: <Widget>[
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
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              'Approve',
                                              style: GoogleFonts.firaSans(
                                                fontSize: FontSize.s12,
                                                fontWeight: FontWeightManager.semiBold,
                                                color: ColorManager.white,
                                                decoration: TextDecoration.none,
                                              ),
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
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Do you really want to approve this?",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.firaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeightManager.regular,
                                          color: ColorManager.mediumgrey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Color(0xff1696C8),
                                                side: BorderSide(color: Color(0xff1696C8)),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width / 75),
                                            ElevatedButton(
                                              onPressed: (){},
                                              // onPressed: () async {
                                              //   await approveOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                              //   getOnboardingQualificationEmp(context, 1).then((data) {
                                              //     qualificationempStreamController.add(data);
                                              //   }).catchError((error) {});
                                              //   Navigator.of(context).pop();
                                              // },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xff1696C8),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                'Yes',
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                            //_handleApproveSelected(snapshot.data!),
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
            ),
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

///without backend
// Padding(
//   padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       ElevatedButton(
//         onPressed: () {},
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
//               fontSize: 10.0,
//               fontWeight: FontWeight.w700
//           ),
//         ),
//       ),
//       SizedBox(width: MediaQuery.of(context).size.width/90),
//       ElevatedButton(
//         onPressed: () {},
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
//               fontSize: 10.0,
//               fontWeight: FontWeight.w700
//           ),
//         ),
//       ),
//     ],
//   ),
// )