import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:open_file/open_file.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/whitelabelling_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/whitelabelling_modal/whitelabelling_modal_.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../widgets/text_form_field_const.dart';

class WhitelabellingScreen extends StatefulWidget {
  final String officeId;
  final VoidCallback backButtonCallback;

  WhitelabellingScreen({super.key, required this.officeId, required this.backButtonCallback});

  @override
  State<WhitelabellingScreen> createState() => _WhitelabellingScreenState();
}

class _WhitelabellingScreenState extends State<WhitelabellingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController secNumberController = TextEditingController();
  TextEditingController primNumController = TextEditingController();
  TextEditingController altNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hcoNumController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController npiNumController = TextEditingController();
  TextEditingController faxController = TextEditingController();

  ///
  TextEditingController addressCtlr = TextEditingController();
  TextEditingController nameCtlr = TextEditingController();
  TextEditingController secNumberCtlr = TextEditingController();
  TextEditingController primNumCtlr = TextEditingController();
  TextEditingController altNumCtlr = TextEditingController();
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController hcoNumCtlr = TextEditingController();
  TextEditingController medicareCtlr = TextEditingController();
  TextEditingController npiNumCtlr = TextEditingController();
  TextEditingController faxCtlr = TextEditingController();
  final StreamController<List<PlatformFile>> _mobileFilesStreamController =
      StreamController<List<PlatformFile>>.broadcast();
  final StreamController<List<PlatformFile>> _webFilesStreamController =
      StreamController<List<PlatformFile>>.broadcast();
  final StreamController<List<WhiteLabellingCompanyDetailModal>> _controller =
      StreamController<List<WhiteLabellingCompanyDetailModal>>();
  bool showManageScreen = false;
  bool showWhitelabellingScreen = true;
  @override
  void dispose() {
    _mobileFilesStreamController.close();
    _webFilesStreamController.close();
    addressController.removeListener(_onAddressChanged);

    super.dispose();
  }

  String fileName = "No Chosen";
  String? _previewImageUrl;
  dynamic filePath;

  List<PlatformFile>? pickedMobileFiles;
  List<PlatformFile>? pickedWebFiles;
  Future<void> pickMobileLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Custom type to specify allowed extensions
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ], // Restrict to PNG, JPG, and JPEG
    );

    if (result != null) {
      pickedMobileFiles = result.files;
      filePath = result.files.first.bytes;
      _mobileFilesStreamController.add(pickedMobileFiles!);
    } else {
      // User canceled the picker or no valid files selected
      // You can handle this scenario if needed
    }
  }

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<void> pickWebLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type:
          FileType.custom, // Use custom file type to specify allowed extensions
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ], // Restrict to PNG, JPG, and JPEG
    );

    if (result != null) {
      pickedWebFiles = result.files;
      filePath = result.files.first.bytes;
      _webFilesStreamController.add(pickedWebFiles!);
    } else {
      // Handle the case where the user cancels the picker or no valid files are selected
    }
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    //fetchData();
    addressController.addListener(_onAddressChanged);
  }

  ValueNotifier<List<String>> _suggestionsNotifier = ValueNotifier([]);
void fetchData()async{
  CompanyContactPrefill companyContactPrefill = await getCompanyContactPrefill(context);
}
  void _onAddressChanged() async {
    if (addressController.text.isEmpty) {
      _suggestionsNotifier.value = [];
      return;
    }
    final suggestions = await fetchSuggestions(addressController.text);
    _suggestionsNotifier.value = suggestions;
  }

  bool _isEditing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: widget.backButtonCallback,
                      icon: Icon(Icons.arrow_back_rounded, color: ColorManager.mediumgrey, size: IconSize.I16,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p15),
                    child: Text(
                      AppStringEM.logos,
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.2),
                  Expanded(
                    child: Text(
                      AppStringEM.details,
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                  Container(
                    height: AppSize.s30,
                    width: AppSize.s90,
                    child: CustomButton(
                      borderRadius: 12,
                      style: BlueButtonTextConst.customTextStyle(context),
                      text: AppStringEM.save,
                      onPressed: () async{
                        var response = await uploadWebAndAppLogo(
                            context: context,
                            type: "web",
                            documentFile: filePath,
                            documentName: fileName);
                        if(response.statusCode == 200 || response.statusCode == 201){
                          setState(() {
                            getWhiteLabellingData(context);
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditSuccessPopup(
                                message:
                                'Submitted Successfully',
                              );
                            },
                          );
                        }

                      },
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 50),
                  FutureBuilder(
                    future: getWhiteLabellingData(context),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return SizedBox();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: snapshot.data!.logos.isEmpty ? Column(
                            children: [
                              CustomIconButton(
                                  icon: Icons.edit_outlined,
                                  text: "Add Logo",
                                  onPressed: () async{
                                    pickWebLogo();
                                  }),
                              // SizedBox(height: 2,),
                              // Text(fileName,style:DocumentTypeDataStyle.customTextStyle(context),)
                            ],
                          ):SizedBox()
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2, //2
                    child: Container(
                     // color: Colors.greenAccent,
                      height: 320,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.blueprime,

                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child:

                          ///old code
                          FutureBuilder<WhiteLabellingCompanyDetailModal>(
                        future: getWhiteLabellingData(context),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }
                          if(snapshot.data!.logos.isEmpty){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: AppSize.s100,
                                  child: Center(
                                    child: Text('No available logo!',style: DocumentTypeDataStyle.customTextStyle(context),),
                                  )
                                ),
                              ],
                            );
                          }
                          if (snapshot.hasData) {
                            print("Image url ${snapshot.data!.logos[0].url}");
                            var data = snapshot.data!;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: AppSize.s100,
                                  child: snapshot.data!.logos.isNotEmpty
                                      ? CachedNetworkImage(
                                    imageUrl: snapshot.data!.logos[0].url,
                                    placeholder: (context, url) => SizedBox(
                                        height:AppSize.s25,
                                        width:AppSize.s25,
                                        ),
                                    errorWidget: (context, url, error) => Image.asset("images/forappprohealth.png"),
                                    fit: BoxFit.cover, // Ensure the image fits inside the circle
                                    height: AppSize.s100, // Adjust image height for proper fit// Adjust image width for proper fit
                                  )
                                      : Container(),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSize.s35,
                  ),
                  Expanded(
                    flex: 6, //6
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(AppPadding.p3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.blueprime,
                                // color: Colors.orange
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 320,
                          width: 1100,
                          // color: ColorManager.red,
                          child: FutureBuilder<
                                  WhiteLabellingCompanyDetailModal>(
                              future: getWhiteLabellingData(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  var data = snapshot.data!;
                                  print("NameController : ${data.companyDetail.name}");
                                  nameController = TextEditingController(
                                      text: data.companyDetail.name);
                                  secNumberController.text =
                                      data.contactDetail.secondaryPhone;
                                  faxController.text =
                                      data.contactDetail.primaryFax;
                                  addressController.text =
                                      data.companyDetail.address;
                                  primNumController.text =
                                      data.contactDetail.primaryPhone;
                                  altNumController.text =
                                      data.contactDetail.alternativePhone;
                                  emailController.text =
                                      data.contactDetail.email;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          EditTextField(
                                            enabled: _isEditing,
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.companyName,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextFieldPhone(
                                            controller: secNumberController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.secNum,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: faxController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.fax,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: emailController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.primarymail,
                                            enabled: _isEditing,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          EditTextFieldPhone(
                                            controller: primNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.primNum,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextFieldPhone(
                                            controller: altNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.alternatephone,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: addressController,
                                            keyboardType: TextInputType.text,
                                            text: "Street Address",
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(
                                            height: AppSize.s60,
                                            width: AppSize.s354,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                return SizedBox();
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
