import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/sales_hr.dart';
import 'administration_hr.dart';
import 'clinical_hr.dart';

class SeeAllHrScreen extends StatefulWidget {
  const SeeAllHrScreen({super.key});

  @override
  State<SeeAllHrScreen> createState() => _SeeAllHrScreenState();
}

class _SeeAllHrScreenState extends State<SeeAllHrScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Widget _buildTabWithCircle(int selectedIndex) {
    return Container(
      height: 30,
      width:MediaQuery.of(context).size.width/3
      ,
      decoration: BoxDecoration(
        color: Color(0xff50B5E5),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildSingleTab(
              'Clinical', '1,366', selectedIndex == 0, true, false),
          _buildSingleTab('Sales', '1,234', selectedIndex == 1, false, false),
          _buildSingleTab(
              'Administration', '567', selectedIndex == 2, false, true),
        ],
      ),
    );
  }

  Widget _buildSingleTab(
      String text, String number, bool isSelected, bool isLeft, bool isRight) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          int index = isLeft ? 0 : (isRight ? 2 : 1);
          setState(() {
            _tabController.index = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Color(0xff50B5E5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Color(0xff686464) : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              if (isSelected && number.isNotEmpty)
                Container(
                  height: 40, // Increased height of container
                  width: 40, // Increased width
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Color(0xff50B5E5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      number,
                      style: GoogleFonts.firaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 49.0, right: 49.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go Back',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF686464),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              _buildTabWithCircle(_tabController.index),

              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopUp();
                    },
                  );
                },
                child: SvgPicture.asset('images/menu_lines.svg'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  backgroundColor: Color(0xff50B5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ClinicalHrScreen(),
                SalesHrScreen(),
                AdministrationHrScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopUp extends StatefulWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          )),
      titlePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: 32,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Expired License',
                style: GoogleFonts.firaSans(
                  fontSize: 11,
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
            ),
          ],
        ),
      ),


      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(height: MediaQuery.of(context).size.height / 160),
            Row(
              children: [
                ConstantContainerWithText(text: 'RN'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'LVN'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'PT'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'PTA'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'HHA'),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 45),
            Row(
              children: [
                ConstantContainerWithText(text: 'COTA'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'ST'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'MSW'),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                ConstantContainerWithText(text: 'OT'),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Row(
              children: [
                Text(
                  'Office Location',
                  style: GoogleFonts.firaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff737373),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Row(
              children: [
                Container(
                  height: 27,
                  width: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      'San Jose',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                Container(
                  height: 27,
                  width: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      'Zone 1',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Row(
              children: [
                Text(
                  'License status',
                  style: GoogleFonts.firaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff737373),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Row(
              children: [
                Container(
                  height: 27,
                  width: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      'Expired',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Row(
              children: [
                Text(
                  'Availability',
                  style: GoogleFonts.firaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff737373),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Row(
              children: [
                Container(
                  height: 27,
                  width: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      'Full-Time',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConstantContainerWithText extends StatefulWidget {
  final String text;

  const ConstantContainerWithText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _ConstantContainerWithTextState createState() =>
      _ConstantContainerWithTextState();
}

class _ConstantContainerWithTextState extends State<ConstantContainerWithText> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isSelected ? Color(0xff4FB8EB) : Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        height: 27,
        width: 31,
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.firaSans(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: _isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}