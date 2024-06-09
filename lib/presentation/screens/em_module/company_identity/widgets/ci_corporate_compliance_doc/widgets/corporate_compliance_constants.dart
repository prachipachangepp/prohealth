import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/theme_manager.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';

///add popup
class CCScreensAddPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController zipcodeController;
  final VoidCallback onSavePressed;
  final Widget child;
  final Widget child1;
  const CCScreensAddPopup(
      {super.key,
      required this.countynameController,
      required this.zipcodeController,
      required this.onSavePressed, required this.child, required this.child1});

  @override
  State<CCScreensAddPopup> createState() => _CCScreensAddPopusState();
}

class _CCScreensAddPopusState extends State<CCScreensAddPopup> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s420,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.countynameController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
                  ),
                  SizedBox(height: AppSize.s15),
                  SMTextFConst(
                    controller: widget.zipcodeController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ),
                  SizedBox(height: AppSize.s15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Type of the Document',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      //decoration: TextDecoration.none,
                    ),
                    ),
                    SizedBox(height: 5,),
                    widget.child
                  ],),

                  SizedBox(height: AppSize.s15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Sub Type of the Document',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 5,),
                    widget.child1
                  ],),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p50),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.add,
                  onPressed: () {
                    widget.onSavePressed();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///dropdown constant
class CICCDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final String? initialValue;

  const CICCDropdown({
    Key? key,
    required this.items,
    this.initialValue,
  }) : super(key: key);

  @override
  _CIDetailsDropdownState createState() => _CIDetailsDropdownState();
}

class _CIDetailsDropdownState extends State<CICCDropdown> {
  String? _selectedValue;
  GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }
  void _showCustomDropdown() async {
    final RenderBox renderBox = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy + size.height, offset.dx + size.width, 0),
      items: widget.items.map((DropdownMenuItem<String> item) {
        return PopupMenuItem<String>(
          value: item.value,
          child: Container(
            width: size.width - 16, ///minus padding/margin
            child: Text(item.value ?? ''),
          ),
        );
      }).toList(),
      color: ColorManager.white,
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: _dropdownKey,
          width: 354,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  _selectedValue ?? '',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _showCustomDropdown,
                child: Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///edit popup
class CCScreenEditPopup extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final VoidCallback onSavePressed;
  final Widget child;
  final Widget child1;

  const CCScreenEditPopup({
    super.key,
    required this.idDocController,
    required this.nameDocController,
    required this.onSavePressed,
    required this.child,
    required this.child1,
  });

  @override
  State<CCScreenEditPopup> createState() => _CCScreenEditPopupState();
}

class _CCScreenEditPopupState extends State<CCScreenEditPopup> {
  String? _expiryType;
  TextEditingController calenderController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p3,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SMTextFConst(
              controller: widget.idDocController,
              keyboardType: TextInputType.text,
              text: 'ID of the Document',
            ), SizedBox(height: AppSize.s8),
            SMTextFConst(
              controller: widget.nameDocController,
              keyboardType: TextInputType.text,
              text: 'Name of the Document',
            ),
            SizedBox(height: AppSize.s8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type of the Document',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    //decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 5),
                widget.child,
              ],
            ),
            SizedBox(height: AppSize.s12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sub Type of the Document',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 5),
                widget.child1,
              ],
            ),
          ],
        ),
      ),
      ///radio
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p3,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expiry Type',
              style: GoogleFonts.firaSans(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
                decoration: TextDecoration.none,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<String>(
                  title: Text('Not Applicable',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s10,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),),
                  value: 'type1',
                  groupValue: _expiryType,
                  onChanged: (value) {
                    setState(() {
                      _expiryType = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Scheduled',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s10,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),),
                  value: 'type2',
                  groupValue: _expiryType,
                  onChanged: (value) {
                    setState(() {
                      _expiryType = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title:  Text('Issuer Expiry',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s10,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),),
                  value: 'type3',
                  groupValue: _expiryType,
                  onChanged: (value) {
                    setState(() {
                      _expiryType = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p3,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expiry Date',
              style: GoogleFonts.firaSans(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
                decoration: TextDecoration.none,
              ),
            ),
            FormField<String>(
              builder: (FormFieldState<String> field) {
                return SizedBox(
                  width: 354,
                  height: 30,
                  child: TextFormField(
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      //decoration: TextDecoration.none,
                    ),
                    controller: calenderController,
                    decoration: InputDecoration(
                      focusColor: ColorManager.mediumgrey,
                      hoverColor: ColorManager.mediumgrey,
                      hintText: 'dd-mm-yyyy',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.mediumgrey,
                        //decoration: TextDecoration.none,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1,color: ColorManager.mediumgrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1, color:ColorManager.mediumgrey), // Set focused border color to red
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1, color: ColorManager.mediumgrey), // Set enabled border color to red
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime),
                      errorText: field.errorText,
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1100),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        String formattedDate = DateFormat('dd-MM-yyyy').format(date);
                        calenderController.text = formattedDate;
                        field.didChange(formattedDate);
                        // birthdayController.text =
                        // date.toLocal().toString().split(' ')[0];
                        // field.didChange(date.toLocal().toString().split(' ')[0]);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please select birth date';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.p10),
        child: Center(
          child: CustomElevatedButton(
            width: AppSize.s105,
            height: AppSize.s30,
            text: AppStringEM.submit,
            onPressed: () {
              widget.onSavePressed();
              Navigator.pop(context);
            },
          ),
        ),
      ),
      ],

    ),
      ),
    );
  }
}
///
class AddOrgDocButton extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final VoidCallback onSavePressed;
  final Widget child;
  final Widget child1;
  const AddOrgDocButton({super.key, required this.idDocController, required this.nameDocController, required this.onSavePressed, required this.child, required this.child1});

  @override
  State<AddOrgDocButton> createState() => _AddOrgDocButtonState();
}

class _AddOrgDocButtonState extends State<AddOrgDocButton> {
  String? _expiryType;
  TextEditingController birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s500,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.idDocController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ), SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type of the Document',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.child,
                    ],
                  ),
                  SizedBox(height: AppSize.s12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sub Type of the Document',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.child1,
                    ],
                  ),
                ],
              ),
            ),
            ///radio
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Type',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: Text('Not Applicable',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),),
                        value: 'type1',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('Scheduled',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),),
                        value: 'type2',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title:  Text('Issuer Expiry',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),),
                        value: 'type3',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> field) {
                      return SizedBox(
                        width: 354,
                        height: 30,
                        child: TextFormField(
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            //decoration: TextDecoration.none,
                          ),
                          controller: birthdayController,
                          decoration: InputDecoration(
                            hintText: 'dd-mm-yyyy',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.mediumgrey,
                              //decoration: TextDecoration.none,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime),
                            errorText: field.errorText,
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1100),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              birthdayController.text = date.toLocal().toString().split('')[0];
                                  // DateFormat('dd-mm-yyyy').format(_selectedDate);
                              field.didChange(date.toLocal().toString().split(' ')[0]);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please select birth date';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
             Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.save,
                  onPressed: () {
                    widget.onSavePressed();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
