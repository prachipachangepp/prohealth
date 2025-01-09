import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'package:provider/provider.dart';

/// create user provider class
class UserCreationProvider with ChangeNotifier {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _nameDocError;
  String? _emailDocError;
  String? _stateDocError;
  String? _passwordDocError;

  bool isLoading = false;
  bool _isFormValid = true;

  // Getter methods for error messages
  String? get nameDocError => _nameDocError;
  String? get emailDocError => _emailDocError;
  String? get stateDocError => _stateDocError;
  String? get passwordDocError => _passwordDocError;

  bool get isFormValid => _isFormValid;

  void clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    _isFormValid = true;
    notifyListeners();
  }


  void validateForm() {
    _isFormValid = true;
    _nameDocError = _validateTextField(firstNameController.text, 'First Name');
    _emailDocError = _validateTextField(emailController.text, 'Email');
    _stateDocError = _validateTextField(lastNameController.text, 'Last Name');
    _passwordDocError = _validateTextField(passwordController.text, 'Password');

    if (_nameDocError != null || _emailDocError != null || _stateDocError != null || _passwordDocError != null) {
      _isFormValid = false;
    }

    notifyListeners();
  }


  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      return "Please Enter $fieldName";
    }
    return null;
  }

  /// Method to create a user (simulate API call)
  Future<void> createUser(BuildContext context) async {
    validateForm();

    if (!_isFormValid) return;

    isLoading = true;
    notifyListeners();

    try {

      await Future.delayed(Duration(seconds: 2));

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('User Created Successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );


      clearForm();
    } catch (e) {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Error: ${e.toString()}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}



/// dept dropdown provider class
class DepartmentProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<HRHeadBar> _departments = [];
  String? _selectedDeptName;
  int? _selectedDeptId;

  bool get isLoading => _isLoading;
  List<HRHeadBar> get departments => _departments;
  String? get selectedDeptName => _selectedDeptName;
  int? get selectedDeptId => _selectedDeptId;

  void setSelectedDept(String? deptName) {
    _selectedDeptName = deptName;
    _selectedDeptId = _departments
        .firstWhere((dept) => dept.deptName == deptName)
        .deptId;
    notifyListeners();
  }

  Future<void> fetchDepartments(BuildContext context, int deptId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Pass the BuildContext to the companyHRHeadApi function
      _departments = await companyHRHeadApi(context, deptId);
    } catch (e) {
      // Handle error
      _departments = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
///with provider
class UserFormProvider extends ChangeNotifier {
  bool _isFormValid = true;
  bool _isLoading = false;
  String? _nameDocError;
  String? _emailDocError;
  String? _stateDocError;
  String? _PasswordDocError;

  bool get isFormValid => _isFormValid;
  bool get isLoading => _isLoading;
  String? get nameDocError => _nameDocError;
  String? get emailDocError => _emailDocError;
  String? get stateDocError => _stateDocError;
  String? get passwordDocError => _PasswordDocError;

  void validateForm(
      String firstName,
      String lastName,
      String email,
      String password,
      ) {
    _isFormValid = true;
    _nameDocError = _validateTextField(firstName, 'First Name');
    _emailDocError = _validateTextField(email, 'Email');
    _stateDocError = _validateTextField(lastName, 'Last Name');
    _PasswordDocError = _validateTextField(password, 'Password');

    if (_nameDocError != null || _emailDocError != null || _stateDocError != null || _PasswordDocError != null) {
      _isFormValid = false;
    }

    notifyListeners();
  }

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      return "Please Enter $fieldName";
    }
    return null;
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
///

///CustomDialoghSEE using provider
class CustomDialoghSEE extends StatelessWidget {
  final String title;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController passwordController;

  CustomDialoghSEE({
    required this.title,
    required this.lastNameController,
    required this.emailController,
    required this.firstNameController,
    required this.passwordController,
  });

  var deptId = 1;
  String? selectedDeptName; // Define selectedDeptName
  int? selectedDeptId; // Define selectedDeptId

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserFormProvider(),
      child: Consumer<UserFormProvider>(
        builder: (context, formProvider, child) {
          return DialogueTemplate(
            width: 410,
            height: 550,
            title: title,
            onClear: () {
              firstNameController.clear();
              lastNameController.clear();
              emailController.clear();
              passwordController.clear();
              Navigator.pop(context);
            },
            body: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SMTextfieldAsteric(
                      controller: firstNameController,
                      keyboardType: TextInputType.text,
                      text: "First Name",
                    ),
                    if (formProvider.nameDocError != null)
                      Text(
                        formProvider.nameDocError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 5),
                    SMTextfieldAsteric(
                      controller: lastNameController,
                      keyboardType: TextInputType.text,
                      text: "Last Name",
                    ),
                    if (formProvider.stateDocError != null)
                      Text(
                        formProvider.stateDocError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 10),
                    // Department Dropdown
                    RichText(
                      text: TextSpan(
                        text: "Select Department",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    // FutureBuilder for fetching departments
                    FutureBuilder<List<HRHeadBar>>(
                      future: companyHRHeadApi(context, deptId), // Pass the context first
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          List<String> dropDownServiceList = [];
                          return Container(
                              alignment: Alignment.center,
                              child: HRUManageDropdown(
                                controller: TextEditingController(text: ''),
                                labelFontSize: FontSize.s12,
                                items: dropDownServiceList,
                              ));
                        }
                        if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              ErrorMessageString.noroleAdded,
                              style: AllNoDataAvailable.customTextStyle(context),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          List<String> dropDownServiceList = snapshot
                              .data!
                              .map((dept) => dept.deptName!)
                              .toList();
                          String? firstDeptName = snapshot.data!.isNotEmpty
                              ? snapshot.data![0].deptName
                              : null;
                          int? firstDeptId = snapshot.data!.isNotEmpty
                              ? snapshot.data![0].deptId
                              : null;

                          if (selectedDeptName == null && dropDownServiceList.isNotEmpty) {
                            selectedDeptName = firstDeptName;
                            selectedDeptId = firstDeptId;
                          }

                          return StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return HRUManageDropdown(
                                controller: TextEditingController(text: selectedDeptName ?? ''),
                                hintText: "Department",
                                labelFontSize: FontSize.s12,
                                items: dropDownServiceList,
                                onChanged: (val) {
                                  setState(() {
                                    selectedDeptName = val;
                                    // Find the corresponding department ID from the snapshot
                                    selectedDeptId = snapshot.data!
                                        .firstWhere((dept) => dept.deptName == val)
                                        .deptId;
                                  });
                                },
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),

                    ///
                    // FutureBuilder<List<HRHeadBar>>(
                    //   future: companyHRHeadApi(context, deptId),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return CircularProgressIndicator();
                    //     }
                    //     if (snapshot.hasData) {
                    //       return DropdownButton<String>(
                    //         items: snapshot.data!
                    //             .map((dept) => DropdownMenuItem<String>(
                    //           value: dept,
                    //           child: Text(dept),
                    //         ))
                    //             .toList(),
                    //         onChanged: (value) {
                    //           // Handle department selection
                    //         },
                    //       );
                    //     }
                    //     return SizedBox();
                    //   },
                    // ),
                    ///
                    SizedBox(height: 14),
                    SMTextfieldAsteric(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      text: 'Email',
                    ),
                    if (formProvider.emailDocError != null)
                      Text(
                        formProvider.emailDocError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomTextFieldWithIcon(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      text: "Password",
                      cursorHeight: 12,
                      hintText: "Password",
                      onSuffixIconPressed: () {
                        Clipboard.setData(ClipboardData(text: passwordController
                            .text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied to clipboard')),
                        );
                      },  labelFontSize: 12,
                    ),
                    if (formProvider.passwordDocError != null)
                      Text(
                        formProvider.passwordDocError!,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ],
            bottomButtons: formProvider.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                formProvider.validateForm(
                  firstNameController.text,
                  lastNameController.text,
                  emailController.text,
                  passwordController.text,
                );

                if (formProvider.isFormValid) {
                  formProvider.setLoading(true);
                  try {
                    // Perform the API call here
                    var response = await createUserPost(
                      context,                  // Pass the BuildContext as the first argument
                      firstNameController.text, // String
                      lastNameController.text,  // String
                      selectedDeptId!,          // int (ensure selectedDeptId is not null)
                      emailController.text,     // String
                      passwordController.text,  // String
                    );

                    if (response.success) {
                      Navigator.pop(context);
                      // Show success dialog
                    } else {
                      // Show error message
                      print(response.message); // Log the error message
                    }
                  } catch (e) {
                    // Handle error
                    print("Error: $e");
                  } finally {
                    formProvider.setLoading(false);
                  }
                }
              },
              child: Text('Create'),
            ),


            ///
            // ElevatedButton(
            //   onPressed: () async {
            //     formProvider.validateForm(
            //       firstNameController.text,
            //       lastNameController.text,
            //       emailController.text,
            //       passwordController.text,
            //     );
            //     if (formProvider.isFormValid) {
            //       formProvider.setLoading(true);
            //       try {
            //         // Perform the API call here
            //         var response = await createUserPost(
            //           firstNameController.text,
            //           lastNameController.text,
            //           selectedDeptId!,
            //           emailController.text,
            //           passwordController.text,
            //         );
            //         if (response.success) {
            //           Navigator.pop(context);
            //           // Show success dialog
            //         } else {
            //           // Show error message
            //         }
            //       } catch (e) {
            //         // Handle error
            //       } finally {
            //         formProvider.setLoading(false);
            //       }
            //     }
            //   },
            //   child: Text('Create'),
            // ),
          );
        },
      ),
    );
  }
}