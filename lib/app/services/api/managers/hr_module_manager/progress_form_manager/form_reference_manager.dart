import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api_offer.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/progress_form_data/form_reference_data.dart';
import '../../../../../../presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../../presentation/widgets/error_popups/four_not_four_popup.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiDataRegister> postreferencescreenData(
    BuildContext context,
    String association,
    String comment,
    String company,
    String email,
    int employeeId,
    String mob,
    String name,
    String references,
    String title) async {
  try {
    var response = await ApiOffer(context).post(
      path: ProgressBarRepository.postreferencescreen(),
      data: {
        "association": association,
        "comment": comment,
        "company": company,
        "email": email,
        "employeeId": employeeId,
        "mob": mob,
        "name": name,
        "references": references,
        "title": title
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("reference Added");
      // await showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AddSuccessPopup(
      //       message: 'Reference Data Saved',
      //     );
      //   },
      // );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Reference data saved"),backgroundColor: Colors.green,),
      // );
      //orgDocumentGet(context);
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      // await showDialog(
      //   context: context,
      //   builder: (BuildContext context) => const FourNotFourPopup(),
      // );
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddSuccessPopup(
            message: response.statusMessage!,
          );
        },
      );
      print("Error 1");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);

  }
}

///prifill api get
///
Future<List<ReferenceDataForm>> getEmployeeReferenceForm(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

//var itemList ;
  List<ReferenceDataForm> itemsData = [];
  try {
    final response = await ApiOffer(context).get(
        path: ProgressBarRepository
            .getReferenceByEmpID(employeeID: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        //String startDateFormattedDate = item['startDate'] == null ? "--" :convertIsoToDayMonthYear(item['expDate']);
        //String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(ReferenceDataForm(
            referenceId: item['referenceId'],
            association: item['association'],
            comment: item['comment'],
            company: item['company'],
            email:item['email'],
            employeeId:item['employeeId'],
            mob: item['mob'],
            name: item['name'],
            references:item['references'],
            title: item['title'],
        ));
        // itemsData.sort((a, b) => a.educationId.compareTo(b.educationId));
      }
    } else {
      print("Employee References ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
