import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QualificationActionButtons extends StatelessWidget {
  final VoidCallback onRejectPressed;
  final VoidCallback onApprovePressed;

  const QualificationActionButtons({super.key, required this.onRejectPressed, required this.onApprovePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onRejectPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xff1696C8),
            side: BorderSide(color: Color(0xff1696C8)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Reject',
            style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width/75),
        ElevatedButton(
          onPressed: onApprovePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff1696C8),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Approve',
            style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
