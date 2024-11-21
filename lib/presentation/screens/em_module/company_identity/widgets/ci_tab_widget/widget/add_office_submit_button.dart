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
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
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
      height: AppSize.s650,
      title: 'Add New Office',
      body: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                        Text(
                          _nameDocError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      const SizedBox(height: AppSize.s9),
                      DemailSMTextFConst(
                        controller: widget.emailController,
                        keyboardType: TextInputType.emailAddress,
                        text: AppString.email,
                      ),
                      if (_emailDocError != null) // Display error if any
                        Text(
                          _emailDocError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      const SizedBox(height: AppSize.s9),
                      FirstSMTextFConst(
                        controller: widget.countryController,
                        keyboardType: TextInputType.text,
                        text: 'Country',
                      ),
                      if (_countryDocError != null) // Display error if any
                        Text(
                          _countryDocError!,
                          style:CommonErrorMsg.customTextStyle(context),
                        ),
                      const SizedBox(height: AppSize.s9),
                      SMTextFConstPhone(
                        controller: widget.secNumController,
                        keyboardType: TextInputType.number,
                        text: 'Secondary Phone',
                      ),
                      if (_sphoneDocError != null) // Display error if any
                        Text(
                          _sphoneDocError!,
                          style: CommonErrorMsg.customTextStyle(context),
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
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AddressInput(
                        controller:  widget.addressController,
                        onSuggestionSelected: (selectedSuggestion) {
                          // Handle the selected suggestion here
                          print("Selected suggestion: $selectedSuggestion");
                        },
                        onChanged: (String value) {
                          // Validate when user types in the address field
                          setState(() {
                            if (value.isEmpty) {
                              _addressDocError = 'Address cannot be empty';
                            } else {
                              _addressDocError = null; // Clear error if text is entered
                            }
                          });
                        },
                      ),

                      // SMTextFConst(
                      //   controller: widget.addressController,
                      //   keyboardType: TextInputType.streetAddress,
                      //   text: AppString.officeaddress,
                      // ),
                      if (_addressDocError != null) // Display error if any
                        Text(
                          _addressDocError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: FontSize.s10,
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
                        Text(
                          _stateDocError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      const SizedBox(height: AppSize.s9),
                      SMTextFConstPhone(
                        controller: widget.mobNumController,
                        keyboardType: TextInputType.number,
                        text: 'Primary Phone',
                      ),
                      if (_pPhoneDocError != null) // Display error if any
                        Text(
                          _pPhoneDocError!,
                          style:CommonErrorMsg.customTextStyle(context),
                        ),
                      const SizedBox(height: AppSize.s10),
                      SMTextFConstPhone(
                        controller: widget.OptionalController,
                        keyboardType: TextInputType.number,
                        text: 'Alternative Phone',
                      ),
                      if (_aphoneDocError != null) // Display error if any
                        Text(
                          _aphoneDocError!,
                          style:CommonErrorMsg.customTextStyle(context),
                        ),
                      const SizedBox(height: AppSize.s10),
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




class AddressInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSuggestionSelected;
  final Function(String) onChanged;// Callback to notify parent

  AddressInput({required this.controller, this.onSuggestionSelected, required this.onChanged});

  @override
  _AddressInputState createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  List<String> _suggestions = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCountyNameChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onCountyNameChanged() async {
    final query = widget.controller.text;
    if (query.isEmpty) {
      _suggestions.clear();
      _removeOverlay();
      return;
    }

    final suggestions = await fetchSuggestions(query);
    setState(() {
      _suggestions = suggestions.isNotEmpty && suggestions[0] != query ? suggestions : [];
    });
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    if (_suggestions.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
          children:[
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(
                color: Colors.transparent, // Make this transparent so it's invisible
              ),
            ),Positioned(
              left: position.dx,
              top: position.dy + renderBox.size.height,
              width: 354,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: _suggestions.length > 5 ? 80.0 : double.infinity,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _suggestions[index],
                            style: TableSubHeading.customTextStyle(context),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            widget.controller.text = _suggestions[index];
                            _suggestions.clear();
                            _removeOverlay();

                            // Call the callback with the selected suggestion
                            if (widget.onSuggestionSelected != null) {
                              widget.onSuggestionSelected!(_suggestions[index]);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        SMTextFConst(
          controller: widget.controller,
          keyboardType: TextInputType.streetAddress,
          text: AppString.officeaddress,
        ),
        // Row(
        //   children: [
        //     Text(
        //       'Address',
        //       style:AllPopupHeadings.customTextStyle(context),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //     height:
        //     MediaQuery.of(context).size.height / 60),
        // CustomTextFieldRegister(
        //   controller: widget.controller,
        //   hintText: 'Enter Address',
        //   hintStyle: onlyFormDataStyle.customTextStyle(context),
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please enter some text';
        //     }
        //     return null;
        //   },
        //   height: 32,
        //   onChanged: widget.onChanged,
        // ),

      ],
    );
  }
}