import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/em_dashboard_theme.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/app_clickable_widget.dart';

///bottom Shadow container const
class SMDashboardContainerConst extends StatelessWidget {
  final Widget child;
  final double? height;
  const SMDashboardContainerConst({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.s120,
      padding: EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 1.2), // Downward shadow
          ),
        ],
      ),
      child: child,);
  }
}

class SMDashboadGraphContainer extends StatelessWidget {
  final Widget child;
  SMDashboadGraphContainer({super.key, required this.child,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(top: BorderSide(
          color: Color(0xFF579EBA),
          width: 3,
        ),),
        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 1.2), // Downward shadow
          ),
        ],
      ),
      child: child,);
  }
}

///container joint const
class JointContainerConst extends StatelessWidget {
  final Widget childHeading;
  final Widget childBody;
  final double? height;
  const JointContainerConst({super.key, required this.childHeading, required this.childBody, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         // padding: EdgeInsets.symmetric(horizontal: ),
          height: AppSize.s35,
          decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12),),
            border: Border(
                top: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1),width: 1),
                bottom: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1),width: 1),
                left: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1),width: 1),
                right: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1),width: 1)),
            // boxShadow: [
            //   BoxShadow(
            //     color: ColorManager.black.withOpacity(0.2),
            //     blurRadius: 4,
            //     spreadRadius: 0,
            //     offset: const Offset(4, 0), // Downward shadow
            //   ),
            // ],
          ),
          child:  Center(child: childHeading),),
        Container(height: height ?? AppSize.s383,
          decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: const Offset(0, 1.2), // Downward shadow
                ),
              ],
              border: Border(top: BorderSide.none,bottom: BorderSide(color: ColorManager.dashDivider,width: 1),
                  left: BorderSide(color: ColorManager.dashDivider,width: 1),right: BorderSide(color: ColorManager.dashDivider,width: 1)),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12))
          ),
          child: childBody,
        )],
    );
  }
}


///small container widget const
class SMSmallContainerData extends StatelessWidget {
  final String headingText;
  final String totalCount;
  final String imagePath;
  final int totalValue;
  final int? flex;
  final List<Color> indicatorGradientColors; // Accept gradient colors as a list
  final Color TextColor;

  const SMSmallContainerData({
    super.key,
    required this.headingText,
    required this.totalCount,
    required this.imagePath,
    required this.totalValue,
    this.flex,
    required this.indicatorGradientColors,
    required this.TextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              headingText,
              style: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: flex ?? 2,
              child: Text(
                totalCount,
                style: TextStyle(
                  fontSize: FontSize.s14,
                  color: TextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                fit: BoxFit.fill,
                imagePath,
                height: 40, // Adjust the size as needed
              ),
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4), // Add rounded corners if needed
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: indicatorGradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: LinearProgressIndicator(
              backgroundColor: ColorManager.white,
              value: totalValue / 100,
              minHeight: 5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Set a placeholder value
            ),
          ),
        ),
      ],
    );
  }
}

///
typedef void OnManuButtonTapCallBack(int index);
class SMDashboardConst extends StatelessWidget {
  const SMDashboardConst({
    super.key,
    required this.onTap,
    required this.index,
    required this.grpIndex,
  });

  final OnManuButtonTapCallBack onTap;
  final int index;
  final int grpIndex;

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: () {
        onTap(index);
      },
      onHover: (bool val) {},
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // final textPainter = TextPainter(
              //   text: TextSpan(
              //     text: heading,
              //     style: TextStyle(
              //       fontSize: FontSize.s10,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              //   textDirection: TextDirection.ltr,
              // )..layout();

              // final textWidth = textPainter.size.width;
              // print("textwidth :::::::: $heading $textWidth");
              return Container(
                margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
                height: 3,
                width: 40,// textWidth + 10,
                decoration: BoxDecoration(
                    color: ColorManager.bluebottom,
                   // borderRadius: BorderRadius.circular(12)
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

///type of widgets const
class TypeOfVisitsConst extends StatelessWidget {
  final Color ContainerColor;
  final String text;
  const TypeOfVisitsConst({super.key, required this.ContainerColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 30,width: 80,
        color: ContainerColor,),
        SizedBox(width: 30,),
        Text(
          text,
          textAlign: TextAlign.end,
          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
            fontWeight: FontWeight.w600,
            color: ColorManager.mediumgrey,),
        ),
      ],
    );
  }
}

///
class GradientProgressIndicator extends StatelessWidget {
  final double progress; // Value between 0 and 1

  const GradientProgressIndicator({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background track
        Container(
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFE9ECEF)
          ),
        ),
        // Gradient progress
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth * progress, // Progress width
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1696C8), // #1696C8
                    Color(0xFFB0E7FC), // #B0E7FC
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
