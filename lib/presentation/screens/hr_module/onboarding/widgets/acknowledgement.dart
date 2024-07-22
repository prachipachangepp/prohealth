import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../manage/const_wrap_widget.dart';

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
//   // Widget build(BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80, vertical: 100),
//   //     child: Material(
//   //       elevation: 5,
//   //       borderRadius: BorderRadius.all(Radius.circular(12)),
//   //       child: Container(
//   //         height: AppSize.s181,
//   //         width: MediaQuery.of(context).size.width / 70,
//   //         padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
//   //         decoration: BoxDecoration(
//   //           color: ColorManager.white,
//   //           borderRadius: BorderRadius.all(Radius.circular(12)),
//   //         ),
//   //         child: Row(
//   //           children: [
//   //             AcknowledgementContainer(
//   //               child: IconButton(
//   //                 onPressed: () {},
//   //                 icon: Icon(
//   //                   Icons.description_outlined,
//   //                   color: ColorManager.blueprime,
//   //                 ),
//   //                 iconSize: AppSize.s24,
//   //               ),
//   //             ),
//   //             SizedBox(width: AppSize.s10),
//   //             Text(AppString.ackCandidate,
//   //                 style: AknowledgementStyleConst.customTextStyle(context))
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream:_controller.stream,
//         builder: (context,snapshot) {
//           getAckHealthRecord(context, 1,10,2).then((data) {
//             _controller.add(data);
//           }).catchError((error) {
//             // Handle error
//           });
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: ColorManager.blueprime,
//               ),
//             );
//           }
//           if (snapshot.data!.isEmpty) {
//             return Center(
//               child: Text(
//                 AppString.dataNotFound,
//                 style: CustomTextStylesCommon.commonStyle(
//                   fontWeight: FontWeightManager.medium,
//                   fontSize: FontSize.s12,
//                   color: ColorManager.mediumgrey,
//                 ),
//               ),
//             );
//           }
//           if(snapshot.hasData){
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child:
//               Container(
//                 height: MediaQuery.of(context).size.height/1,
//                 padding: EdgeInsets.symmetric(vertical: 30),
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.25),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(12)),
//                 ),
//                 child:WrapWidget(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   childern: List.generate(snapshot.data!.length, (index){
//                     return
//                       // Column(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       // children: [ // Adding top padding
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
//                         child: Container(
//                           width: AppSize.s500,
//                           child: Row(
//                             children: [
//                               Container(
//                                   width: 62,
//                                   height: 45,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     border: Border.all(width: 2,color: ColorManager.faintGrey),
//                                   ),
//                                   child: Image.asset('images/Vector.png') ),
//                               SizedBox(width: 10),
//                               Text(snapshot.data![index].UploadDate,
//                                   style: AknowledgementStyleConst.customTextStyle(context))
//                             ],
//                           ),
//                         ),
//                       );
//                   }),
//                   // Column(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: [ // Adding top padding
//                   //     Row(
//                   //       children: [
//                   //         Container(
//                   //             width: 62,
//                   //             height: 45,
//                   //             decoration: BoxDecoration(
//                   //               borderRadius: BorderRadius.circular(4),
//                   //               border: Border.all(width: 2,color: ColorManager.faintGrey),
//                   //             ),
//                   //             child: Image.asset('images/Vector.png') ),
//                   //         SizedBox(width: 10),
//                   //         Text('On call',
//                   //             style: AknowledgementStyleConst.customTextStyle(context))
//                   //       ],
//                   //     ),
//                   //     SizedBox(height: 20),
//                   //     Row(
//                   //       children: [
//                   //         Container(
//                   //             width: 62,
//                   //             height: 45,
//                   //             decoration: BoxDecoration(
//                   //               borderRadius: BorderRadius.circular(4),
//                   //               border: Border.all(width: 2,color: ColorManager.faintGrey),
//                   //             ),
//                   //             child: Image.asset('images/Vector.png') ),
//                   //         SizedBox(width: 10),
//                   //         Text('Policy Concerning 3rd Party',
//                   //             style:AknowledgementStyleConst.customTextStyle(context))
//                   //       ],
//                   //     ),
//                   //   ],),
//
//                 ),
//               ),
//               // ),
//             );
//           }
//           return SizedBox();
//         }
//     );
//   }
// }

class AcknowledgementTab extends StatefulWidget {
  const AcknowledgementTab({Key? key}) : super(key: key);

  @override
  State<AcknowledgementTab> createState() => _AcknowledgementTabState();
}

class _AcknowledgementTabState extends State<AcknowledgementTab> {
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: MediaQuery.of(context).size.height/3,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(5, 5),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: ListView.builder(
              itemCount: 10,//snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Container(
                    width: AppSize.s500,
                    child: Row(
                      children: [
                        Container(
                          width: 62,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(width: 2, color: ColorManager.faintGrey),
                          ),
                          child: Image.asset('images/Vector.png'),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Policy Concerning 3rd Party',
                          //snapshot.data![index].UploadDate,
                          style: AknowledgementStyleConst.customTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/100),
        Padding(
          padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
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
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/90),
              ElevatedButton(
                onPressed: () {},
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
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
    //   StreamBuilder(
    //   stream: _controller.stream,
    //   builder: (context, snapshot) {
    //     getAckHealthRecord(context, 1, 10, 2).then((data) {
    //       _controller.add(data);
    //     }).catchError((error) {
    //       // Handle error
    //     });
    //
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: ColorManager.blueprime,
    //         ),
    //       );
    //     }
    //     if (snapshot.data == null || snapshot.data!.isEmpty) {
    //       return Center(
    //         child: Text(
    //           AppString.dataNotFound,
    //           style: CustomTextStylesCommon.commonStyle(
    //             fontWeight: FontWeightManager.medium,
    //             fontSize: FontSize.s12,
    //             color: ColorManager.mediumgrey,
    //           ),
    //         ),
    //       );
    //     }
    //     if (snapshot.hasData) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 25),
    //         child: Container(
    //           height: MediaQuery.of(context).size.height,
    //           padding: const EdgeInsets.symmetric(vertical: 30),
    //           decoration: BoxDecoration(
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.withOpacity(0.25),
    //                 spreadRadius: 1,
    //                 blurRadius: 4,
    //                 offset: Offset(0, 5),
    //               ),
    //             ],
    //             color: Colors.white,
    //             borderRadius: const BorderRadius.all(Radius.circular(12)),
    //           ),
    //           child: ListView.builder(
    //             itemCount: 5,//snapshot.data!.length,
    //             itemBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    //                 child: Container(
    //                   width: AppSize.s500,
    //                   child: Row(
    //                     children: [
    //                       Container(
    //                         width: 62,
    //                         height: 45,
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(4),
    //                           border: Border.all(width: 2, color: ColorManager.faintGrey),
    //                         ),
    //                         child: Image.asset('images/Vector.png'),
    //                       ),
    //                       const SizedBox(width: 10),
    //                       Text(
    //                         'saloni',
    //                         //snapshot.data![index].UploadDate,
    //                         style: AknowledgementStyleConst.customTextStyle(context),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       );
    //     }
    //     return const SizedBox();
    //   },
    // );
  }
}



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

///
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/acknowledgement_constant.dart';
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/theme_manager.dart';
// import '../../../../../../app/resources/value_manager.dart';
//
// class AcknowledgementTab extends StatelessWidget {
//   const AcknowledgementTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: AppPadding.p80, vertical: AppPadding.p40),
//           child: Material(
//             elevation: 5,
//             borderRadius: BorderRadius.all(Radius.circular(12)),
//             color: Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 14),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/50),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/21),
//                               child: AcknowledgementConstant(
//                                 'Candidate Release Authorization Form',
//                                 Icons.description_outlined,
//                                 Color(0xff50B5E5),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: MediaQuery.of(context).size.height / 60),
//                         Row(
//                           children: [
//                             AcknowledgementConstant(
//                               'Confidentiality Statement',
//                               Icons.description_outlined,
//                               Color(0xff50B5E5),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
//                     child: Column(
//                       // mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/13),
//                               child: AcknowledgementConstant(
//                                 'On Call',
//                                 Icons.description_outlined,
//                                 Color(0xff50B5E5),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: MediaQuery.of(context).size.height / 60),
//                         Row(
//                           children: [
//                             AcknowledgementConstant(
//                               'Policy Concerning 3rd Party',
//                               Icons.description_outlined,
//                               Color(0xff50B5E5),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height/100),
//         Padding(
//           padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/20),
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
//   }
// }


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/acknowledgement_constant.dart';
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/theme_manager.dart';
// import '../../../../../../app/resources/value_manager.dart';
//
// class AcknowledgementTab extends StatefulWidget {
//   const AcknowledgementTab({Key? key}) : super(key: key);
//
//   @override
//   _AcknowledgementTabState createState() => _AcknowledgementTabState();
// }
//
// class _AcknowledgementTabState extends State<AcknowledgementTab> {
//   bool isChecked1 = false;
//   bool isChecked2 = false;
//   bool isChecked3 = false;
//   bool isChecked4 = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80),
//           child: Material(
//             elevation: 5,
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: screenHeight / 14),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     flex: 1,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: screenWidth / 21),
//                               child: Row(
//                                 children: [
//                                   Checkbox(
//                                     value: isChecked1,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         isChecked1 = value!;
//                                       });
//                                     },
//                                   ),
//                                   AcknowledgementConstant(
//                                     'Candidate Release Authorization Form',
//                                     Icons.description_outlined,
//                                     Color(0xff50B5E5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: screenHeight / 60),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: screenWidth / 21),
//                               child: Row(
//                                 children: [
//                                   Checkbox(
//                                     value: isChecked2,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         isChecked2 = value!;
//                                       });
//                                     },
//                                   ),
//                                   AcknowledgementConstant(
//                                     'Confidentiality Statement',
//                                     Icons.description_outlined,
//                                     Color(0xff50B5E5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Flexible(
//                     flex: 1,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(right: screenWidth / 13), //6.6
//                               child: Row(
//                                 children: [
//                                   Checkbox(
//                                     value: isChecked3,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         isChecked3 = value!;
//                                       });
//                                     },
//                                   ),
//                                   AcknowledgementConstant(
//                                     'On Call',
//                                     Icons.description_outlined,
//                                     Color(0xff50B5E5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: screenHeight / 60),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(right: 0),
//                               child: Row(
//                                 children: [
//                                   Checkbox(
//                                     value: isChecked4,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         isChecked4 = value!;
//                                       });
//                                     },
//                                   ),
//                                   AcknowledgementConstant(
//                                     'Policy Concerning 3rd Party',
//                                     Icons.description_outlined,
//                                     Color(0xff50B5E5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: screenHeight / 100),
//         Padding(
//           padding: EdgeInsets.only(right: screenWidth / 19),
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
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               SizedBox(width: screenWidth / 90),
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
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
