// import 'package:flutter/material.dart';
// import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
// import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
// import '../../../../../../../../app/resources/color.dart';
// import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
// import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
// import '../../../../../../../../app/resources/value_manager.dart';
// import '../../../../../../em_module/widgets/button_constant.dart';
// import '../../../../../../em_module/widgets/dialogue_template.dart';
// import '../../../../../../em_module/widgets/text_form_field_const.dart';
// import 'form_screen_const.dart';
//
// class DirectDepositeSignPopup extends StatefulWidget {
//   final int employeeId;
//   final int htmlFormTemplateId;
//   const DirectDepositeSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId,});
//
//   @override
//   State<DirectDepositeSignPopup> createState() => _DirectDepositeSignPopupState();
// }
//
// class _DirectDepositeSignPopupState extends State<DirectDepositeSignPopup> {
//   TextEditingController actionController = TextEditingController();
//   TextEditingController typeController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController bankNameController = TextEditingController();
//   TextEditingController rountingController = TextEditingController();
//   TextEditingController accountController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//
//   TextEditingController action2Controller = TextEditingController();
//   TextEditingController type2Controller = TextEditingController();
//   TextEditingController address2Controller = TextEditingController();
//   TextEditingController bankName2Controller = TextEditingController();
//   TextEditingController rounting2Controller = TextEditingController();
//   TextEditingController account2Controller = TextEditingController();
//   TextEditingController amount2Controller = TextEditingController();
//   bool loading = false;
//   bool _isFormValid = true;
//   String? actionError;
//   String? typeError;
//   String? addressError;
//   String? bankNameError;
//   String? routingError;
//   String? accountError;
//   String? amountError;
//
//   String? action2Error;
//   String? type2Error;
//   String? address2Error;
//   String? bankName2Error;
//   String? routing2Error;
//   String? account2Error;
//   String? amount2Error;
//   String? _validateTextField(String value, String fieldName) {
//     if (value.isEmpty) {
//       _isFormValid = false;
//       return "Please Enter $fieldName";
//     }
//     return null;
//   }
//
//   void _validateForm() {
//     setState(() {
//       _isFormValid = true;
//       actionError = _validateTextField(actionController.text, 'action');
//       typeError = _validateTextField(typeController.text, 'type');
//       addressError = _validateTextField(addressController.text, 'address');
//       bankNameError = _validateTextField(bankNameController.text, 'bank name');
//       routingError = _validateTextField(rountingController.text, 'routing or transit');
//       accountError = _validateTextField(accountController.text, 'account');
//       amountError = _validateTextField(amountController.text, 'amount');
//
//       action2Error = _validateTextField(action2Controller.text, 'action 2');
//       type2Error = _validateTextField(type2Controller.text, 'type 2');
//       address2Error = _validateTextField(address2Controller.text, 'address 2');
//       bankName2Error = _validateTextField(bankName2Controller.text, 'bank name 2');
//       routing2Error = _validateTextField(rounting2Controller.text, 'routing or transit 2');
//       account2Error = _validateTextField(account2Controller.text, 'account 2');
//       amount2Error = _validateTextField(amount2Controller.text, 'amount 2');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//       width: AppSize.s800,
//       height: AppSize.s700,
//       title: "Direct Deposite",
//       body: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FirstSMTextFConst(
//                     controller: actionController,
//                     keyboardType: TextInputType.text,
//                     text: 'Action 1',
//                   ),
//                   if (actionError != null) // Display error if any
//                     Text(
//                       actionError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: typeController,
//                     keyboardType: TextInputType.text,
//                     text: 'Type 1',
//                   ),
//                   if (typeError != null)
//                     Text(
//                       typeError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: bankNameController,
//                     keyboardType: TextInputType.text,
//                     text: 'Bank Name',
//                   ),
//                   if (bankNameError != null)
//                     Text(
//                       bankNameError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: addressController,
//                     keyboardType: TextInputType.text,
//                     text: 'Address 1',
//                   ),
//                   if (addressError != null)
//                     Text(
//                       addressError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: rountingController,
//                     keyboardType: TextInputType.text,
//                     text: 'Routing or Transit 1',
//                   ),
//                   if (routingError != null)
//                     Text(
//                       routingError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: accountController,
//                     keyboardType: TextInputType.text,
//                     text: 'Account 1',
//                   ),
//                   if (accountError != null)
//                     Text(
//                       accountError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: amountController,
//                     keyboardType: TextInputType.text,
//                     text: 'Amount 1',
//                   ),
//                   if (amountError != null)
//                     Text(
//                       amountError!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FirstSMTextFConst(
//                     controller: action2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Action 2',
//                   ),
//                   if (action2Error != null) // Display error if any
//                     Text(
//                       action2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//
//                  SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: type2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Type 2',
//                   ),
//                   if (type2Error != null)
//                     Text(
//                       type2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: bankName2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Bank Name 2',
//                   ),
//                   if (bankName2Error != null)
//                     Text(
//                       bankName2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: address2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Address 2',
//                   ),
//                   if (address2Error != null)
//                     Text(
//                       address2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: rounting2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Routing or Transit 2',
//                   ),
//                   if (routing2Error != null)
//                     Text(
//                       routing2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: account2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Account 2',
//                   ),
//                   if (account2Error != null)
//                     Text(
//                       account2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//
//                   SizedBox(height: AppSize.s6),
//                   SMTextFConst(
//                     controller: amount2Controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Amount 2',
//                   ),
//                   if (amount2Error != null)
//                     Text(
//                       amount2Error!,
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//       bottomButtons: loading == true
//           ? SizedBox(
//         height: AppSize.s25,
//         width: AppSize.s25,
//         child: CircularProgressIndicator(
//           color: ColorManager.blueprime,
//         ),
//       )
//           : CustomElevatedButton(
//           width: AppSize.s105,
//           height: AppSize.s30,
//           text: AppStringEM.submit,
//           onPressed: () async {
//             _validateForm(); // Validate the form on button press
//             if (_isFormValid) {
//               setState(() {
//                 loading = true;
//               });
//               DirectDepositDocuemnt directDepositDocuemnt = await getDirectDepositDocument(context: context, employeeId: widget.employeeId, templateId: widget.htmlFormTemplateId, action1:actionController.text, type1: typeController.text,
//                 bankNameAndAddress: bankNameController.text, routingOrtransit1: rountingController.text, account1: accountController.text, amount1: amountController.text, action2: action2Controller.text, type2: type2Controller.text, bankNameAndaddress2: bankName2Controller.text,
//                 routingOrtransit2: rounting2Controller.text, account2: account2Controller.text, amount2: amount2Controller.text, );
//               if(directDepositDocuemnt.statusCode == 200 || directDepositDocuemnt.statusCode == 201){
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//                   documentName: directDepositDocuemnt.name,
//                   onPressed: () {
//
//                   },
//                   htmlFormData: directDepositDocuemnt.html,
//                   employeeId: widget.employeeId,//widget.employeeID,
//                   htmlFormTemplateId: directDepositDocuemnt.directDepositDocuemntId,)));
//               }
//
//
//             };
//             //finally {
//             setState(() {
//               loading = false;
//              // Navigator.pop(context);
//             });
//             // }
//           }
//       ),);
//   }
// }
