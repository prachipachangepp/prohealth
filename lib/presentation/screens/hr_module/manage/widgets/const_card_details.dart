import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/theme_manager.dart';

class CardDetails extends StatefulWidget {
  final Widget childWidget;
  const CardDetails({super.key, required this.childWidget});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
      child: Container(
        width: MediaQuery.of(context).size.width/2.5,
        padding: EdgeInsets.all(10),
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
        height: MediaQuery.of(context).size.height/3.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 80,
            vertical: MediaQuery.of(context).size.height / 160,
          ),
          child: widget.childWidget
        ),
      ),
    );
  }
}

class DetailsFormate extends StatefulWidget {
  final List<Widget> row1Child1;
  final List<Widget> row1Child2;
  final List<Widget> row2Child1;
  final List<Widget> row2Child2;
  String? title;
  final Widget button;
   DetailsFormate({super.key, this.title,required this.row1Child1, required this.row1Child2, required this.row2Child1, required this.row2Child2, required this.button});

  @override
  State<DetailsFormate> createState() => _DetailsFormateState();
}

class _DetailsFormateState extends State<DetailsFormate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            widget.title!,
            // 'Employment #${snapshot.data![index].employmentId}',
            style: BoxHeadingStyle.customTextStyle(context)),
        // SizedBox(height: 7,),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.row1Child1
                ),
                SizedBox(width: MediaQuery.of(context).size.width/40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.row1Child2
                ),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width/15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.row2Child1
                ),
                SizedBox(width: MediaQuery.of(context).size.width/40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.row2Child2
                ),
              ],
            )
          ],
        ),
        // SizedBox(height: 4,),
        widget.button
      ],
    );
  }
}

