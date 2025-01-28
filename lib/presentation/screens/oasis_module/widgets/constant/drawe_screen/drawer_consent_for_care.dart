import 'package:flutter/material.dart';

import '../../../../../../app/resources/value_manager.dart';
import '../../../them_manager/oasis_them_mnager.dart';

class Drawerrightside extends StatelessWidget {
  const Drawerrightside({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Not Attempted Questions",
              style: Redfontstyle.customTextStyle(context)
          ),
          SizedBox(height: AppSize.s20,),
          Text("| do not currently have advance directives",
            style: Normalfontstyle.customTextStyle(context),
          ),
          SizedBox(height: AppSize.s20,),
          Text("I have had an opportunity to review this document and ask questions to assist me in understanding my rights relation to the protection of my health information. I am satisfied with the explanation provided to me and I am confident that the provider is committed to protecting my health Information.",
            style: Normalfontstyle.customTextStyle(context),
          ),
        ],
      ),
    );
  }
}