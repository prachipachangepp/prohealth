///////////////////////

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../manage/widgets/bottom_row.dart';
import '../../../manage/widgets/top_row.dart';

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  // Form key for accessing form data
  final _formKey = GlobalKey<FormState>();

  // Current step in the stepper
  int _currentStep = 0;
  bool get isFirstStep => _currentStep == 0;
  bool get isLastStep => _currentStep == steps().length - 1;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Details")],
          ),
          Expanded(
            child: Stepper(
                type: StepperType.horizontal,
                steps: steps(),
                currentStep: _currentStep,
                onStepContinue: () {
                  if (isLastStep) {
                    setState(() => isCompleted =true);
                  } else {
                    setState(() => _currentStep += 1);
                  }
                },
                onStepCancel: isFirstStep
                    ? null
                    : () => setState(() => _currentStep -= 1),
                controlsBuilder: (context, details) => Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff1696C8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: details.onStepContinue,
                              label: Text(isLastStep ? 'Conform' : 'Continue'),
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          if (!isFirstStep) ...[
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Color(0xff1696C8),
                                  side: BorderSide(color: Color(0xff1696C8)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: details.onStepCancel,
                                label: Text("Back"),
                                icon: Icon(Icons.arrow_back),
                              ),
                            )
                          ]
                        ],
                      ),
                    )),
          ),
          const Row(
            children: [BottomBarRow()],
          )
        ],
      ),
    );
  }

  List<Step> steps() => [
        Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: const Text('General'),
            content: Container(
              color: Colors.grey,
              height: 500,
              width: 100,
              child: Column(
                children: [
                  Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("General"),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6F7FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Please fill all your personal information below. Your personal details will be required to proceed through the recruitment process.',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF686464),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("Upload Photo")],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("Gender")],
                      ),
                    ],
                  )
                ],
              ),
            )),
        Step(
            state: _currentStep <= 1 ? StepState.editing : StepState.complete,
           isActive: _currentStep == 1,
            title: const Text('Employment'),
            content: Container(
              height: 100,
              color: Colors.yellow,
            )),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 2,
          title: const Text('Education'),
          content: Container(
            height: 100,
            color: Colors.red,
          ),
        ),
        Step(
          state: _currentStep <= 3 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 3,
          title: const Text('References'),
          content: Container(
            height: 100,
            color: Colors.pink,
          ),
        ),
        Step(
          state: _currentStep <= 4 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 4,
          title: const Text('Licenses'),
          content: Container(
            height: 100,
            color: Colors.orange,
          ),
        ),
        Step(
          state: _currentStep <= 5 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 5,
          title: const Text('Banking'),
          content: Container(
            height: 100,
            color: Colors.purple,
          ),
        ),
        Step(
          state: _currentStep <= 6 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 6,
          title: const Text('Health Records'),
          content: Container(
            height: 100,
            color: Colors.grey,
          ),
        ),
        Step(
          state: _currentStep <= 7 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 7,
          title: const Text('Acknowledgements'),
          content: Container(
            height: 100,
            color: Colors.brown,
          ),
        ),
        Step(
          state: _currentStep <= 8 ? StepState.editing : StepState.complete,
          isActive: _currentStep == 8,
          title: const Text('Legal Documents'),
          content: Container(
            height: 100,
            color: Colors.green,
          ),
        ),
      ];
}

//
//
// Form(
// key: _formKey,
// child: Stepper(
// type: StepperType.horizontal,
// currentStep: _currentStep,
// onStepContinue: () {
// if(_currentStep== 8){
// setState(() => isCompleted =true);
// }else{
//
// }
//
// setState(() {
// if (_currentStep < 8) {
// _currentStep += 1;
// } else {
// // Validate the form fields before proceeding
// if (_formKey.currentState!.validate()) {
// // All validations pass
// // Submit your form or save data here
// // For demonstration, let's just show a snackbar
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(
// content: Text('Form Submitted!'),
// ),
// );
// }
// }
// });
// },
// onStepCancel: () {
// setState(() {
// if (_currentStep > 0) {
// _currentStep -= 1;
// } else {
// _currentStep = 0;
// }
// });
// },
// steps: [
// Step(
// state:
// _currentStep <= 0 ? StepState.editing : StepState.complete,
//
// // isActive: true,
// title: const Text('General'),
// content: Container(
// height: 700,
// width: 100,
// child: Column(
// children: [
// Center(
// child: Align(
// alignment: Alignment.topCenter,
// child: Text("Details"),
// ),
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// decoration: BoxDecoration(
// color: Color(0xFFE6F7FF),
// borderRadius: BorderRadius.circular(12),
// ),
// child: Text(
// 'Please fill all your personal information below. Your personal details will be required to proceed through the recruitment process.',
// style: GoogleFonts.firaSans(
// color: Color(0xFF686464),
// fontSize: 12,
// fontWeight: FontWeight.w500,
// ),
// ),
// ),
//
// ]
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text("Upload Photo")
// ],
// ),
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text("Gender")
// ],
// ),
// ],
// )
// ],
// ),
// color: Colors.black26)),
// Step(
// state: _currentStep <= 1 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 1,
// title: const Text('Employment'),
// content: TextFormField(
// //controller: _employmentController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Employment details';
// }
// return null;
// }),
// ),
//
// // Add more steps for other form fields as needed
// // Example:
// Step(
// state: _currentStep <= 2 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 2,
// title: const Text('Education'),
// content: TextFormField(
// // controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter education details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 3 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 3,
// title: const Text('References'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter References details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 4 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 4,
// title: const Text('Licenses'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Licenses details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 5 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 5,
// title: const Text('Banking'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Banking details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 6 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 6,
// title: const Text('Health Records'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Health Records details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 7 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 7,
// title: const Text('Acknowledgements'),
// content: TextFormField(
// // controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Acknowledgements details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 8 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 8,
// title: const Text('Legal Documents'),
// content: TextFormField(
// // controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Legal Documents details';
// }
// return null;
// },
// ),
// ),
// ],
//
// ),
// ),

// ////rohit

//
// import 'package:flutter/material.dart';
//
// class ProgressBar extends StatelessWidget {
//   final List<String> steps = [
//     "General",
//     "Employment",
//     "Education",
//     "References",
//     "Licenses",
//     "Banking",
//     "Health Records",
//     "Acknowledgements",
//     "Legal Documents"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Details',
//             style: TextStyle(fontSize: 20, color: Colors.blue),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(steps.length, (index) {
//               return Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 12,
//                     backgroundColor: index == 0 ? Colors.blue : Colors.grey,
//                     child: CircleAvatar(
//                       radius: 10,
//                       backgroundColor: Colors.white,
//                       child: CircleAvatar(
//                         radius: 6,
//                         backgroundColor: index == 0 ? Colors.blue : Colors.grey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     steps[index],
//                     style: TextStyle(
//                       color: index == 0 ? Colors.blue : Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               );
//
//             }),
//           ),
//
//           Expanded(
//             child: Container(
//               color: Colors.indigoAccent,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//import 'package:flutter/material.dart';

///////////////////////////////////
//
// class StepProgressBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               buildStep(context, isActive: true),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text('Step 1'),
//               SizedBox(width: 50),
//               Text('Step 2'),
//               SizedBox(width: 50),
//               Text('Step 3'),
//               SizedBox(width: 50),
//               Text('Step 4'),
//               SizedBox(width: 50),
//               Text('Step 5'),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget buildStep(BuildContext context, {bool isActive = false}) {
//     return CircleAvatar(
//       radius: 15,
//       backgroundColor: isActive ? Colors.blue : Colors.grey,
//       child: isActive ? Icon(Icons.check, color: Colors.white, size: 20) : null,
//     );
//   }
//
//   Widget buildConnector(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 5,
//         color: Colors.grey,
//       ),
//     );
//   }
// }

// //////new///////
//
// import 'package:flutter/material.dart';
//
// class ProgressBar extends StatefulWidget {
//   @override
//   _ProgressBarState createState() => _ProgressBarState();
// }
//
// class _ProgressBarState extends State<ProgressBar> {
//   int _currentStep = 0;
//
//   final List<String> steps = [
//     "General",
//     "Employment",
//     "Education",
//     "References",
//     "Licenses",
//     "Banking",
//     "Health Records",
//     "Acknowledgements",
//     "Legal Documents"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Details',
//             style: TextStyle(fontSize: 20, color: Colors.blue),
//           ),
//           SizedBox(height: 10),
//           SizedBox(
//             height: 100,
//             //width: I,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(steps.length, (index) {
//                 bool isActive = index <= _currentStep;
//                 bool isLast = index == steps.length - 1;
//
//                 return Column(
//                   children: [
//                     Container(
//                       width: 24,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: isActive ? Colors.blue : Colors.grey,
//                       ),
//                       child: Center(
//                         child: Text(
//                           (index + 1).toString(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       steps[index],
//                       style: TextStyle(
//                         color: isActive ? Colors.blue : Colors.grey,
//                         fontSize: 12,
//                       ),
//                     ),
//                     if (!isLast)
//                       Expanded(
//                         child: Container(
//                           height: 2,
//                           color: isActive ? Colors.blue : Colors.grey,
//                         ),
//                       ),
//                   ],
//                 );
//               }),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               //height: ,
//               color: Colors.indigoAccent, // Replace with your main content
//               child:
//                 // PageView(
//                 //   children: [
//                 //     PageView.custom(childrenDelegate:)
//                 //   ],
//
//                 //)
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_currentStep < steps.length - 1) {
//                         _currentStep++;
//                       }
//                     });
//                   },
//                   child: Text(_currentStep == steps.length - 1 ? 'Finish' : 'Next'),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

/////////////

/////dummy////
//
// import 'package:flutter/material.dart';
//
// import '../../../../../../app/resources/const_string.dart';
//
// class MyStepperForm extends StatefulWidget {
//   @override
//   _MyStepperFormState createState() => _MyStepperFormState();
// }
//
// class _MyStepperFormState extends State<MyStepperForm> {
//   int _currentStep = 0;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   final List<Step> _steps = [
//     Step(
//       title: Center(child: Text('Name')),
//       content: TextFormField(
//
//         decoration: InputDecoration(labelText: 'Enter your name'),
//       ),
//       isActive: true,
//     ),
//     Step(
//       title: Text('Email'),
//       content: TextFormField(
//         decoration: InputDecoration(labelText: 'Enter your email'),
//       ),
//       isActive: true,
//     ),
//     Step(
//       title: Column(
//         children: [
//           Text('Password'),
//         ],
//       ),
//       content: TextFormField(
//
//         decoration: InputDecoration(labelText: 'Enter your password'),
//         obscureText: true,
//         onChanged: (value) {},
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return AppString.enterText;
//           }
//           return null;
//         },
//       ),
//       isActive: true,
//     ),
//   ];
//
//   void _submitForm() {
//     // Handle form submission here
//     String name = _nameController.text;
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     // Process the data
//     print('Name: $name, Email: $email, Password: $password');
//
//     // Navigate to next screen or perform further actions
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Horizontal Stepper Form'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Stepper(
//               steps: _steps,
//               currentStep: _currentStep,
//               type: StepperType.horizontal, // Set horizontal type
//               onStepContinue: () {
//                 setState(() {
//                   if (_currentStep < _steps.length - 1) {
//                     _currentStep++;
//                   } else {
//                     _submitForm();
//                     // You can navigate to another screen here
//                   }
//                 });
//               },
//               onStepCancel: () {
//                 setState(() {
//                   if (_currentStep > 0) {
//                     _currentStep--;
//                   } else {
//                     _currentStep = 0;
//                   }
//                 });
//               },
//               onStepTapped: (step) {
//                 setState(() {
//                   _currentStep = step;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
