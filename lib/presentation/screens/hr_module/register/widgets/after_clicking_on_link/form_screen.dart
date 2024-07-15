





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
