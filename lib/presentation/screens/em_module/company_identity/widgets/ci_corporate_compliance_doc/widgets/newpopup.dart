// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:prohealth/app/constants/app_config.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
//
// import '../../../../../../../app/resources/color.dart';
// import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
// import '../../../../../../../app/resources/const_string.dart';
// import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
// import '../../../../../../../app/resources/font_manager.dart';
// import '../../../../../../../app/resources/value_manager.dart';
//
// ////add
// typedef void OnUpload(dynamic val);
//
// ///manage policy post
// class PoliciesProcedureAddPopUp extends StatefulWidget {
//   final String title;
//   bool? loadingDuration;
//   final VoidCallback onPressed;
//   final double? height;
//   final Widget? uploadField;
//   final Widget child;
//   dynamic filePath;
//   String? fileName;
//   final Function(int) onDocTypeSelected;
//   final Function(String?) onExpiryDateSelected;
//   PoliciesProcedureAddPopUp({
//     super.key,
//     required this.child,
//     required this.title,
//     required this.onPressed,
//     this.height,
//     this.loadingDuration,
//     this.uploadField,
//     this.fileName,
//     this.filePath,
//     required this.onDocTypeSelected,
//     required this.onExpiryDateSelected,
//   });
//
//   @override
//   State<PoliciesProcedureAddPopUp> createState() =>
//       _PoliciesProcedureAddPopUpState();
// }
//
// class _PoliciesProcedureAddPopUpState extends State<PoliciesProcedureAddPopUp> {
//   int docTypeId = 0;
//   String? documentTypeName;
//   dynamic filePath;
//   String? selectedDocType;
//   String fileName = '';
//   String _url = "";
//   bool showExpiryDateField = false;
//   TextEditingController expiryDateController = TextEditingController();
//   int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
//   int selectedSubDocId = AppConfig.subDocId0;
//   @override
//   void initState() {
//     super.initState();
//     _url = "";
//     showExpiryDateField; // Reset _url when the popup is initialized
//   }
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         filePath = result.files.first.bytes;
//         fileName = result.files.first.name;
//         print('File path ${filePath}');
//         print('File name ${fileName}');
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s420,
//         height: widget.height == null ? AppSize.s350 : widget.height,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: AppSize.s35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 30),
//                     child: Text(
//                       widget.title,
//                       style:  PopupBlueBarText.customTextStyle(context),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       color: ColorManager.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: AppSize.s20),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppString.type_of_the_document,
//                     style: ConstTextFieldStyles.customTextStyle(textColor: ColorManager.mediumgrey),
//                   ),
//                   SizedBox(height: AppSize.s5),
//                   widget.child,
//                   SizedBox(height: AppSize.s5),
//                   SizedBox(height: AppSize.s12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         AppString.upload_document,
//                         style:AppbarCustomDropdownStyle.customTextStyle(context),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: AppSize.s5),
//
//                   /// upload  doc
//                   Container(
//                     height: AppSize.s30,
//                     width: AppSize.s354,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: ColorManager.containerBorderGrey,
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: StatefulBuilder(
//                       builder: (BuildContext context,
//                           void Function(void Function()) setState) {
//                         return Padding(
//                           padding: const EdgeInsets.all(0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 fileName,
//                                 style: DropdownItemStyle.customTextStyle(context),
//                               ),
//                               IconButton(
//                                 padding: EdgeInsets.all(4),
//                                 onPressed: _pickFile,
//                                 icon: Icon(
//                                   Icons.file_upload_outlined,
//                                   color: ColorManager.black,
//                                   size: 17,
//                                 ),
//                                 splashColor: Colors.transparent,
//                                 highlightColor: Colors.transparent,
//                                 hoverColor: Colors.transparent,
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: AppSize.s20),
//
//             ///button
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppPadding.p10),
//               child: Center(
//                 child: widget.loadingDuration == true
//                     ? SizedBox(
//                         height: AppSize.s25,
//                         width: AppSize.s25,
//                         child: CircularProgressIndicator(
//                           color: ColorManager.blueprime,
//                         ),
//                       )
//                     : CustomElevatedButton(
//                         width: AppSize.s105,
//                         height: AppSize.s30,
//                         text: AppStringEM.add, //submit
//                         onPressed: () async {
//                           widget.onPressed();
//                         },
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
