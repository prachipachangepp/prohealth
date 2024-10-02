import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/constant_widgets/const_checckboxtile.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../widgets/dialogue_template.dart';
import '../../company_identity_zone/widgets/location_screen.dart';
import '../../whitelabelling/success_popup.dart';

class AddOfficeSumbitButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController mobNumController;
  final TextEditingController secNumController;
  final TextEditingController OptionalController;
  final List<ServicesMetaData> servicesList;
  //final Widget checkBoxHeadOffice;
  final Future<void> Function() onPressed;
  final GlobalKey<FormState> formKey;
  AddOfficeSumbitButton({
    super.key,
    required this.nameController,
    required this.addressController,
    required this.emailController,
    required this.mobNumController,
    required this.secNumController,
    required this.OptionalController,
    required this.onPressed,
    required this.formKey,
    required this.stateController,
    required this.countryController,
    required this.servicesList,
    // required this.checkBoxHeadOffice,
  });

  @override
  State<AddOfficeSumbitButton> createState() => _AddOfficeSumbitButtonState();
}

class _AddOfficeSumbitButtonState extends State<AddOfficeSumbitButton> {

  bool isLoading = false;

  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    widget.addressController.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCountyNameChanged() async {
    if (widget.addressController.text.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    final suggestions = await fetchSuggestions(widget.addressController.text);
    if (suggestions[0] == widget.addressController.text) {
      setState(() {
        _suggestions.clear();
      });
    } else if (widget.addressController.text.isEmpty) {
      setState(() {
        _suggestions = suggestions;
      });
    } else {
      setState(() {
        _suggestions = suggestions;
      });
    }
  }

  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = 'Lat/Long not selected'; // Default text
  double? _latitude;
  double? _longitude;
  void _pickLocation() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialLocation: _selectedLocation,
          onLocationPicked: (location) {
            // Print debug information to ensure this is being called
            print('Picked location inside MapScreen: $_selectedLocation');
            _location =
                'Lat: ${_selectedLocation.latitude}, Long: ${_selectedLocation.longitude}';
            setState(() {
              _latitude = location.latitude;
              _longitude = location.longitude;
              _location = 'Lat: ${_latitude!}, Long: ${_longitude!}';
              //_location = 'Lat: ${_latitude!}, Long: ${_longitude!}';
            });
          },
        ),
      ),
    );
    print("Picked location ${pickedLocation}");

    if (pickedLocation != null) {
      // Print debug information to ensure this is being reached
      print('Picked location from Navigator: $pickedLocation');
      setState(() {
        _selectedLocation = pickedLocation;
        _latitude = pickedLocation.latitude;
        _longitude = pickedLocation.longitude;
        _location =
            'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}';
        //_location = 'Lat: ${_latitude!}, Long: ${_longitude!}';
      });
    } else {
      print('No location was picked.');
    }
  }

  List<ServiceList> selectedServices = [];

  String? _nameDocError;
  String? _emailDocError;
  String? _stateDocError;
  String? _addressDocError;
  String? _pPhoneDocError;
  String? _sphoneDocError;
  String? _aphoneDocError;
  String? _countryDocError;

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
      _nameDocError = _validateTextField(widget.nameController.text, ' Office Name');
      _emailDocError = _validateTextField(widget.emailController.text, 'Email ID');
      _stateDocError = _validateTextField(widget.stateController.text, 'State');
      _addressDocError =
          _validateTextField(widget.addressController.text, 'Office Address');
      _pPhoneDocError =
          _validateTextField(widget.mobNumController.text, 'Primary Phone');
      _sphoneDocError =
          _validateTextField(widget.secNumController.text, 'Secondary Phone');
      _aphoneDocError = _validateTextField(
          widget.OptionalController.text, 'Alternative Phone');
      _countryDocError =
          _validateTextField(widget.countryController.text, 'Country');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s800,
      height: AppSize.s620,
      title: 'Add New Office',
      body: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FirstSMTextFConst(
                          controller: widget.nameController,
                          keyboardType: TextInputType.text,
                          text: AppStringEM.name,
                        ),
                        if (_nameDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              _nameDocError!,
                              style: CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s9),
                        DemailSMTextFConst(
                          controller: widget.emailController,
                          keyboardType: TextInputType.emailAddress,
                          text: AppString.email,
                        ),
                        if (_emailDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              _emailDocError!,
                              style: CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s9),
                        FirstSMTextFConst(
                          controller: widget.countryController,
                          keyboardType: TextInputType.text,
                          text: 'Country',
                        ),
                        if (_countryDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              _countryDocError!,
                              style:CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s9),
                        SMTextFConstPhone(
                          controller: widget.secNumController,
                          keyboardType: TextInputType.number,
                          text: 'Secondary Phone',
                        ),
                        if (_sphoneDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              _sphoneDocError!,
                              style: CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s14),
                        Text(
                          'Services',
                          style: AllPopupHeadings.customTextStyle(context),
                        ),
                        SizedBox(height: 3),
                        StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Container(
                              height: 100,
                              width: 300,
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Wrap(children: [
                                    ...List.generate(widget.servicesList.length,
                                        (index) {
                                      String serviceID =
                                          widget.servicesList[index].serviceId;
                                      bool isSelected =
                                          selectedServices.contains(serviceID);
                                      return Container(
                                          width: 150,
                                          child: Center(
                                            child: CheckboxTile(
                                              title: widget.servicesList[index]
                                                  .serviceName,
                                              initialValue: false,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == true) {
                                                    selectedServices.add(
                                                        ServiceList(
                                                            serviceId:
                                                                serviceID,
                                                            npiNumber: "",
                                                            medicareProviderId:
                                                                "",
                                                            hcoNumId: ""));
                                                  } else {
                                                    selectedServices
                                                        .remove(serviceID);
                                                  }
                                                });
                                                print(
                                                    "Service Id List ${selectedServices}");
                                              },
                                            ),
                                          ));
                                    })
                                  ]);
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    // SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSize.s7),
                        SMTextFConst(
                          controller: widget.addressController,
                          keyboardType: TextInputType.streetAddress,
                          text: AppString.officeaddress,
                        ),
                        if (_addressDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              _addressDocError!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: FontSize.s10,
                              ),
                            ),
                          ),
                        // widget.checkBoxHeadOffice,
                        const SizedBox(height: AppSize.s9),
                        FirstSMTextFConst(
                          controller: widget.stateController,
                          keyboardType: TextInputType.text,
                          text: 'State',
                        ),
                        if (_stateDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0.5),
                            child: Text(
                              _stateDocError!,
                              style: CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s9),
                        SMTextFConstPhone(
                          controller: widget.mobNumController,
                          keyboardType: TextInputType.number,
                          text: 'Primary Phone',
                        ),
                        if (_pPhoneDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 0.5),
                            child: Text(
                              _pPhoneDocError!,
                              style:CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s14),
                        SMTextFConstPhone(
                          controller: widget.OptionalController,
                          keyboardType: TextInputType.number,
                          text: 'Alternative Phone',
                        ),
                        if (_aphoneDocError != null) // Display error if any
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              _aphoneDocError!,
                              style:CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                        const SizedBox(height: AppSize.s12),
                        Row(
                          children: [
                            TextButton(
                              onPressed: _pickLocation,
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: Text(
                                'Pick Location',
                                style: TextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.bluelight,
                                  //decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.location_on_outlined,
                              color: ColorManager.granitegray,
                              size: AppSize.s18,
                            ),
                            Text(
                              _location,
                              style: TextStyle(
                                fontSize: FontSize.s14,
                                color: ColorManager.granitegray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
              if (_suggestions.isNotEmpty)
                Positioned(
                  top: 53,
                  right: 51,
                  child: Container(
                    height: 100,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _suggestions[index],
                            style: AllPopupHeadings.customTextStyle(context),
                          ),
                          onTap: () {
                            FocusScope.of(context)
                                .unfocus(); // Dismiss the keyboard
                            String selectedSuggestion = _suggestions[index];
                            widget.addressController.text = selectedSuggestion;

                            setState(() {
                              _suggestions.clear();
                              //_suggestions.removeWhere((suggestion) => suggestion == selectedSuggestion);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
            ]
                ),
          ],
        ),
      ],
      bottomButtons: isLoading
          ? SizedBox(
              height: AppSize.s25,
              width: AppSize.s25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
          : CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.add,
              onPressed: () async {
                _validateForm(); // Validate the form on button press

                if (_isFormValid) {
                  setState(() {
                    isLoading = true;
                  });

                  try {
                    print(
                        "Selected lat long ${_selectedLocation.latitude} + ${_selectedLocation.longitude}");
                    ApiData response = await addNewOffice(
                      context: context,
                      name: widget.nameController.text,
                      address: widget.addressController.text,
                      email: widget.emailController.text,
                      primaryPhone: widget.mobNumController.text,
                      secondaryPhone: widget.secNumController.text,
                      officeId: "",
                      lat: _selectedLocation.latitude.toString(),
                      long: _selectedLocation.longitude.toString(),
                      cityName: "",
                      stateName: widget.stateController.text,
                      country: widget.countryController.text,
                      isHeadOffice: false,
                    );

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print('Services List ${selectedServices}');
                      await addNewOfficeServices(
                        context: context,
                        officeId: response.officeId!,
                        serviceList: selectedServices,
                      );

                      // Navigate back first
                      Navigator.pop(context);

                      // Then show the success dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessPopup(
                            message: 'Added Successfully',
                          );
                        },
                      );
                    }

                    widget.stateController.clear();
                    widget.countryController.clear();
                    widget.nameController.clear();
                    widget.mobNumController.clear();
                    widget.addressController.clear();
                    widget.emailController.clear();
                    widget.secNumController.clear();
                    widget.OptionalController.clear();
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else {
                  print(
                      'Validation error: Please fill in all required fields.');
                }
              },
            ),
    );
  }
}


