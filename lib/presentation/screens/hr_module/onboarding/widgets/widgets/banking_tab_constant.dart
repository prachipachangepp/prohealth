import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_banking_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_banking_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../manage/const_wrap_widget.dart';
import '../../../manage/widgets/icon_button_constant.dart';
import '../../../manage/widgets/row_container_widget_const.dart';
import '../../qualification_const_bar/widgets/qualification_tab_constant.dart';

class BankingTabContainerConstant extends StatefulWidget {
  @override
  State<BankingTabContainerConstant> createState() =>
      _BankingTabContainerConstantState();
}

class _BankingTabContainerConstantState
    extends State<BankingTabContainerConstant> {
  final StreamController<List<OnboardingBankingData>> bankingStreamController = StreamController<List<OnboardingBankingData>>();

  @override
  void initState() {
    super.initState();
    getOnboardingBanking(context, 2).then((data){
      bankingStreamController.add(data);
    }).catchError((error){});
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingBankingData>>(
        stream: bankingStreamController.stream,
        builder: (context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(
            color: ColorManager.blueprime,
          ),
        );
      }
      if (snapshot.data!.isEmpty) {
        return Center(
            child: Text(
              AppString.dataNotFound,
              style: CustomTextStylesCommon.commonStyle(
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSize.s12,
                  color: ColorManager.mediumgrey),
            ));
      }
      if(snapshot.hasData){
        return WrapWidget(childern: List.generate(snapshot.data!.length, (index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
            child: Container(
              width: MediaQuery.of(context).size.width/2.3,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              height: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 80,
                  vertical: MediaQuery.of(context).size.height / 120,
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank #${snapshot.data![index].empBankId.toString()}',
                      style: GoogleFonts.firaSans(
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
                            InfoText('Type',),
                            InfoText('Effective Date', ),
                            InfoText('Bank Name',),
                            InfoText('Routing/Transit No.',),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoData(snapshot.data![index].type),
                            InfoData(snapshot.data![index].effectiveDate),
                            InfoData(snapshot.data![index].bankName),
                            InfoData(snapshot.data![index].rountingNumber),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoText('Account No.', ),
                            InfoText('Requested amount',),
                            InfoText('', ),
                            InfoText('',),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoData(snapshot.data![index].accNum),
                            InfoData(snapshot.data![index].amtRequested.toString()),
                            InfoData(''),
                            InfoData(''),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       ActionButtons()
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }));
      }else{
        return const SizedBox();
      }
        }
    );
    //   Padding(
    //   padding: EdgeInsets.symmetric(
    //     horizontal: MediaQuery.of(context).size.width / 80,
    //     vertical: MediaQuery.of(context).size.height / 100,
    //   ),
    //   child: TwoContainersRow(
    //     child1: BankDetailsSection(bankNumber: 'Bank #1'),
    //     child2: BankDetailsSection(bankNumber: 'Bank #2'),
    //   ),
    // );
  }
}

// class BankDetailsSection extends StatelessWidget {
//   final String bankNumber;
//
//   const BankDetailsSection({required this.bankNumber});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           bankNumber,
//           style: TextStyle(
//             fontFamily: 'FiraSans',
//             fontSize: 13,
//             color: Color(0xFF333333),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoText('Type',),
//                 InfoText('Effective Date', ),
//                 InfoText('Bank Name',),
//                 InfoText('Routing/Transit No.',),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoData('Checking',),
//                 InfoData('24-03-23', ),
//                 InfoData('SBI', ),
//                 InfoData('123456789',),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoText('Account No.', ),
//                 InfoText('Requested amount',),
//                 InfoText('', ),
//                 InfoText('',),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoData('1234567797', ),
//                 InfoData('30,000/-',),
//                 InfoData('',),
//                 InfoData('',),
//               ],
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ActionButtons(),
//           ],
//         )
//       ],
//     );
//   }
// }

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style:  ThemeManager.customTextStyle(context)),
        const SizedBox(height: 10),
      ],
    );
  }
}

class InfoData extends StatelessWidget {
  final String text;

  const InfoData(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: ThemeManagerDark.customTextStyle(context)),
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