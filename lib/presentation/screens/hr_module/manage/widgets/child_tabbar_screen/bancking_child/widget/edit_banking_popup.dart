import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class EditBankingPopUp extends StatefulWidget {
  String? selectedType;
  final TextEditingController effectiveDateController;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController verifyAccountController;
  final TextEditingController routingNumberController;
  final TextEditingController specificAmountController;
  Future<void> Function() onPressed;
   EditBankingPopUp({super.key, required this.onPressed,this.selectedType,required this.effectiveDateController, required this.bankNameController,
     required this.accountNumberController, required this.verifyAccountController,
     required this.routingNumberController, required this.specificAmountController});

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
          borderRadius: BorderRadius.circular(12.0),
        ),
        titlePadding: EdgeInsets.zero,
        title: _buildDialogTitle(context),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderWithUpload(),
                SizedBox(height: MediaQuery.of(context).size.height/30),
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
      )
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Color(0xFF27A3E0),
        borderRadius: BorderRadius.only(topRight: Radius.circular(12.0),topLeft: Radius.circular(12.0))
      ),
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Edit Banking',
            style: GoogleFonts.firaSans(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
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
        ElevatedButton.icon(
          onPressed: _handleFileUpload,
          icon: Icon(Icons.file_upload_outlined, color: Colors.white),
          label: Text(
            'Upload',
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
            Text('Checking',
              style: TextStyle(
                  fontSize: AppSize.s10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),),
            Radio(
              value: 'Savings',
              groupValue: widget.selectedType,
              onChanged: (value) {
                setState(() {
                  widget.selectedType = value.toString();
                });
              },
            ),
            Text('Savings',
              style: TextStyle(
                  fontSize: AppSize.s11,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height/100),
        _buildTextField(widget.routingNumberController, 'Routing Number/ Transit Number'),
        SizedBox(height: MediaQuery.of(context).size.height/40),
        Text('Requested Amount for this Account (select one)', style: _labelStyle()),
        Row(
          children: [
            Radio(
              value: 'Specific Amount',
              groupValue: 'Specific Amount',
              onChanged: (value) {},
            ),
            Text('Specific Amount:',
            style: TextStyle(
              fontSize: AppSize.s11,
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField(widget.specificAmountController, '', prefixText: '\$'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                widget.specificAmountController.clear();
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  fontSize: AppSize.s12,
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
              size: AppSize.s20,
            ),
            onPressed: _selectDate,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/30),
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
      widget.effectiveDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  Widget _buildThirdColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(widget.bankNameController, 'Bank Name'),
        SizedBox(height: MediaQuery.of(context).size.height/30),
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
      height: AppSize.s30,
      child: TextField(
        style: TextStyle(
          fontSize: AppSize.s12,
        ),
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffB1B1B1)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
      ),
    );
  }

  TextStyle _labelStyle() {
    return GoogleFonts.firaSans(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Color(0xff575757),
    );
  }

  List<Widget> _buildDialogActions(BuildContext context) {
    return [
      ElevatedButton(
        child: Text('Cancel',
            style: GoogleFonts.firaSans(
              color: Color(0xff1696C8),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            )),
        onPressed: () => Navigator.of(context).pop(),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Color(0xFF27A3E0)),
          ),
        ),
      ),
      isLoading ? SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(color: ColorManager.blueprime,))
          : ElevatedButton(
        child: Text('Save',
            style: GoogleFonts.firaSans(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12)),
        onPressed: () async{
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
///////


//
// Padding(
// padding:  EdgeInsets.only(top: 20.0),
// child: Container(
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// ElevatedButton.icon(
// onPressed: () async {
// DateTime? pickedDate =
// await showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime(2000),
// lastDate: DateTime(2101),
// );
// if (pickedDate != null) {
// String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
// _controllerStartDate.text = formattedDate;
// }
// },
// icon: Icon(Icons.calendar_month,color: Color(0xff686464),size: 18,),
// label: Text('Start Date',
// style: GoogleFonts.roboto(
// fontSize: 12,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464),
// ),
// ),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0),
// side: BorderSide(color: Color(0xffB6B6B6)),
// ),
// ),
// ),
// SizedBox(width: 10),
// ElevatedButton.icon(
// onPressed: () async {
// DateTime? pickedDate =
// await showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime(2000),
// lastDate: DateTime(2101),
// );
// if (pickedDate != null) {
// String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
// _controllerEndDate.text = formattedDate;
// }
// },
// icon: Icon(Icons.calendar_month,color: Color(0xff686464),size: 18,),
// label: Text('End Date',
// style: GoogleFonts.roboto(
// fontSize: 12,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464),
// ),
// ),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0),
// side: BorderSide(color: Color(0xffB6B6B6)),
// ),
// ),
// ),
// ],
// ),