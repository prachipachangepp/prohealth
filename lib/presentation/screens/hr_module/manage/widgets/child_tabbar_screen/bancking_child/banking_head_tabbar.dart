import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/bancking_child/widget/edit_banking_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/string_manager.dart';

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
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  activeColor: const Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox1,
                  onChanged: (value) {
                    setState(() {
                      checkBox1 = value!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const BankingContainerConst(),
                const SizedBox(width: 16),
                Checkbox(
                  activeColor: const Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox2,
                  onChanged: (value) {
                    setState(() {
                      checkBox2 = value!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const BankingContainerConst(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  activeColor: const Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox3,
                  onChanged: (value) {
                    setState(() {
                      checkBox3 = value!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const BankingContainerConst(),
                const SizedBox(width: 16),
                Checkbox(
                  activeColor: const Color(0xff50B5E5),
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: checkBox4,
                  onChanged: (value) {
                    setState(() {
                      checkBox4 = value!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const BankingContainerConst(),
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

  const BankingContainerConst({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 187,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            const BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(AppStringHr.bankone,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ),),
                  Container(
                    decoration: const BoxDecoration(
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
                          () {
                            showDialog(context: context, builder: (_) => EditBankingPopUp());
                          },
                      child:  Text(
                        AppStringHr.edit,
                        style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,),
                        backgroundColor: const Color(0xFF50B5E5),
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.type,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              AppStringHr.checking,
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.effectiveDate,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              '24-03-23',
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.bankName,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              'Bank Of America',
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.effectiveDate,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              '24-03-23',
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: mediaQuery.width/8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.accNo,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              '1234567797',
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.requestPercent,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              '30%',
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                     IconButtonWidget(iconData: Icons.remove_red_eye_outlined, buttonText: AppStringHr.voidcheck, onPressed:(){},),
                  const SizedBox(width: 10,),
                  IconButtonWidget(iconData1: Icons.print_outlined, buttonText: AppStringHr.print, onPressed:(){},),
                  const SizedBox(width: 10,),
                  IconButtonWidget(iconData1: Icons.file_download_outlined, buttonText: AppStringHr.download, onPressed:(){},)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
