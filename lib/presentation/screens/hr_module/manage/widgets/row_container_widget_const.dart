import 'package:flutter/material.dart';

class TwoContainersRow extends StatelessWidget {
  final Widget child1;
  final Widget child2;

  const TwoContainersRow({Key? key, required this.child1, required this.child2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            height: 200,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 80,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: child1,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 50),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            height: 200,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 80,
                vertical: MediaQuery.of(context).size.width / 120,
              ),
              child: child2,
            ),
          ),
        ),
      ],
    );
  }
}

//
// class CustomRowWithText extends StatelessWidget {
//   final String text1;
//   final String text2;
//
//   const CustomRowWithText({Key? key, required this.text1, required this.text2})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: Container(
//             width: 50,
//             padding: EdgeInsets.all(10.0),
//             color: Colors.blue,
//             child: Text(
//               text1,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ),
//         ),
//         SizedBox(width: MediaQuery.of(context).size.width / 50),
//         Expanded(
//           child: Container(
//             width: 50,
//             padding: EdgeInsets.all(10.0),
//             color: Colors.green,
//             child: Text(
//               text2,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
