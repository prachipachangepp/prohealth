//
// class AppBarSM extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Container(
//         height: 131,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(0.25),
//               blurRadius: 4,
//               offset: Offset(0, 4),
//             ),
//           ],
//           color: Color(0xffFFFFFF),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     height: 20,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 10,
//                   child: Container(
//                     color: Colors.red,
//                     height: 20,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     color: Colors.yellow,
//                     height: 40,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         CustomButton(
//                           height: 30,
//                           width: 100,
//                           onPressed: () {},
//                           text: 'Button 1',
//                         ),
//                         CustomButton(
//                           height: 30,
//                           width: 100,
//                           onPressed: () {},
//                           text: 'Button 2',
//                         ),
//                         CustomButton(
//                           height: 30,
//                           width: 100,
//                           onPressed: () {},
//                           text: 'Button 3',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
