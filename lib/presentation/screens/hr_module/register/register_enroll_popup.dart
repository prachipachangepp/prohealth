import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import '../../../widgets/custom_icon_button_constant.dart';
import '../../../widgets/mcq_const_widget/mcq_const_widget.dart';
///saloni

class RegisterEnrollAlertDialog {
  final TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;
  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              width: MediaQuery.of(context).size.width *0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Enroll',style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 14,
                        color: Color(0xff4B89BA),
                        fontWeight: FontWeight.w700,
                      ),),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon:Icon(Icons.close))
                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        CustomTextFieldRegister(
                          height: 26,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          //  cursorHeight: 15,
                          labelText: 'First Name',
                          keyboardType: TextInputType.text,
                          padding: EdgeInsets.only(bottom:5,left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Speciality',
                          keyboardType: TextInputType.text,
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Email',
                          keyboardType: TextInputType.text,
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Zone',
                          keyboardType: TextInputType.text,
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),

                      ],),
                      Column(children: [
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Last Name',
                          keyboardType: TextInputType.text,
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 25,
                          //cursorHeight: 15,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Type of Clinician',
                          keyboardType: TextInputType.text,
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'City',
                          keyboardType: TextInputType.text,
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 35,),
                      ],),
                      Column(children: [
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Phone Number',
                          keyboardType: TextInputType.text,
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 25,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Reporting Office',
                          keyboardType: TextInputType.text,
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        CustomTextFieldRegister(
                          height: 27,
                          width: MediaQuery.of(context).size.width/7,
                          controller: controller,
                          labelText: 'Country',
                          keyboardType: TextInputType.text,
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
                          padding: EdgeInsets.only(bottom:5, left: 20),
                          onChanged: (value) {
                            // Handle text change
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 35,),
                      ],),
                    ],),
                  SizedBox(height: 5,),
                  Divider(color: Color(0xffD9D9D9),thickness: 4,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      RegisterPopupMcq(
                        title: 'Employment',
                        items: [
                          'Full Time',
                          'Part Time',
                          'Per Diem'
                        ],
                        onChanged: (selectedIndex) {
                          print('Selected index: $selectedIndex');
                          _selectedItemIndex = selectedIndex;
                        },
                      ),
                      RegisterPopupMcq(title: 'Service',
                        items: [
                          'Home Health',
                          'Hospice',
                          'Home Care',
                          'Palliative Care'
                        ],)
                    ],),
                  ),
                  SizedBox(height: 6,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                          text: 'Next', onPressed: (){}),
                    ],),
                ],
              )
          ),
        );
      },
    );
  }
}
