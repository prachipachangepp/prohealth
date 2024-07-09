import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';

class OfferLetterDescriptionScreen extends StatefulWidget {
  const OfferLetterDescriptionScreen({super.key});

  @override
  State<OfferLetterDescriptionScreen> createState() => _OfferLetterDescriptionScreenState();
}

class _OfferLetterDescriptionScreenState extends State<OfferLetterDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TopRowConstant()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Offer Letter',
                  style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xff50B5E5)
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 1032,
                height: 1190,
                child: Html(
                  data: """
                  <p>Dear Sameer V </p>
                  
                  <p>ProHealth Home Care, Inc. (“ProHealth”) is a home health care provider under the management of industry veterans with experience in assisted living, home health care, DME, hospice, skilled nursing, rehab and hospital management. ProHealth offers a full spectrum of home health services ranging from nursing assistance with everyday needs to physical therapy, occupational therapy, and speech language pathology.</p>
                  <ul>
                    <li>Item 1</li>
                    <li>Item 2</li>
                  </ul>
                """,
                  style: {
                    "h1": Style(
                      fontSize: FontSize.large,
                      color: Colors.black,
                    ),
                    "p": Style(
                      fontSize: FontSize.medium,
                      color: Colors.black54,
                    ),
                    "li": Style(
                      fontSize: FontSize.medium,
                      color: Colors.black54,
                    ),
                  },
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
