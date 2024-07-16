// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
//
// class EditBankingPopUp extends StatefulWidget {
//   String? selectedType;
//   final TextEditingController effectiveDateController;
//   final TextEditingController bankNameController;
//   final TextEditingController accountNumberController;
//   final TextEditingController verifyAccountController;
//   final TextEditingController routingNumberController;
//   final TextEditingController specificAmountController;
//   Future<void> Function() onPressed;
//    EditBankingPopUp({super.key, required this.onPressed,this.selectedType,required this.effectiveDateController, required this.bankNameController,
//      required this.accountNumberController, required this.verifyAccountController,
//      required this.routingNumberController, required this.specificAmountController});
//
//   @override
//   State<EditBankingPopUp> createState() => _EditBankingPopUpState();
// }
//
// class _EditBankingPopUpState extends State<EditBankingPopUp> {
// bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0),),
//         ),
//         titlePadding: EdgeInsets.zero,
//         title: _buildDialogTitle(context),
//         content: Container(
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeaderWithUpload(),
//                 SizedBox(height: 20),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: _buildFirstColumn()),
//                     SizedBox(width: 20),
//                     Expanded(child: _buildSecondColumn()),
//                     SizedBox(width: 20),
//                     Expanded(child: _buildThirdColumn()),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: _buildDialogActions(context),
//       ),
//     );
//   }
//
//   Widget _buildDialogTitle(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12.0),
//       color: Color(0xFF27A3E0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Edit Banking',
//             style: GoogleFonts.firaSans(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.close, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeaderWithUpload() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Bank #1',
//           style: GoogleFonts.firaSans(
//             fontSize: 16.0,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//         ElevatedButton.icon(
//           onPressed: _handleFileUpload,
//           icon: Icon(Icons.upload, color: Colors.white),
//           label: Text(
//             'Upload',
//             style: GoogleFonts.firaSans(
//               color: Colors.white,
//               fontSize: 10,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFF27A3E0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _handleFileUpload() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//     );
//     if (result != null) {
//       PlatformFile file = result.files.first;
//       print('File picked: ${file.name}');
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   Widget _buildFirstColumn() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Type',
//           style: GoogleFonts.firaSans(fontWeight: FontWeight.w600, fontSize: 14),
//         ),
//         Row(
//           children: [
//             Radio(
//               value: 'Checking',
//               groupValue: widget.selectedType,
//               onChanged: (value) {
//                 setState(() {
//                   widget.selectedType = value.toString();
//                 });
//               },
//             ),
//             Text('Checking'),
//             Radio(
//               value: 'Savings',
//               groupValue: widget.selectedType,
//               onChanged: (value) {
//                 setState(() {
//                   widget.selectedType = value.toString();
//                 });
//               },
//             ),
//             Text('Savings'),
//           ],
//         ),
//         SizedBox(height: 10),
//         _buildTextField(widget.routingNumberController, 'Routing Number/ Transit Number'),
//         SizedBox(height: 10),
//         Text('Requested Amount for this Account (select one)', style: _labelStyle()),
//         Row(
//           children: [
//             Radio(
//               value: 'Specific Amount',
//               groupValue: 'Specific Amount',
//               onChanged: (value) {},
//             ),
//             Text('Specific Amount'),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: _buildTextField(widget.specificAmountController, '', prefixText: '\$'),
//             ),
//             SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: () {
//                 widget.specificAmountController.clear();
//               },
//               child: Text(
//                 'Reset',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF27A3E0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSecondColumn() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildTextField(
//           widget.effectiveDateController,
//           'Effective Date',
//           suffixIcon: IconButton(
//             icon: Icon(
//               Icons.calendar_month_outlined,
//               color: Color(0xff50B5E5),
//               size: 16,
//             ),
//             onPressed: _selectDate,
//           ),
//         ),
//         SizedBox(height: 10),
//         _buildTextField(widget.accountNumberController, 'Account Number'),
//       ],
//     );
//   }
//
//   Future<void> _selectDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       widget.effectiveDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
//     }
//   }
//
//   Widget _buildThirdColumn() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildTextField(widget.bankNameController, 'Bank Name'),
//         SizedBox(height: 10),
//         _buildTextField(widget.verifyAccountController, 'Verify Account Number'),
//       ],
//     );
//   }
//
//   Widget _buildTextField(
//       TextEditingController controller,
//       String labelText, {
//         Widget? suffixIcon,
//         String? prefixText,
//       }) {
//     return Container(
//       height: 32,
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: labelText,
//           suffixIcon: suffixIcon,
//           prefixText: prefixText,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: Colors.grey),
//           ),
//           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         ),
//       ),
//     );
//   }
//
//   TextStyle _labelStyle() {
//     return GoogleFonts.firaSans(
//       fontSize: 10.0,
//       fontWeight: FontWeight.w400,
//       color: Color(0xff575757),
//     );
//   }
//
//   List<Widget> _buildDialogActions(BuildContext context) {
//     return [
//       ElevatedButton(
//         child: Text('Cancel',
//             style: GoogleFonts.firaSans(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 12,
//             )),
//         onPressed: () => Navigator.of(context).pop(),
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             side: BorderSide(color: Color(0xFF27A3E0)),
//           ),
//         ),
//       ),
//       isLoading ? SizedBox(
//           height: 25,
//           width: 25,
//           child: CircularProgressIndicator(color: ColorManager.blueprime,))
//           : ElevatedButton(
//         child: Text('Save',
//             style: GoogleFonts.firaSans(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 12)),
//         onPressed: () async{
//           setState(() {
//             isLoading = true;
//           });
//           try {
//             await widget.onPressed();
//           } finally {
//             setState(() {
//               isLoading = false;
//             });
//             Navigator.pop(context);
//             widget.effectiveDateController.clear();
//             widget.specificAmountController.clear();
//             widget.bankNameController.clear();
//             widget.routingNumberController.clear();
//             widget.accountNumberController.clear();
//             widget.verifyAccountController.clear();
//             widget.selectedType = '';
//           }
//
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF27A3E0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//         ),
//       ),
//     ];
//   }
// }
// ///////







import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';

class EditBankingPopUp extends StatefulWidget {
  String? selectedType;
  final TextEditingController effectiveDateController;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController verifyAccountController;
  final TextEditingController routingNumberController;
  final TextEditingController specificAmountController;
  Future<void> Function() onPressed;

  EditBankingPopUp({
    super.key,
    required this.onPressed,
    this.selectedType,
    required this.effectiveDateController,
    required this.bankNameController,
    required this.accountNumberController,
    required this.verifyAccountController,
    required this.routingNumberController,
    required this.specificAmountController,
  });

  @override
  State<EditBankingPopUp> createState() => _EditBankingPopUpState();
}

class _EditBankingPopUpState extends State<EditBankingPopUp> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        titlePadding: EdgeInsets.zero,
        title: _buildDialogTitle(context),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderWithUpload(),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildFirstColumn()),
                    SizedBox(width: 20),
                    Expanded(child: _buildSecondColumn()),
                    SizedBox(width: 20),
                    Expanded(child: _buildThirdColumn()),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: _buildDialogActions(context),
      ),
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: Color(0xFF27A3E0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Edit Banking',
            style: GoogleFonts.firaSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWithUpload() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bank #1',
          style: GoogleFonts.firaSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _handleFileUpload,
              icon: Icon(Icons.upload, color: Colors.white),
              label: Text(
                'Upload License',
                style: GoogleFonts.firaSans(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF27A3E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _handleFileUpload,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'Add Banking',
                style: GoogleFonts.firaSans(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF27A3E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      print('File picked: ${file.name}');
    } else {
      // User canceled the picker
    }
  }

  Widget _buildFirstColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type',
          style: GoogleFonts.firaSans(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        Row(
          children: [
            Radio(
              value: 'Checking',
              groupValue: widget.selectedType,
              onChanged: (value) {
                setState(() {
                  widget.selectedType = value.toString();
                });
              },
            ),
            Text('Checking'),
            Radio(
              value: 'Savings',
              groupValue: widget.selectedType,
              onChanged: (value) {
                setState(() {
                  widget.selectedType = value.toString();
                });
              },
            ),
            Text('Savings'),
          ],
        ),
        SizedBox(height: 10),
        _buildTextField(
          widget.routingNumberController,
          'Routing Number/ Transit Number',
        ),
        SizedBox(height: 10),
        Text(
          'Requested Amount for this Account (select one)',
          style: _labelStyle(),
        ),
        Row(
          children: [
            Radio(
              value: 'Specific Amount',
              groupValue: 'Specific Amount',
              onChanged: (value) {},
            ),
            Text('Specific Amount'),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                widget.specificAmountController,
                '',
                prefixText: '\$',
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                widget.specificAmountController.clear();
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF27A3E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          widget.effectiveDateController,
          'Effective Date',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Color(0xff50B5E5),
              size: 16,
            ),
            onPressed: _selectDate,
          ),
        ),
        SizedBox(height: 10),
        _buildTextField(widget.accountNumberController, 'Account Number'),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      widget.effectiveDateController.text =
      "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  Widget _buildThirdColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(widget.bankNameController, 'Bank Name'),
        SizedBox(height: 10),
        _buildTextField(widget.verifyAccountController, 'Verify Account Number'),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String labelText, {
        Widget? suffixIcon,
        String? prefixText,
      }) {
    return Container(
      height: 32,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
      ),
    );
  }

  TextStyle _labelStyle() {
    return GoogleFonts.firaSans(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      color: Color(0xff575757),
    );
  }

  List<Widget> _buildDialogActions(BuildContext context) {
    return [
      ElevatedButton(
        child: Text('Cancel',
            style: GoogleFonts.firaSans(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            )),
        onPressed: () => Navigator.of(context).pop(),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Color(0xFF27A3E0)),
          ),
        ),
      ),
      isLoading
          ? SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(color: ColorManager.blueprime),
      )
          : ElevatedButton(
        child: Text('Save',
            style: GoogleFonts.firaSans(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12)),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            await widget.onPressed();
          } finally {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
            widget.effectiveDateController.clear();
            widget.specificAmountController.clear();
            widget.bankNameController.clear();
            widget.routingNumberController.clear();
            widget.accountNumberController.clear();
            widget.verifyAccountController.clear();
            widget.selectedType = '';
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF27A3E0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    ];
  }
}


