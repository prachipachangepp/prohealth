import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';

class SearchPatientPopUp extends StatefulWidget {
  const SearchPatientPopUp({super.key});

  @override
  State<SearchPatientPopUp> createState() => _SearchPatientPopUpState();
}

class _SearchPatientPopUpState extends State<SearchPatientPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: ColorManager.blueprime,
        ),
        height: 47,
        width: 1280,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Search Patient',
                style: GoogleFonts.firaSans(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/1,
              height: 300,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 29,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Search for a patient',
                              labelStyle: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.greylight,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: ColorManager.containerBorderGrey,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: ColorManager.containerBorderGrey,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: ColorManager.containerBorderGrey,
                                  width: 1.0,
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('DZ',
                        style: GoogleFonts.firaSans(
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s11,
                          color: ColorManager.black
                        ),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: ColorManager.mediumgrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80.0),
                            child: Text(
                              'Sr.No.',
                              style: AllHRTableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Type',
                              style: AllHRTableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Name',
                            style: AllHRTableHeading.customTextStyle(context),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              'Location',
                              style: AllHRTableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              'Case',
                              style: AllHRTableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(
                              'Status',
                              style: AllHRTableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 30,
                    color: ColorManager.blueprime.withOpacity(0.17),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0),
                      child: Row(
                        children: [
                          Text('01',
                          style: TextStyle(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.charcoal
                          ),),
                          SizedBox(width: MediaQuery.of(context).size.width/13,),
                          Text('RN',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.charcoal
                            ),),
                          SizedBox(width:  MediaQuery.of(context).size.width/10,),
                          Text('Dhillon Amarpreet',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.charcoal
                            ),),
                          SizedBox(width:  MediaQuery.of(context).size.width/13,),
                          Text('ProHealth Walnut Creek-EI Dorado Sacramento',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.charcoal
                            ),),
                          SizedBox(width:  MediaQuery.of(context).size.width/7.4,),
                          Text('Infection control',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.charcoal
                            ),),
                          SizedBox(width:  MediaQuery.of(context).size.width/11,),
                          Text('Un-Scheduled',
                            style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                                color: Color(0xffB4DB4C)
                            ),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
