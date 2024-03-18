import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/constant_textfield/const_textfield.dart';
import 'package:prohealth/presentation/widgets/mcq_const_widget/mcq_const_widget.dart';
///prachi
class SalesTab extends StatelessWidget {
  final TextEditingController _yourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.4;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.2;
    double textFieldWidth = MediaQuery.of(context).size.width / 5.5;
    double textFieldHeight = MediaQuery.of(context).size.width / 65;
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
              child: McqWidget(
                title: "Employment",
                items: ["Full Time", "Contract", "Part Time", "Per diem"],
              ),
            ),
          ],
        )
      ],
    );
  }
}
