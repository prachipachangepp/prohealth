import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../app/resources/color.dart';
class DoubleDatePickerTextField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;
  final TextEditingController? startDateController;
  final TextEditingController? endDateController;
  final Function(DateTime? startDate, DateTime? endDate)? onDateRangeSelected;

  DoubleDatePickerTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
    this.startDateController,
    this.endDateController,
    this.onDateRangeSelected,
  }) : super(key: key);

  @override
  _DoubleDatePickerTextFieldState createState() => _DoubleDatePickerTextFieldState();
}

class _DoubleDatePickerTextFieldState extends State<DoubleDatePickerTextField> {
  late TextEditingController _dateController;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.initialValue);
  }

  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? selectedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 1)),
      ),
    );

    if (selectedDateRange != null) {
      setState(() {
        _startDate = selectedDateRange.start;
        _endDate = selectedDateRange.end;
        _dateController.text =
        "${DateFormat('yyyy-MM-dd').format(_startDate!)} to ${DateFormat('yyyy-MM-dd').format(_endDate!)}";

        // Update the external controllers if they are provided
        if (widget.startDateController != null) {
          widget.startDateController!.text = DateFormat('yyyy-MM-dd').format(_startDate!);
        }
        if (widget.endDateController != null) {
          widget.endDateController!.text = DateFormat('yyyy-MM-dd').format(_endDate!);
        }

        // Notify the parent widget about the selected date range
        if (widget.onDateRangeSelected != null) {
          widget.onDateRangeSelected!(_startDate, _endDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: TextFormField(
        controller: _dateController,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            color: Colors.grey[300],
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          suffixIcon: widget.isDate
              ? Icon(
            Icons.calendar_month_outlined,
            color: ColorManager.blueprime,
          )
              : null,
        ),
        readOnly: widget.isDate,
        onTap: widget.isDate ? () async {
          await _selectDateRange(context);
        } : null,
      ),
    );
  }
}
