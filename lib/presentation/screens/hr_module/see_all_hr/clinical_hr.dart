import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/drop_down.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../register/taxtfield_constant.dart';

class ClinicalHrScreen extends StatefulWidget {
  const ClinicalHrScreen({super.key});

  @override
  State<ClinicalHrScreen> createState() => _ClinicalHrScreenState();
}

class _ClinicalHrScreenState extends State<ClinicalHrScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Text(AppStringEM.srno,
                    style: AllHRTableHeading.customTextStyle(context)),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppStringEM.type,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text(AppStringEM.name,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(AppStringEM.location,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.specialization,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.edit,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        // Container(
        //   height: 32,
        //   width: 1400,
        //   child: Row(
        //     children: [
        //       Text(
        //           '01',
        //         style: TextStyle(
        //           fontSize: 10,
        //           fontWeight: FontWeight.w500,
        //           color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'RN',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'Dhillon Amarpreet',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'ProHealth Walnut Creek-EI Dorado Sacramento',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'Infection control',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         '01',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //     ],
        //   ),
        // )

        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                // int serialNumber =
                //     index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber =
                // serialNumber.toString().padLeft(2, '0');

                return Container(
                    margin: EdgeInsets.all(
                      5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: AppSize.s56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40.0),
                          child: Expanded(
                            flex: 1,
                            child: Text('1',
                                textAlign: TextAlign.center,
                                style: AllHRTableData.customTextStyle(context)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              // snapshot.data![index].empType.toString(),
                              "RN",
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              // snapshot.data![index].abbrivation.toString(),
                              'Dhillon Amarpreet',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)),
                        ),

                        Expanded(
                          flex: 3,
                          child: Text(
                              // snapshot.data![index].abbrivation.toString(),
                              'ProHealth Walnut Creek-EI Dorado Sacramento',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                              // snapshot.data![index].abbrivation.toString(),
                              'Infection control',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width / 20,
                        //     height: AppSize.s22,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8),
                        //       // color: snapshot.data![index].color?.toColor,
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ///edit
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditPopUp();
                                    },
                                  );
                                },
                                icon: Icon(Icons.edit_outlined, size: 18),
                                color: Color(
                                    0xff50B5E5), // Replace with your ColorManager.blueprime
                              ),

                              ///delete
                              IconButton(
                                onPressed: () {
                                  // showDialog(context: context,
                                  //     builder: (context) => DeletePopup(
                                  //         onCancel: (){
                                  //           Navigator.pop(context);
                                  //         }, onDelete: () async {
                                  //       await  allfromHrDelete(
                                  //           context, snapshot.data![index].employeeTypesId!);
                                  //       getAllHrDeptWise(context,widget.deptId).then((data){
                                  //         _controller.add(data);
                                  //       }).catchError((error){});
                                  //       Navigator.pop(context);
                                  //     }));
                                },
                                icon: Icon(
                                  size: 18,
                                  Icons.delete_outline,
                                  color: Color(0xffF6928A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }),
        )
      ],
    );
  }
}

class EditPopUp extends StatefulWidget {
  const EditPopUp({super.key});

  @override
  State<EditPopUp> createState() => _EditPopUpState();
}

class _EditPopUpState extends State<EditPopUp> {
  String? dropdownValue;

  TextEditingController _controller = TextEditingController();
  String? _selectedType;
  String? _selectedType1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        height: 32,
        width: 932,
        color: Color(0xff50B5E5),
        child: Row(
          children: [
            Text(
              'Edit',
              style: GoogleFonts.firaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Expanded(
          child: Container(
            color: ColorManager.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Upload Resume',
                            style: GoogleFonts.firaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.file_upload_outlined, color: Colors.white),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        backgroundColor: Color(0xff50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 100),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Upload Photo',
                            style: GoogleFonts.firaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.file_upload_outlined, color: Colors.white),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        backgroundColor: Color(0xff50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/100),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'First Name',
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Last Name',
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                        child: CustomDropdown(
                      labelText: 'Type of Clinician',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValue,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                    ),),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/60),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        labelText: 'Rating',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomDropdown(
                        labelText: 'Speciality',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomDropdown(
                        labelText: 'Reporting Office',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height/60),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        hintText: 'Select a Zone',
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff575757)
                        ),
                        labelText: 'Zone',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomDropdown(
                        hintText: 'Select a City',
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff575757)
                        ),
                        labelText: 'City',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomDropdown(
                        hintText: 'Select a Country',
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575757)
                        ),
                        labelText: 'Country',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/60),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        labelText: 'SSN',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                    ),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Personal Phone Number',
                      ),
                    ),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Work Phone Number',
                      ),
                    ),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height/60),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Personal email',
                      ),
                    ),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Work email',
                      ),
                    ),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomTextFieldRegister(
                        controller: _controller,
                        labelText: 'dd-mm-yyyy',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff50B5E5),
                            size: 16,
                          ),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              _controller.text =
                              "${pickedDate.toLocal()}"
                                  .split(' ')[0];
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height/60),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Personal email',
                      ),
                    ),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
            
                    Expanded(
                      child: CustomDropdown(
                        labelText: 'Status',
                        items: [
                          'option 1',
                          'option 2',
                          'option 3',
                          'option 4',
                        ],
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                    ),
            
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 120,
                    ),
                    Expanded(
                      child: CustomTextFieldRegister(
                        labelText: 'Driver’s License',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/140),
                Divider(
                  height: 50,
                  thickness: 3,
                  color: Color(0xffD9D9D9),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/80),
                Row(
                  children: [
                    Container(
                      height: 72,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12
                        )
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Gender',
                            style: GoogleFonts.firaSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Male',
                                    groupValue: _selectedType,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType = value;
                                      });
                                    },
                                    title: 'Male'),
                              ),
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Female',
                                    groupValue: _selectedType,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType = value;
                                      });
                                    },
                                    title: 'Female'),
                              ),
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Other',
                                    groupValue: _selectedType,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType = value;
                                      });
                                    },
                                    title: 'Other'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10,),
                    Container(
                      height: 72,
                      width: 780,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.black12
                          )
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Race',
                            style: GoogleFonts.firaSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Asian',
                                    groupValue: _selectedType1,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType1 = value;
                                      });
                                    },
                                    title: 'Asian'),
                              ),
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Black or African American',
                                    groupValue: _selectedType1,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType1 = value;
                                      });
                                    },
                                    title: 'Black or African American'),
                              ),
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'White',
                                    groupValue: _selectedType1,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType1 = value;
                                      });
                                    },
                                    title: 'White'),
                              ),
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Hispanic or Latino',
                                    groupValue: _selectedType1,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType1 = value;
                                      });
                                    },
                                    title: 'Hispanic or Latino'),
                              ),
                              Expanded(
                                child: CustomRadioListTile(
                                    value: 'Other',
                                    groupValue: _selectedType1,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedType1 = value;
                                      });
                                    },
                                    title: 'Other'),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
