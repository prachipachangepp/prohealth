import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';



class LabResultAddPopUp extends StatefulWidget {
  const LabResultAddPopUp({super.key});

  @override
  State<LabResultAddPopUp> createState() => _LabResultAddPopUpState();
}

class _LabResultAddPopUpState extends State<LabResultAddPopUp> {

  final TextEditingController _typeDocumentController = TextEditingController();
  final TextEditingController _nameDocumentController = TextEditingController();
  final TextEditingController _uploadDocumentController = TextEditingController();
  final List<String> _typeDocumentOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];


  String? _typeDocumentSelectedOption;
  String _selectedExpiryType = '';

  String _fileName = 'Upload';
  dynamic filePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: AppSize.s47,
        width: AppSize.s408,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Add New Lab Result',
                style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: ColorManager.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: AppSize.s475,
          width: AppSize.s350,
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height /60),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Type of the Document',
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.granitegray
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  Container(
                    height: 30,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      cursorHeight: 18,
                      controller: _typeDocumentController,
                      style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.greylight
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        labelText: 'Compliance Type 1',
                        labelStyle: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.greylight
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.containerBorderGrey,
                              width: AppSize.s1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.containerBorderGrey,
                              width: AppSize.s1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        suffixIcon: PopupMenuButton<String>(
                          icon: Align(
                            alignment: Alignment.center,
                              child: Icon(Icons.arrow_drop_down,
                                color: ColorManager.black,
                                size: AppSize.s18,)),
                          onSelected: (String value) {
                            setState(() {
                              _typeDocumentSelectedOption = value;
                              _typeDocumentController.text = value;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return _typeDocumentOptions.map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                value: value,
                                child: Text(value,
                                  style: TextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.greylight
                                  ),),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),




                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Name of the Document',
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.granitegray
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Container(
                    height: AppSize.s30,
                    child: TextFormField(
                      cursorColor: ColorManager.black,
                      cursorHeight: AppSize.s18,
                      controller: _nameDocumentController,
                      style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.greylight
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.containerBorderGrey,
                              width: AppSize.s1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.containerBorderGrey,
                              width: AppSize.s1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expiry Type',
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textPrimaryColor
                        ),
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        title: Text(
                          'Not Applicable',
                          style: TextStyle(
                              fontSize: FontSize.s10,
                              fontWeight: FontWeight.w400
                          ),),
                        value: 'Not Applicable',
                        groupValue: _selectedExpiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedExpiryType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                        title: Text(AppString.scheduled,
                          style: TextStyle(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeight.w400,
                          ),),
                        value: 'Scheduled',
                        groupValue: _selectedExpiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedExpiryType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        title: Text(
                          'Issuer Expiry',
                          style: TextStyle(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeight.w400,
                          ),),
                        value: 'Issuer Expiry',
                        groupValue: _selectedExpiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedExpiryType = value!;
                          });
                        },
                      ),
                    ],
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Upload Document',
                        style: TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textPrimaryColor
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Container(
                    height: AppSize.s30,
                    width: AppSize.s360,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.containerBorderGrey,
                        width: AppSize.s1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                _fileName,
                                style: TextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.greylight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: _pickFile,
                          icon: Icon(Icons.file_upload_outlined,
                              color: ColorManager.black),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text(AppString.submit,
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      backgroundColor: ColorManager.bluebottom,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}