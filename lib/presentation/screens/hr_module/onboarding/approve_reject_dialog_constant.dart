import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';

class RejectConfirmPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onReject;
  RejectConfirmPopup({super.key, required this.onCancel, required this.onReject});

  @override
  State<RejectConfirmPopup> createState() => _RejectConfirmPopupState();
}

class _RejectConfirmPopupState extends State<RejectConfirmPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 150.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Reject',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Do you really want to reject the selected files?",
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                  fontSize: 14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.mediumgrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // },
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xff1696C8),
                        side: BorderSide(color: Color(0xff1696C8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery
                        .of(context)
                        .size
                        .width / 75),
                    ElevatedButton(
                      onPressed: widget.onReject,
                        // Implement the reject logic here
                        //_rejectSelectedDocuments();
                        //Navigator.of(context).pop();

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1696C8),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///approve Popup
class ApproveConfirmPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onApprove;
  ApproveConfirmPopup({super.key, required this.onCancel, required this.onApprove});

  @override
  State<ApproveConfirmPopup> createState() => _ApproveConfirmPopupState();
}

class _ApproveConfirmPopupState extends State<ApproveConfirmPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 150.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Approve',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Do you really want to approve this?",
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                  fontSize: 14,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.mediumgrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xff1696C8),
                        side: BorderSide(color: Color(0xff1696C8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 75),
                    ElevatedButton(
                      onPressed: widget.onApprove,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1696C8),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
