import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/constant_textfield/const_textfield.dart';
import 'package:prohealth/presentation/widgets/mcq_const_widget/mcq_const_widget.dart';

///prachi
class ClinicalTab extends StatelessWidget {
  final TextEditingController _yourController = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.4;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.3;
    double textFieldWidth = MediaQuery.of(context).size.width / 5.5;
    double textFieldHeight = MediaQuery.of(context).size.width / 55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// first container
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: containerWidth,
              height: containerHeight1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(0, 3),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(3, 0)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///1st column
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _controller1,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 1',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _controller2,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _controller3,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 3',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _controller4,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 4',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _controller5,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 5',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///2nd column
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 1',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///3rd column
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 1',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///4th column
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 1',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            child: ImpexTextField(
                              controller: _yourController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              labelText: 'Label 2',
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              autofocus: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),

        /// second Container
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: containerWidth,
              height: containerHeight2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(0, 3),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(3, 0)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      McqWidget(
                        title: "Employment",
                        items: [
                          "Full Time",
                          "Contract",
                          "Part Time",
                          "Per diem"
                        ],
                      ),
                      McqWidget(
                        title: "Flexible Coverager",
                        items: ["Sunday", "Monday", "Tuesday", "Wednesday"],
                      ),
                      McqWidget(
                        title: "Gender",
                        items: ["Male", "Female", "Other"],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      McqWidget(
                        title: "Status",
                        items: ["Active", "Trainee", "Inactive"],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 6.8,
                      ),
                      McqWidget(
                        title: "Service",
                        items: [
                          "Home Health",
                          "House Spice",
                          "Home Care",
                          "Palliative Care"
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

///
//
// class ClinicalTab extends StatelessWidget {
//   final TextEditingController _yourController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(color: Colors.red, child: Text("Hello")),
//         ),
//         Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.yellow,
//           ),
//         ),
//         // Expanded(
//         //   flex: 2,
//         //   child: Padding(
//         //     padding: const EdgeInsets.all(8.0),
//         //     child: Container(
//         //       decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.circular(20),
//         //         border: Border.all(
//         //           width: 0.1,
//         //         ),
//         //         color: Colors.white,
//         //         boxShadow: [
//         //           BoxShadow(
//         //               blurRadius: 3.0,
//         //               offset: Offset(0, 3),
//         //               color: Colors.grey.withOpacity(0.5)),
//         //           BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
//         //           BoxShadow(color: Colors.white, offset: Offset(3, 0)),
//         //         ],
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }

// ImpexTextField(
// controller: _yourController,
// obscureText: false,
// keyboardType: TextInputType.text,
// labelText: 'Your Label',
// maxLines: 1,
// textInputAction: TextInputAction.done,
// onSubmitted: (value) {
// print('Submitted: $value');
// },
// autofocus: false,
// ),
///// class ClinicalTab extends StatelessWidget {
// //   final TextEditingController _yourController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     double containerWidth = MediaQuery.of(context).size.width * 0.9;
// //     double containerHeight1 =
// //         MediaQuery.of(context).size.height * 0.4; // Decreased height
// //     double containerHeight2 = MediaQuery.of(context).size.height * 0.3;
// //     double textFieldWidth = MediaQuery.of(context).size.width * 0.3;
// //     double textFieldHeight = 30;
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               width: containerWidth,
// //               height: containerHeight1,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(20),
// //                 border: Border.all(
// //                   width: 1,
// //                   color: Colors.grey,
// //                 ),
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     blurRadius: 3.0,
// //                     offset: Offset(0, 3),
// //                     color: Colors.grey.withOpacity(0.5),
// //                   ),
// //                   BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
// //                   BoxShadow(color: Colors.white, offset: Offset(3, 0)),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.all(15.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         buildSizedBox(_yourController, 'Label 1',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                       ],
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(15.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         buildSizedBox(_yourController, 'Label 1',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                         buildSizedBox(_yourController, 'Label 2',
// //                             textFieldWidth, textFieldHeight),
// //                       ],
// //                     ),
// //                   ),
// //
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //         SizedBox(
// //           height: 5,
// //         ),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               width: containerWidth,
// //               height: containerHeight2,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(20),
// //                 border: Border.all(
// //                   width: 1,
// //                   color: Colors.grey,
// //                 ),
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     blurRadius: 3.0,
// //                     offset: Offset(0, 3),
// //                     color: Colors.grey.withOpacity(0.5),
// //                   ),
// //                   BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
// //                   BoxShadow(color: Colors.white, offset: Offset(3, 0)),
// //                 ],
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.all(12.0),
// //                     child: Text(
// //                       "Employment",
// //                       style: TextStyle(fontSize: 14),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Row(
// //                       children: [
// //                         buildIconWithText(Icons.circle_outlined, "Full Time"),
// //                         buildIconWithText(Icons.circle_outlined, "Contract"),
// //                         buildIconWithText(Icons.circle_outlined, "Part Time"),
// //                         buildIconWithText(Icons.circle_outlined, "Per diem"),
// //                       ],
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ],
// //         )
// //       ],
// //     );
// //   }
// //
// //   Widget buildIconWithText(IconData icon, String text) {
// //     return Row(
// //       children: [
// //         Icon(icon),
// //         SizedBox(width: 4),
// //         Text(text),
// //       ],
// //     );
// //   }
// //
// //   Widget buildSizedBox(TextEditingController controller, String labelText,
// //       double width, double height) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: SizedBox(
// //         width: width,
// //         height: height,
// //         child: ImpexTextField(
// //           controller: controller,
// //           obscureText: false,
// //           keyboardType: TextInputType.text,
// //           labelText: labelText,
// //           maxLines: 1,
// //           textInputAction: TextInputAction.next,
// //           onSubmitted: (value) {},
// //           autofocus: false,
// //         ),
// //       ),
// //     );
// //   }
// // }
