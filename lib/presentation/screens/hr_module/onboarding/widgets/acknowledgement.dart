import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../manage/const_wrap_widget.dart';
///before network image
// class AcknowledgementTab extends StatefulWidget {
//   const AcknowledgementTab({Key? key}) : super(key: key);
//
//   @override
//   State<AcknowledgementTab> createState() => _AcknowledgementTabState();
// }
//
// class _AcknowledgementTabState extends State<AcknowledgementTab> {
//   final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
//   List<bool> _checked = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getAckHealthRecord(context, 1, 10, 5).then((data) {
//       _controller.add(data);
//       _checked = List.generate(data.length, (_) => false);
//     }).catchError((error) {
//       // Handle error
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Container(
//             height: MediaQuery.of(context).size.height / 2,
//             padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.25),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             child: Wrap(
//               children: List.generate(snapshot.data!.length, (index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Container(
//                     width: AppSize.s500,
//                     child: Row(
//                       children: [
//                         Checkbox(
//                           activeColor: ColorManager.blueprime,
//                           checkColor: ColorManager.white,
//                           value: _checked[index],
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _checked[index] = value!;
//                             });
//                           },
//                         ),
//                         Container(
//                           width: 62,
//                           height: 45,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             border: Border.all(width: 2, color: ColorManager.faintGrey),
//                           ),
//                           child: Image.asset('images/Vector.png'),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           snapshot.data![index].UploadDate,
//                           style: AknowledgementStyleConst.customTextStyle(context),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
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



/// image launcher
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcknowledgementTab extends StatefulWidget {
  const AcknowledgementTab({Key? key}) : super(key: key);

  @override
  State<AcknowledgementTab> createState() => _AcknowledgementTabState();
}

class _AcknowledgementTabState extends State<AcknowledgementTab> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
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
            child: Wrap(
              children: List.generate(snapshot.data!.length, (index) {
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
                        Icons.broken_image,
                        size: 25,
                        color: ColorManager.faintGrey,
                      );
                    },
                  );
                } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                  fileWidget = Center(
                    child: Icon(
                      Icons.description_outlined,
                      size: 25,
                      color: ColorManager.blueprime,
                    ),
                  );
                } else {
                  fileWidget = Center(
                    child: Icon(
                      Icons.description_outlined,
                      size: 25,
                      color: ColorManager.blueprime,
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Container(
                        width: AppSize.s500,
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
                                data.UploadDate,
                                style: AknowledgementStyleConst.customTextStyle(context),
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










///saloni 22/07 - 11:45
// class AcknowledgementTab extends StatefulWidget {
//   const AcknowledgementTab({Key? key}) : super(key: key);
//
//   @override
//   State<AcknowledgementTab> createState() => _AcknowledgementTabState();
// }
//
// class _AcknowledgementTabState extends State<AcknowledgementTab> {
//   final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//     WrapWidget(childern: List.generate(
//     10,//snapshot.data!.length,
//             (index){
//       return  Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 5),
//         child: Container(
//           color: Colors.greenAccent,
//           height: 50,
//           width: MediaQuery.of(context).size.width/4,
//           child: Row(
//             children: [
//               Container(
//                 width: 62,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(width: 2, color: ColorManager.faintGrey),
//                 ),
//                 child: Image.asset('images/Vector.png'),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 'Policy Concerning 3rd Party',
//                 //snapshot.data![index].UploadDate,
//                 style: AknowledgementStyleConst.customTextStyle(context),
//               ),
//             ],
//           ),
//         ),
//       );
//     })),
//         // ListView.builder(
//         //   itemCount: 10,//snapshot.data!.length,
//         //   itemBuilder: (context, index) {
//         //     return Padding(
//         //       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//         //       child: Container(
//         //         height: 50,
//         //         width: AppSize.s500,
//         //         child: Row(
//         //           children: [
//         //             Container(
//         //               width: 62,
//         //               height: 45,
//         //               decoration: BoxDecoration(
//         //                 borderRadius: BorderRadius.circular(4),
//         //                 border: Border.all(width: 2, color: ColorManager.faintGrey),
//         //               ),
//         //               child: Image.asset('images/Vector.png'),
//         //             ),
//         //             const SizedBox(width: 10),
//         //             Text(
//         //               'Policy Concerning 3rd Party',
//         //               //snapshot.data![index].UploadDate,
//         //               style: AknowledgementStyleConst.customTextStyle(context),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //     );
//         //   },
//         // ),
//         SizedBox(height: MediaQuery.of(context).size.height/100),
//         Padding(
//           padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Color(0xff1696C8),
//                   side: BorderSide(color: Color(0xff1696C8)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Reject',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w700
//                   ),
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width/90),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff1696C8),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Approve',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w700
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//     //   StreamBuilder(
//     //   stream: _controller.stream,
//     //   builder: (context, snapshot) {
//     //     getAckHealthRecord(context, 1, 10, 2).then((data) {
//     //       _controller.add(data);
//     //     }).catchError((error) {
//     //       // Handle error
//     //     });
//     //
//     //     if (snapshot.connectionState == ConnectionState.waiting) {
//     //       return Center(
//     //         child: CircularProgressIndicator(
//     //           color: ColorManager.blueprime,
//     //         ),
//     //       );
//     //     }
//     //     if (snapshot.data == null || snapshot.data!.isEmpty) {
//     //       return Center(
//     //         child: Text(
//     //           AppString.dataNotFound,
//     //           style: CustomTextStylesCommon.commonStyle(
//     //             fontWeight: FontWeightManager.medium,
//     //             fontSize: FontSize.s12,
//     //             color: ColorManager.mediumgrey,
//     //           ),
//     //         ),
//     //       );
//     //     }
//     //     if (snapshot.hasData) {
//     //       return Padding(
//     //         padding: const EdgeInsets.symmetric(horizontal: 25),
//     //         child: Container(
//     //           height: MediaQuery.of(context).size.height,
//     //           padding: const EdgeInsets.symmetric(vertical: 30),
//     //           decoration: BoxDecoration(
//     //             boxShadow: [
//     //               BoxShadow(
//     //                 color: Colors.grey.withOpacity(0.25),
//     //                 spreadRadius: 1,
//     //                 blurRadius: 4,
//     //                 offset: Offset(0, 5),
//     //               ),
//     //             ],
//     //             color: Colors.white,
//     //             borderRadius: const BorderRadius.all(Radius.circular(12)),
//     //           ),
//     //           child: ListView.builder(
//     //             itemCount: 5,//snapshot.data!.length,
//     //             itemBuilder: (context, index) {
//     //               return Padding(
//     //                 padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//     //                 child: Container(
//     //                   width: AppSize.s500,
//     //                   child: Row(
//     //                     children: [
//     //                       Container(
//     //                         width: 62,
//     //                         height: 45,
//     //                         decoration: BoxDecoration(
//     //                           borderRadius: BorderRadius.circular(4),
//     //                           border: Border.all(width: 2, color: ColorManager.faintGrey),
//     //                         ),
//     //                         child: Image.asset('images/Vector.png'),
//     //                       ),
//     //                       const SizedBox(width: 10),
//     //                       Text(
//     //                         'saloni',
//     //                         //snapshot.data![index].UploadDate,
//     //                         style: AknowledgementStyleConst.customTextStyle(context),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               );
//     //             },
//     //           ),
//     //         ),
//     //       );
//     //     }
//     //     return const SizedBox();
//     //   },
//     // );
//   }
// }

class AcknowledgementContainer extends StatelessWidget {
  final Widget child;

  const AcknowledgementContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s62,
      height: AppSize.s45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 2, color: Color(0xffC6C6C6),),
      ),
      child: child,
    );
  }
}
