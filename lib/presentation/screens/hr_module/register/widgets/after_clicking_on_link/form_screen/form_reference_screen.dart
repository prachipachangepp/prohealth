import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_reference_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_reference_data.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class ReferencesScreen extends StatefulWidget {
  final int employeeID;
  final Function onSave;
  final Function onBack;
  final Function onNext;
  const ReferencesScreen({
    super.key,
    required this.context,
    required this.employeeID, required this.onSave, required this.onBack, required this.onNext,
  });

  final BuildContext context;

  @override
  State<ReferencesScreen> createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  List<GlobalKey<_ReferencesFormState>> referenceFormKeys = [];
  bool isVisible = false;
  TextEditingController name = TextEditingController();
  TextEditingController titleposition = TextEditingController();
  TextEditingController companyorganization = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController knowthisperson = TextEditingController();
  TextEditingController lengthofassociation = TextEditingController();

  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    // referenceFormKeys.add(GlobalKey<_ReferencesFormState>());
    // addReferenseForm();
    _loadEducationData();
  }
  Future<void> _loadEducationData() async {
    try {
      List<ReferenceDataForm> prefilledData = await getEmployeeReferenceForm(context, widget.employeeID);
      if(prefilledData.isEmpty){
        addReferenseForm();
      }
      else{
        setState(() {
          referenceFormKeys = List.generate(
            prefilledData.length,
                (index) => GlobalKey<_ReferencesFormState>(),
          );
        });
      }

    } catch (e) {
      print('Error loading Education data: $e');
    }
  }
  void addReferenseForm() {
    setState(() {
      referenceFormKeys.add(GlobalKey<_ReferencesFormState>());
    });
  }

  void removeReferenseForm(GlobalKey<_ReferencesFormState> key) {
    setState(() {
      referenceFormKeys.remove(key);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
              AppString.references,
              style:FormHeading.customTextStyle(context)
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 60),
        Container(
          width: 952,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFE6F7FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Please provide the names and contact information of three professional references who can speak to your work experience and qualifications.\nFor each reference, Kindly include the following information:',
                      textAlign: TextAlign.center,
                      style:ZoneDataStyle.customTextStyle(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Column(
          children: referenceFormKeys.asMap().entries.map((entry) {
            int index = entry.key;
            GlobalKey<_ReferencesFormState> key = entry.value;
            return ReferencesForm(
              key: key,
              index: index + 1,
              onRemove: () => removeReferenseForm(key),
              employeeID: widget.employeeID,
              isVisible: isVisible,
            );
          }).toList(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Padding(
          padding: const EdgeInsets.only(left: 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: addReferenseForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff50B5E5),
                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                    'Add Reference',
                    style:BlueButtonTextConst.customTextStyle(context)
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.white,
              width: 117,
              height: 30,
              child: ElevatedButton(
                onPressed: ()async{
                  await widget.onBack();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManager.bluebottom,
                      width: 1,
                    ),
                  ),),
                child: Text('Previous',
                  style: TransparentButtonTextConst.customTextStyle(context),
                ),),
            ),
            const SizedBox(
              width: 30,
            ),

            isLoading
                ? SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
                : CustomButton(
              width: 117,
              height: 30,
              text: 'Save',
              style:BlueButtonTextConst.customTextStyle(context),
              borderRadius: 12,
              onPressed: () async {


                // Loop through each form and extract data to post

                setState(() {
                  isLoading = true; // Start loading
                });

                for (var key in referenceFormKeys) {
                  final st = key.currentState!;

                  if(st.isPrefill ==false){

                   var response = await postreferencescreenData(
                        context,
                        st.lengthofassociation.text,
                        "__",
                        st.companyorganization.text,
                        st.email.text,
                        st.widget.employeeID,
                        st.mobilenumber.text,
                        st.name.text,
                        st.knowthisperson.text,
                        st.titleposition.text);
                    if (response.statusCode == 200 || response.statusCode == 201){
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessPopup(
                            message: 'Reference Data Saved',
                          );
                        },
                      );
                      await  widget.onSave();
                      await _loadEducationData();
                    }


                  }
                  setState(() {
                    isLoading = false; // End loading
                  });

                }



                lengthofassociation.clear();
                companyorganization.clear();
                email.clear();
                mobilenumber.clear();
                name.clear();
                knowthisperson.clear();
                titleposition.clear();
              },

              child: Text(
                'Save',
                style: BlueButtonTextConst.customTextStyle(context),
              ),
            ),
            const SizedBox(
              width: AppSize.s30,
            ),
            Container(
              //color: Colors.white,
              width: 117,
              height: 30,
              child: ElevatedButton(
                onPressed: ()async{
                  await widget.onNext();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManager.bluebottom,
                      width: 1,
                    ),
                  ),),
                child: Text('Next',
                  style: TransparentButtonTextConst.customTextStyle(context),
                ),),
            ),
          ],
        ),
      ],
    );
  }
}

class ReferencesForm extends StatefulWidget {
  final int employeeID;
  final VoidCallback onRemove;
  final int index;
  final bool isVisible;
  const ReferencesForm(
      {Key? key,
        required this.onRemove,
        required this.index,
        required this.employeeID,
        required this.isVisible
      })
      : super(key: key);

  @override
  _ReferencesFormState createState() => _ReferencesFormState();
}

class _ReferencesFormState extends State<ReferencesForm> {
  bool isPrefill= true;
  TextEditingController name = TextEditingController();
  TextEditingController titleposition = TextEditingController();
  TextEditingController companyorganization = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController knowthisperson = TextEditingController();
  TextEditingController lengthofassociation = TextEditingController();
  int? referenseIndex;
  void initState() {
    super.initState();
    _initializeFormWithPrefilledData();

  }
  Future<void> _initializeFormWithPrefilledData() async {
    try {
      List<ReferenceDataForm> prefilledData = await getEmployeeReferenceForm(context, widget.employeeID);
      if (prefilledData.isNotEmpty) {
        var data = prefilledData[widget.index - 1]; // Assuming index matches the data list
        setState(() {
          name.text = data.name ?? '';
          titleposition.text = data.title ?? '';
          companyorganization.text = data.association ?? '';
          mobilenumber.text = data.mob ?? '';
          email.text = data.email ?? '';
          knowthisperson.text = data.references ?? '';
          lengthofassociation.text = data.association ?? '';
          referenseIndex = data.referenceId ?? 0;

        });
      }

    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }




  String? _nameError;
  String? _emailDocError;
  String? _lengthError;
  String? _addressDocError;
  String? _pPhoneDocError;
  String? _positionError;
  String? _OrganizationError;
  String? _KnowthisError;

  bool _isFormValid = true;
  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _nameError = _validateTextField(name.text, ' Name');
      _positionError = _validateTextField(titleposition.text, 'Position ');
      _OrganizationError = _validateTextField(companyorganization.text, 'Organization Name');
      _KnowthisError =
          _validateTextField(knowthisperson.text, ' Person Name');
      _pPhoneDocError =
          _validateTextField(mobilenumber.text, 'Phone Number');
      _emailDocError =
          _validateTextField(email.text, 'Email ID');
      _lengthError = _validateTextField(
          lengthofassociation.text, 'Length of Association');
      // _countryDocError =
      //     _validateTextField(widget.countryController.text, 'Country');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 160.0, right: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                referenseIndex == null ? 'References #${widget.index}' :  'References #${referenseIndex}',
                style:  HeadingFormStyle.customTextStyle(context),
              ),
              if (widget.index > 1)
                IconButton(
                  icon:
                  Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.name,
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: name,
                      hintText: 'Enter Name',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_nameError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _nameError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            40),
                    Text(
                      AppString.title_position,
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: titleposition,
                      hintText: 'Enter Position',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_positionError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _positionError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            40),
                    Text(
                      AppString.company_organization,
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: companyorganization,
                      hintText: 'Enter Organization Name',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_OrganizationError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _OrganizationError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            40),
                    Text(
                      AppString.mobile_number,
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegisterPhone(
                      controller: mobilenumber,
                      hintText: 'Enter Number',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_pPhoneDocError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _pPhoneDocError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.email,
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldForEmail(
                      controller: email,
                      hintText: 'Enter Email',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_emailDocError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _emailDocError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            40),
                    Text(
                      AppString.how_do_you_know_this_person,
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: knowthisperson,
                      hintText: 'Enter Text',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_KnowthisError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _KnowthisError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            40),
                    Text(
                      AppString.length_of_association,
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(
                        height:
                        MediaQuery.of(context).size.height /
                            60),
                    CustomTextFieldRegister(
                      controller: lengthofassociation,
                      hintText: 'Enter Length',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          isPrefill= false;
                        }
                      },
                    ),
                    if (_lengthError != null) // Display error if any
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          _lengthError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 20),
          Text(
            'Please ensure that the references you provide are professional contacts who can provide insight into \n your skills, work ethic, and character ',
            style: FileuploadString.customTextStyle(context),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 20),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          )
        ],
      ),
    );
  }
}

