// import 'package:flutter/material.dart';
//
// class ResponsiveTabBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 9,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Details'),
//           bottom: TabBar(
//             isScrollable: true,
//             indicatorColor: Colors.blue,
//             tabs: [
//               Tab(text: 'General'),
//               Tab(text: 'Employment'),
//               Tab(text: 'Education'),
//               Tab(text: 'References'),
//               Tab(text: 'Licenses'),
//               Tab(text: 'Banking'),
//               Tab(text: 'Health Records'),
//               Tab(text: 'Acknowledgements'),
//               Tab(text: 'Legal Documents'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Center(child: Text('General Content')),
//             Center(child: Text('Employment Content')),
//             Center(child: Text('Education Content')),
//             Center(child: Text('References Content')),
//             Center(child: Text('Licenses Content')),
//             Center(child: Text('Banking Content')),
//             Center(child: Text('Health Records Content')),
//             Center(child: Text('Acknowledgements Content')),
//             Center(child: Text('Legal Documents Content')),
//           ],
//         ),
//       ),
//     );
//   }
// }
