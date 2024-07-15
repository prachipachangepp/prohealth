import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../taxtfield_constant.dart';

class ReferencesIndicator extends StatelessWidget {
  const ReferencesIndicator({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Center(
            child: Text(
              'References',
              style: GoogleFonts.firaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff50B5E5)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE6F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Expanded(
              child: Text(
                'Please provide the names and contact information of three professional references who can speak to your work experience and qualifications. For each reference, Kindly include the following information:',
                style: GoogleFonts.firaSans(
                  color: Color(0xFF686464),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Padding(
            padding: const EdgeInsets.only(left: 166.0, right: 166),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employment #1',
                      style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff686464)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          Text(
                            'Title/Position',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          Text(
                            'Company/ Organization',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          Text(
                            'Mobile Number',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          Text(
                            'How do you know this person ?',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          Text(
                            'Length of Association',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            //controller:,
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Please ensure that the references you provide are professional contacts who can provide insight into your skills, work ethic, and character ",
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle add education action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff50B5E5),
                        // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text(
                        'Add Education',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}





// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../manage/widgets/bottom_row.dart';
// import '../../../manage/widgets/top_row.dart';
// import 'multi_step_form.dart';
//
// class FormScreenView extends StatelessWidget {
//   const FormScreenView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: TopRowConstant(),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Details',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.firaSans(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//                 color: Color(0xff50B5E5),
//               ),
//             ),
//           ),
//           Flexible(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   // physics: AlwaysScrollableScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         SingleChildScrollView(child: MultiStepForm()),
//                         // Add other form elements or widgets here
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const Row(
//             children: [BottomBarRow()],
//           )
//         ],
//       ),
//     );
//   }
// }
