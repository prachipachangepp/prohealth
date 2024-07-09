
import 'package:flutter/material.dart';

import '../../../../../../app/resources/const_string.dart';

class MyStepperForm extends StatefulWidget {
  @override
  _MyStepperFormState createState() => _MyStepperFormState();
}

class _MyStepperFormState extends State<MyStepperForm> {
  int _currentStep = 0;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  List<Step> _steps = [
    Step(
      title: Text('Name'),
      content: TextFormField(

        decoration: InputDecoration(labelText: 'Enter your name'),
      ),
      isActive: true,
    ),
    Step(
      title: Text('Email'),
      content: TextFormField(
        decoration: InputDecoration(labelText: 'Enter your email'),
      ),
      isActive: true,
    ),
    Step(
      title: Column(
        children: [
          Text('Password'),
        ],
      ),
      content: TextFormField(

        decoration: InputDecoration(labelText: 'Enter your password'),
        obscureText: true,
        onChanged: (value) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppString.enterText;
          }
          return null;
        },
      ),
      isActive: true,
    ),
  ];

  void _submitForm() {
    // Handle form submission here
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Process the data
    print('Name: $name, Email: $email, Password: $password');

    // Navigate to next screen or perform further actions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Stepper Form'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              steps: _steps,
              currentStep: _currentStep,
              type: StepperType.horizontal, // Set horizontal type
              onStepContinue: () {
                setState(() {
                  if (_currentStep < _steps.length - 1) {
                    _currentStep++;
                  } else {
                    _submitForm();
                    // You can navigate to another screen here
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep--;
                  } else {
                    _currentStep = 0;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
