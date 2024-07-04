import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/row_container_widget_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/mcq_widget_register.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/register_row_widget.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../widgets/widgets/profile_bar/profile_bar.dart';
import '../../em_module/widgets/button_constant.dart';
import '../../em_module/widgets/text_form_field_const.dart';
import '../manage/controller/controller.dart';


///saloni
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController _controller = Get.put(RegisterController());
    return Column(
      children: [
        // ProfileBar(),
        // SizedBox(height: AppSize.s10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [buildDropdownButton(context)],
            ),
            SizedBox(width:20,),
            Container(
              width: AppSize.s110,
              margin: EdgeInsets.only(right: AppMargin.m30),
              child: CustomIconButtonConst(
                  text: AppString.enroll,
                  onPressed: () {
                    _controller.openDialog(context);
                  }),
            ),
          ],
        ),
        SizedBox(height: AppSize.s20,),
        // Container(
        //   height: AppSize.s30,
        //   margin: EdgeInsets.symmetric(horizontal: AppMargin.m35),
        //   decoration: BoxDecoration(
        //     color: ColorManager.grey,
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.srNo,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //       Expanded(
        //           child: SizedBox(width: AppSize.s16,
        //       )),
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.name,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.code,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.phone,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.email,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.link,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //       Expanded(
        //           child: Center(
        //               child: Text(
        //                 AppString.status,
        //         style: RegisterTableHead.customTextStyle(context),
        //       ))),
        //     ],
        //   ),
        // ),
        // SizedBox(height: AppSize.s10,), // Adjust spacing as needed
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              ///update here
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            height: 179,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width / 50,
                                vertical: MediaQuery.of(context).size.height / 120,
                              ),
                              child: Container(
                                color: Colors.red,
                                child: Column(

                                  children: [
                                    Row(children: [
                                      Text('Ace Prabhu',
                                      style: GoogleFonts.firaSans(
                                        fontWeight: FontWeightManager.medium,
                                       // color: ColorManager.mediumgrey,
                                        color: Color(0xff333333),
                                        fontSize: FontSize.s13,
                                      ),),
                                      Row(children: [],)
                                    ],),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                      Text('Status',
                                      style: GoogleFonts.firaSans(
                                        fontWeight: FontWeightManager.medium,
                                       // color: ColorManager.mediumgrey,
                                        color: Color(0xff333333),
                                        fontSize: FontSize.s13,
                                      ),),
                                        SizedBox(width: MediaQuery.of(context).size.width/50,),
                                        Container(
                                          width: 10.0, // Adjust the size as needed
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width/50,),
                                        Text(
                                          'partial',
                                          style: GoogleFonts.firaSans(
                                            fontWeight: FontWeightManager.medium,
                                            color: Color(0xff333333),
                                            fontSize: FontSize.s13,
                                          ),
                                        ),
                                    ],),
                                    Column(

                                      children: [
                                        CustomRow(
                                          icon: Icons.person_2_outlined,
                                          text1: 'Code',
                                          text2: '351631',
                                        ),
                                        CustomRow(
                                          icon: Icons.phone_outlined,
                                          text1: 'Phone',
                                          text2: '+13473522252',
                                        ),
                                        CustomRow(
                                          icon: Icons.email_outlined,
                                          text1: 'Email',
                                          text2: 'ace@dpblr.com',
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.link, size: 15,color: ColorManager.mediumgrey),
                                            SizedBox(width: MediaQuery.of(context).size.width/40),
                                            Text(
                                                'Link',
                                              style: GoogleFonts.firaSans(fontSize: 10, fontWeight: FontWeight.w400,color: ColorManager.mediumgrey)
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width/40),
                                            TextButton(
                                                onPressed: () {},
                                                child: Text('https://prohealth.symmetry.care/register',
                                                style: GoogleFonts.firaSans(fontSize: 10, fontWeight: FontWeight.w400,color: ColorManager.blueprime)),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 50),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              ///update here
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            height: 179,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width / 50,
                                vertical: MediaQuery.of(context).size.height / 120,
                              ),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Text('Ace Prabhu',
                                      style: GoogleFonts.firaSans(
                                        fontWeight: FontWeightManager.medium,
                                        // color: ColorManager.mediumgrey,
                                        color: Color(0xff333333),
                                        fontSize: FontSize.s13,
                                      ),),
                                    Row(children: [],)
                                  ],),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Status',
                                        style: GoogleFonts.firaSans(
                                          fontWeight: FontWeightManager.medium,
                                          // color: ColorManager.mediumgrey,
                                          color: Color(0xff333333),
                                          fontSize: FontSize.s13,
                                        ),),
                                      SizedBox(width: MediaQuery.of(context).size.width/50,),
                                      Container(
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xff51B5E6),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width/100,),
                                      Text(
                                        'Opened',
                                        style: GoogleFonts.firaSans(
                                          fontWeight: FontWeightManager.medium,
                                          color: Color(0xff51B5E6),
                                          fontSize: FontSize.s13,
                                        ),
                                      ),
                                    ],),
                                  Column(
                                    children: [
                                      CustomRow(
                                        icon: Icons.person_2_outlined,
                                        text1: 'Code',
                                        text2: '351631',
                                      ),
                                      CustomRow(
                                        icon: Icons.phone_outlined,
                                        text1: 'Phone',
                                        text2: '+13473522252',
                                      ),
                                      CustomRow(
                                        icon: Icons.email_outlined,
                                        text1: 'Email',
                                        text2: 'ace@dpblr.com',
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.link),
                                          SizedBox(width: 8),
                                          Text(
                                            'Link',
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          SizedBox(width: 80),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text('https://prohealth.symmetry.care/register',
                                                style: TextStyle(
                                                  color: Color(0xff51B5E6),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    // SizedBox(height: AppSize.s5),
                    // Container(
                    //   padding: EdgeInsets.only(bottom: AppPadding.p5),
                    //   margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
                    //   decoration: BoxDecoration(
                    //     color:ColorManager.red,
                    //     borderRadius: BorderRadius.circular(4),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: ColorManager.grey.withOpacity(0.5),
                    //         spreadRadius: 1,
                    //         blurRadius: 4,
                    //         offset: Offset(0, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   height: AppSize.s56,
                    //
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Expanded(
                    //         child: Center(
                    //             child: Text(
                    //           '1',style: ThemeManagerDark.customTextStyle(context),
                    //           textAlign: TextAlign.start,
                    //         )),
                    //       ),
                    //       Expanded(
                    //         child: CircleAvatar(
                    //           radius: 15,
                    //           backgroundColor: ColorManager.blueprime,
                    //           child: Image.asset('images/profile.png'),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Center(
                    //             child: Text(
                    //           AppString.amogh,
                    //           textAlign: TextAlign.start,
                    //           style: ThemeManagerDark.customTextStyle(context),
                    //         )),
                    //       ),
                    //       Expanded(
                    //         child: Center(
                    //             child: Text(
                    //           AppString.pincode,
                    //           style: ThemeManagerDark.customTextStyle(context),
                    //         )),
                    //       ),
                    //       Expanded(
                    //         child: Center(
                    //             child: Text(
                    //           AppString.mobile,
                    //           style: ThemeManagerDark.customTextStyle(context),
                    //         )),
                    //       ),
                    //       Expanded(
                    //         child: Center(
                    //             child: Text(
                    //           AppString.mail,
                    //           style: ThemeManagerDark.customTextStyle(context),
                    //         )),
                    //       ),
                    //       Center(
                    //           child: Text(
                    //         AppString.path +'$index',
                    //         style: ThemeManagerDark.customTextStyle(context),
                    //       )),
                    //       Expanded(
                    //         child: Center(
                    //             child: Text(
                    //           AppString.open,
                    //           style: ThemeManagerDark.customTextStyle(context),
                    //         )),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


Widget buildDropdownButton(BuildContext context) {
  return Container(
    height: 31,
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xff50B5E5), width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xff000000).withOpacity(0.25),
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: DropdownButton<String>(
      value: 'Select',
      style: GoogleFonts.firaSans(
        fontSize: 12,
        fontWeight: FontWeightManager.bold,
        color: Color(0xff50B5E5),
        decoration: TextDecoration.none,
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Color(0xff50B5E5),
      ),
      iconSize: 20,
      underline: SizedBox(),
      onChanged: (String? newValue) {
        // Show popup or AlertDialog
        if (newValue != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController addressController = TextEditingController();
              TextEditingController emailController = TextEditingController();
              final TextEditingController controller = TextEditingController();
              final TextEditingController firstName = TextEditingController();
              final TextEditingController lastName = TextEditingController();
              final TextEditingController phone = TextEditingController();
              final TextEditingController email = TextEditingController();
              FocusNode _focusNode = FocusNode();
              int? _selectedItemIndex;
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
                            Text(AppString.enroll,
                              style: CustomTextStylesCommon.commonStyle(
                                fontSize: FontSize.s14,
                                color: ColorManager.primary,
                                fontWeight: FontWeightManager.bold,
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
                                height: AppSize.s26,
                                width: MediaQuery.of(context).size.width/7,
                                controller: firstName,
                                labelText: AppString.fname,
                                keyboardType: TextInputType.text,
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s10,),
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: controller,
                                labelText: AppString.speciality,
                                keyboardType: TextInputType.text,
                                suffixIcon: Icon(Icons.arrow_drop_down,
                                  color: ColorManager.blueprime,),
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s10,),
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: email,
                                labelText: AppString.email,
                                keyboardType: TextInputType.text,
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppPadding.p10,),
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: controller,
                                labelText: AppString.zone,
                                keyboardType: TextInputType.text,
                                suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {

                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),

                            ],),
                            Column(children: [
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: lastName,
                                labelText: AppString.lname,
                                keyboardType: TextInputType.text,
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {

                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s10,),
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                //cursorHeight: 15,
                                width: MediaQuery.of(context).size.width/7,
                                controller: controller,
                                labelText: AppString.typeClinician,
                                keyboardType: TextInputType.text,
                                suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {

                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s10,),
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: controller,
                                labelText: AppString.city,
                                keyboardType: TextInputType.text,
                                suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {                          },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s35,),
                            ],),
                            Column(children: [
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: phone,
                                labelText: AppString.phoneNumber,
                                keyboardType: TextInputType.text,
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s10,),
                              CustomTextFieldRegister(
                                height: AppSize.s25,
                                width: MediaQuery.of(context).size.width/7,
                                controller: controller,
                                labelText: AppString.reportingOffice,
                                keyboardType: TextInputType.text,
                                suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s10,),
                              CustomTextFieldRegister(
                                height: AppSize.s27,
                                width: MediaQuery.of(context).size.width/7,
                                controller: controller,
                                labelText: AppString.country,
                                keyboardType: TextInputType.text,
                                suffixIcon: Icon(Icons.arrow_drop_down,color: ColorManager.blueprime,),
                                padding: EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                                onChanged: (value) {
                                  // Handle text change
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppString.enterText;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: AppSize.s35,),
                            ],),
                          ],),
                        SizedBox(height: AppSize.s5,),
                        Divider(color: ColorManager.cream,thickness: 4,),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RegisterPopupMcq(
                                title: AppString.employment,
                                items: [
                                  AppString.fullTime,
                                  AppString.partTime,
                                  AppString.perDiem
                                ],
                                onChanged: (selectedIndex) {
                                  print(AppString.selectIndex+'$selectedIndex');
                                  _selectedItemIndex = selectedIndex;
                                },
                              ),
                              RegisterPopupMcq(title: AppString.service,
                                items: [
                                  AppString.homeHealth,
                                  AppString.hospice,
                                  AppString.homeCare,
                                  AppString.palliative
                                ],)
                            ],),
                        ),
                        SizedBox(height: AppSize.s6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButtonConst(
                                text: AppString.next, onPressed: (){}),
                          ],),
                      ],
                    )
                ),
              );
                // AlertDialog(
                //   backgroundColor: Colors.white,
                //   content: Container(
                //     height: 343,
                //     width: 409,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             IconButton(
                //                 onPressed: () {
                //                   Navigator.pop(context);
                //                 },
                //                 icon: Icon(Icons.close))
                //           ],
                //         ),
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             SMTextFConst(
                //               controller: nameController,
                //               keyboardType: TextInputType.text,
                //               text: 'Type of Visit',
                //             ),
                //             SizedBox(
                //               height: 25,
                //             ),
                //             SMTextFConst(
                //               controller: addressController,
                //               keyboardType: TextInputType.streetAddress,
                //               text: 'Zone',
                //             ),
                //             SizedBox(
                //               height: 25,
                //             ),
                //             SMTextFConst(
                //               controller: emailController,
                //               keyboardType: TextInputType.emailAddress,
                //               text: 'Rate',
                //             ),
                //           ],
                //         ),
                //         SizedBox(
                //           height: 60,
                //         ),
                //         CustomElevatedButton(
                //             width: 105,
                //             height: 31,
                //             text: 'Submit',
                //             onPressed: () {
                //               // Navigator.push(
                //               //     context,
                //               //     MaterialPageRoute(
                //               //         builder: (context) =>
                //               //             LoginScreen()));
                //             })
                //       ],
                //     ),
                //   ));
            },
          );
        }
      },
      items: <String>[
        'Select',
        'Opened',
        'Not opened',
        'Partial',
        'Complete',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: ColorManager.blueprime),
          ),
        );
      }).toList(),
    ),
  );
}
