import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../manage/widgets/icon_button_constant.dart';
import '../../../manage/widgets/row_container_widget_const.dart';

class BankingTabContainerConstant extends StatefulWidget {
  @override
  State<BankingTabContainerConstant> createState() =>
      _BankingTabContainerConstantState();
}

class _BankingTabContainerConstantState
    extends State<BankingTabContainerConstant> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 80,
        vertical: MediaQuery.of(context).size.height / 100,
      ),
      child: TwoContainersRow(
        child1: BankDetailsSection(bankNumber: 'Bank #1'),
        child2: BankDetailsSection(bankNumber: 'Bank #2'),
      ),
    );
  }
}

class BankDetailsSection extends StatelessWidget {
  final String bankNumber;

  const BankDetailsSection({required this.bankNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bankNumber,
          style: TextStyle(
            fontFamily: 'FiraSans',
            fontSize: 13,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoText('Type', ThemeManager.customTextStyle(context)),
                InfoText('Effective Date', ThemeManager.customTextStyle(context)),
                InfoText('Bank Name', ThemeManager.customTextStyle(context)),
                InfoText('Routing/Transit No.', ThemeManager.customTextStyle(context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoData('Checking', ThemeManagerDark.customTextStyle(context)),
                InfoData('24-03-23', ThemeManagerDark.customTextStyle(context)),
                InfoData('SBI', ThemeManagerDark.customTextStyle(context)),
                InfoData('123456789', ThemeManagerDark.customTextStyle(context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoText('Account No.', ThemeManager.customTextStyle(context)),
                InfoText('Requested amount', ThemeManager.customTextStyle(context)),
                InfoText('', ThemeManager.customTextStyle(context)),
                InfoText('', ThemeManager.customTextStyle(context)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoData('1234567797', ThemeManagerDark.customTextStyle(context)),
                InfoData('30,000/-', ThemeManagerDark.customTextStyle(context)),
                InfoData('', ThemeManager.customTextStyle(context)),
                InfoData('', ThemeManager.customTextStyle(context)),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButtons(),
          ],
        )
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const InfoText(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: style),
        const SizedBox(height: 10),
      ],
    );
  }
}

class InfoData extends StatelessWidget {
  final String text;
  final TextStyle style;

  const InfoData(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: style),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomElevatedButton(
          icon: Icons.remove_red_eye,
          label: 'Void Check',
          onPressed: () {

          },
        ),
        SizedBox(width: 8.0),
        CustomElevatedButton(
          icon: Icons.print_outlined,
          label: 'Print',
          iconPosition: IconPosition.right,
          onPressed: () {

          },
        ),
        SizedBox(width: 8.0),
        CustomElevatedButton(
          icon: Icons.sim_card_download_outlined,
          label: 'Download',
          iconPosition: IconPosition.right,
          onPressed: () {

          },
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final IconPosition iconPosition;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconPosition = IconPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff1696C8),
        side: BorderSide(color: Color(0xff1696C8)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconPosition == IconPosition.left
            ? [
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: Color(0xff1696C8),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              icon,
              size: 12.0,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 6.0),
          Text(
            label,
            style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]
            : [
          Text(
            label,
            style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 6.0),
          Icon(
            icon,
            size: 16.0,
            color: Color(0xff1696C8),
          ),
        ],
      ),
    );
  }
}

enum IconPosition { left, right }