// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
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
//     return Padding(
//       // padding: EdgeInsets.only(left: AppPadding.p80,right:  AppPadding.p80, bottom: MediaQuery.of(context).size.width/8),
//       padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80, vertical: 100),
//       child: Material(
//         elevation: 5,
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//         child: Container(
//        //   height: AppSize.s181,
//           height: AppSize.s181,
//           width: MediaQuery.of(context).size.width / 70,
//           padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
//           decoration: BoxDecoration(
//             color: ColorManager.white,
//             borderRadius: BorderRadius.all(Radius.circular(12)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Adding top padding
//                   Row(
//                     children: [
//                       AcknowledgementContainer(
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.description_outlined,
//                             color: ColorManager.blueprime,
//                           ),
//                           iconSize: AppSize.s24,
//                         ),
//                       ),
//                       SizedBox(width: AppSize.s10),
//                       Text(AppString.ackCandidate,
//                           style: AknowledgementStyleConst.customTextStyle(context))
//                     ],
//                   ),
//                   // SizedBox(height: AppSize.s10),
//                   Row(
//                     children: [
//                       AcknowledgementContainer(
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.description_outlined,
//                             color: ColorManager.blueprime,
//                           ),
//                           iconSize: AppSize.s24,
//                         ),
//                       ),
//                       SizedBox(width: AppSize.s10),
//                       Text(AppString.ackConfidential,
//                           style:
//                               AknowledgementStyleConst.customTextStyle(context))
//                     ],
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Adding top padding
//                   Row(
//                     children: [
//                       AcknowledgementContainer(
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.description_outlined,
//                             color: ColorManager.blueprime,
//                           ),
//                           iconSize: AppSize.s24,
//                         ),
//                       ),
//                       SizedBox(width: AppSize.s10),
//                       Text(AppString.ackonCall,
//                           style:
//                               AknowledgementStyleConst.customTextStyle(context))
//                     ],
//                   ),
//                   // SizedBox(height: AppSize.s20),
//                   Row(
//                     children: [
//                       AcknowledgementContainer(
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.description_outlined,
//                             color: ColorManager.blueprime,
//                           ),
//                           iconSize: AppSize.s24,
//                         ),
//                       ),
//                       SizedBox(width: AppSize.s10),
//                       Text(AppString.ackpolicy,
//                           style:
//                               AknowledgementStyleConst.customTextStyle(context))
//                     ],
//                   ),
//                 ],
//
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AcknowledgementContainer extends StatelessWidget {
//   final Widget child;
//
//   const AcknowledgementContainer({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: AppSize.s62,
//       height: AppSize.s45,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(width: 2, color: Color(0xffC6C6C6),),
//       ),
//       child: child,
//     );
//   }
// }


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



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/acknowledgement_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';

class AcknowledgementTab extends StatelessWidget {
  const AcknowledgementTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80,),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: screenWidth / 21),
                                child: AcknowledgementConstant(
                                  'Candidate Release Authorization Form',
                                  Icons.description_outlined,
                                  Color(0xff50B5E5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / 60),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: screenWidth / 21),
                                child: AcknowledgementConstant(
                                  'Confidentiality Statement',
                                  Icons.description_outlined,
                                  Color(0xff50B5E5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: screenWidth / 13), //6.6
                                child: AcknowledgementConstant(
                                  'On Call',
                                  Icons.description_outlined,
                                  Color(0xff50B5E5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: AcknowledgementConstant(
                                  'Policy Concerning 3rd Party',
                                  Icons.description_outlined,
                                  Color(0xff50B5E5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight / 100),
          Padding(
            padding: EdgeInsets.only(right: screenWidth / 20),
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
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth / 90),
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
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
