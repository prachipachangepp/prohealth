import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../../../../../../../app/resources/font_manager.dart';

class PhysicalExamContainer extends StatefulWidget {
  const PhysicalExamContainer({Key? key}) : super(key: key);

  @override
  _PhysicalExamContainerState createState() => _PhysicalExamContainerState();
}

class _PhysicalExamContainerState extends State<PhysicalExamContainer> {
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  String? _selectedFileName;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = _dateFormat.format(pickedDate);
      });
    }
  }

  Future<void> _openFileExplorer() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      }
    } on PlatformException catch (e) {
      print('Error while picking the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child:  Text(
                      'Physical Exam',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff686464),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildRightColumn(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Physical Exam',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xff686464),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Valid within 1 year of test',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff686464),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Date Administered',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff575757),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 30,
          width: 242,
          child: TextField(

            controller: _dateController,
            style: TextStyle(
              fontSize: FontSize.s14,
            ),
            decoration: InputDecoration(

              hintText: 'dd-mm-yyyy',
              hintStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xff9B9B9B),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xff50B5E5),
                  size: 16,
                ),
                onPressed: () => _selectDate(context),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Physical Exam records in pdf, jpg or png format',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff686464),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 80),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB1B1B1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: _openFileExplorer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD9D9D9),
                      ),
                      child: Text(
                        'Choose File',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.3,
                          color: const Color(0xff686464),
                        ),
                      ),
                    ),
                    Text(
                      _selectedFileName ?? 'No file chosen',
                      style: TextStyle(
                        fontSize: 11.3,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff575757),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//////////////////////////////////////////////////////////////////////////////////
class VaccineContainer extends StatefulWidget {
  const VaccineContainer({Key? key}) : super(key: key);

  @override
  _VaccineContainerState createState() => _VaccineContainerState();
}

class _VaccineContainerState extends State<VaccineContainer> {
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  String? _selectedFileName;
  int? _selectedRadio;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = _dateFormat.format(pickedDate);
      });
    }
  }

  Future<void> _openFileExplorer() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      }
    } on PlatformException catch (e) {
      print('Error while picking the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildLeftColumn(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/140),
                  Expanded(
                    flex: 2,
                    child: _buildRightColumn(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildRadioOption(0, 'TB', 'Valid within 1 year of test'),
            _buildRadioOption(1, 'Chest X-Ray', 'Valid within 1 year of test'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Date Administered',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xff575757),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 30,
          width: 242,
          child: TextField(
            controller: _dateController,
            style: TextStyle(
              fontSize: FontSize.s14,
            ),
            decoration: InputDecoration(
              hintText: 'dd-mm-yyyy',
              hintStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xff9B9B9B),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xff50B5E5),
                  size: 16,
                ),
                onPressed: () => _selectDate(context),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Text(
            'Upload Vaccination Records in pdf, jpg or png format',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff686464),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 80),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB1B1B1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: _openFileExplorer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD9D9D9),
                      ),
                      child: Text(
                        'Choose File',
                        style:TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.3,
                          color: const Color(0xff686464),
                        ),
                      ),
                    ),
                    Text(
                      _selectedFileName ?? 'No file chosen',
                      style: TextStyle(
                        fontSize: 11.3,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff575757),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(int value, String title, String subtitle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio<int>(
          value: value,
          groupValue: _selectedRadio,
          onChanged: (int? newValue) {
            setState(() {
              _selectedRadio = (_selectedRadio == newValue) ? null : newValue;
            });
          },
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff686464),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xff686464),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
//

////