import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBankingPopUp extends StatefulWidget {
  const EditBankingPopUp({Key? key}) : super(key: key);

  @override
  State<EditBankingPopUp> createState() => _EditBankingPopUpState();
}

class _EditBankingPopUpState extends State<EditBankingPopUp> {
  String _selectedType = 'Checking';
  final _effectiveDateController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _verifyAccountController = TextEditingController();
  final _routingNumberController = TextEditingController();
  final _specificAmountController = TextEditingController();
  TextEditingController _controller = TextEditingController();

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
        ElevatedButton.icon(
          onPressed: _handleFileUpload,
          icon: Icon(Icons.upload, color: Colors.white),
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
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value.toString();
                });
              },
            ),
            Text('Checking'),
            Radio(
              value: 'Savings',
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value.toString();
                });
              },
            ),
            Text('Savings'),
          ],
        ),
        SizedBox(height: 10),
        _buildTextField(_routingNumberController, 'Routing Number/ Transit Number'),
        SizedBox(height: 10),
        Text('Requested Amount for this Account (select one)', style: _labelStyle()),
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
              child: _buildTextField(_specificAmountController, '', prefixText: '\$'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _specificAmountController.clear();
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
          _effectiveDateController,
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
        _buildTextField(_accountNumberController, 'Account Number'),
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
      _effectiveDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  Widget _buildThirdColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(_bankNameController, 'Bank Name'),
        SizedBox(height: 10),
        _buildTextField(_verifyAccountController, 'Verify Account Number'),
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
              color: Color(0xff1696C8),
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
      ElevatedButton(
        child: Text('Save',
            style: GoogleFonts.firaSans(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12)),
        onPressed: () {
          // Handle save action
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
