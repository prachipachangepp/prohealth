import 'package:flutter/material.dart';

import '../../../../../../app/resources/theme_manager.dart';

class BankingHeadTabbar extends StatefulWidget {
  @override
  _BankingHeadTabbarState createState() => _BankingHeadTabbarState();
}

class _BankingHeadTabbarState extends State<BankingHeadTabbar> {
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  activeColor: Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox1,
                  onChanged: (value) {
                    setState(() {
                      checkBox1 = value!;
                    });
                  },
                ),
                SizedBox(width: 8),
                BankingContainerConst(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bank #1',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x40000040),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height / 35,
                          width: MediaQuery.of(context).size.width / 20,
                          child: ElevatedButton(
                            onPressed:
                                () {},
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15,),
                              backgroundColor: Color(0xFF50B5E5),
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/15,
                      top: MediaQuery.of(context).size.height/55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Type',
                                  style: ThemeManager.customTextStyle(context)),
                              Text(
                                'Checking',
                                style: ThemeManagerDark.customTextStyle(context),
                              ),
                              Text('Account No.',
                                  style: ThemeManager.customTextStyle(context)),
                              Text(
                                '1234567797',
                                style: ThemeManagerDark.customTextStyle(context),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Effective Date',
                                  style: ThemeManager.customTextStyle(context)),
                              Text(
                                '24-03-23',
                                style: ThemeManagerDark.customTextStyle(context),
                              ),
                              Text('Requested Percentage',
                                  style: ThemeManager.customTextStyle(context)),
                              Text(
                                '30%',
                                style: ThemeManagerDark.customTextStyle(context),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Bank Name',
                                  style: ThemeManager.customTextStyle(context)),
                              Text(
                                'Bank Of America',
                                style: ThemeManagerDark.customTextStyle(context),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Routing/Transit No.',
                                  style: ThemeManager.customTextStyle(context)),
                              Text(
                                '123456789',
                                style: ThemeManagerDark.customTextStyle(context),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Row(

                    )
                  ],
                )),
                SizedBox(width: 16),
                Checkbox(
                  activeColor: Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox2,
                  onChanged: (value) {
                    setState(() {
                      checkBox2 = value!;
                    });
                  },
                ),
                SizedBox(width: 8),
                BankingContainerConst(child: Column()),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  activeColor: Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox3,
                  onChanged: (value) {
                    setState(() {
                      checkBox3 = value!;
                    });
                  },
                ),
                SizedBox(width: 8),
                BankingContainerConst(child: Column()),
                SizedBox(width: 16),
                Checkbox(
                  activeColor: Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox4,
                  onChanged: (value) {
                    setState(() {
                      checkBox4 = value!;
                    });
                  },
                ),
                SizedBox(width: 8),
                BankingContainerConst(child: Column()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///Container Constant
class BankingContainerConst extends StatelessWidget {
  final Widget child;

  const BankingContainerConst({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        height: 179,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
