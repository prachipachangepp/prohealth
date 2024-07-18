import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class EditTimeOffPopup extends StatefulWidget {
  final TextEditingController ptoController;
  final TextEditingController durationController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController sickTimeController;
  final VoidCallback onPressed;
  final String labelName;

  EditTimeOffPopup({
    super.key,
    required this.ptoController,
    required this.durationController,
    required this.startTimeController,
    required this.endTimeController,
    required this.sickTimeController,
    required this.labelName,
    required this.onPressed,
  });

  @override
  State<EditTimeOffPopup> createState() => _EditTimeOffPopupState();
}

class _EditTimeOffPopupState extends State<EditTimeOffPopup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s500,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildDialogTitle(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFormField(widget.ptoController, 'PTO'),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.durationController, 'Duration'),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.startTimeController, 'Start Time'),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.endTimeController, 'End Time'),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.sickTimeController, 'Sick Time'),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: 'Add',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onPressed();
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogTitle() {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: Color(0xff50B5E5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              widget.labelName,
              style: GoogleFonts.firaSans(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SMTextFConst(
          controller: controller,
          keyboardType: TextInputType.text,
          text: labelText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            controller.text.isEmpty ? 'Please enter some text' : '',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
