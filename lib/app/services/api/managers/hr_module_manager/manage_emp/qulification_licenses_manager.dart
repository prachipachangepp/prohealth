import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/qualification_licenses.dart';

Future<List<QulificationLicensesData>> getEmployeeLicenses(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<QulificationLicensesData> itemsData = [];
  try {
    final response = await Api(context).get(
        path: ManageReposotory.getEmployeeLicenses(employeeid: employeeId, approveOnly: 'no'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String expFormattedDate = convertIsoToDayMonthYear(item['expDate']);
        String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(QulificationLicensesData(
          licenseId: item['licenseId'],
          country: item['country'],
          employeeId: item['employeeId'],
          expData: expFormattedDate,
          issueDate: issueFormattedDate,
          licenseUrl: item['licenseUrl'],
          licenure: item['licensure'],
          licenseNumber: item['licenseNumber'],
          org: item['org'],
          documentType: item['documentType'],
          approved: item['approved'],
          sucess: true,
          message: response.statusMessage!,
        ));
        itemsData.sort((a, b) => a.licenseId.compareTo(b.licenseId));
      }
    } else {
      print("Employee Licenses");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// employee licenses filter
Future<List<QulificationLicensesFilteredData>> getEmployeeLicensesFilteredData(
    BuildContext context, int employeeId, String licenseName) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<QulificationLicensesFilteredData> itemsData = [];
  try {
    final response = await Api(context).get(
        path: ManageReposotory.getEmployeeLicensesFiltered(employeeid: employeeId, approveOnly: 'no', licenseName: licenseName));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String expFormattedDate = convertIsoToDayMonthYear(item['expDate']);
        String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(QulificationLicensesFilteredData(
          licenseId: item['licenseId'],
          status:item['status'],
          country: item['country'],
          employeeId: item['employeeId'],
          expData: expFormattedDate,
          issueDate: issueFormattedDate,
          licenseUrl: item['licenseUrl'],
          licenure: item['licensure'],
          licenseNumber: item['licenseNumber'],
          org: item['org'],
          documentType: item['documentType'],
          approved: item['approved'],
          sucess: true,
          message: response.statusMessage!,
        ));
        itemsData.sort((a, b) => a.licenseId.compareTo(b.licenseId));
      }
    } else {
      print("Employee Licenses");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Add License
Future<ApiData> addLicensePost(
    BuildContext context,
    String country,
    int employeeId,
    String expDate,
    String issueDate,
    String licenseUrl,
    String licensure,
    String licenseNumber,
    String org,
    String documentType) async {
  try {
    var response = await Api(context).post(
      path: ManageReposotory.addEmployeeLicenses(),
      data: {
        "country": country,
        "employeeId": employeeId,
        "expDate": "${expDate}T00:00:00Z",
        "issueDate": "${issueDate}T00:00:00Z",
        "licenseUrl": licenseUrl,
        "licensure": licensure,
        "licenseNumber": licenseNumber,
        "org": org,
        "documentType": documentType
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("License Added");
      // orgDocumentGet(context);
      var licenseRes = response.data;
      int licenseId = licenseRes['licenseId'];
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!,
          licenseId: licenseId);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Attach license document
Future<ApiData> attachLicenseDocument(
    BuildContext context,
    int licenseId,
    dynamic documentFile,
    String documentFileName) async {
  try {
    String document = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    var response = await Api(context).post(
      path: ManageReposotory.attachLicenseDocument(licenseId: licenseId),
      data: {
        "base64":document,
        'documentName': documentFileName
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("License Added");
      // orgDocumentGet(context);
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("License uploaded");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
/// select document
Future<List<SelectDocuments>> selectDocument(
  BuildContext context,
) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<SelectDocuments> itemsData = [];
  try {
    final response =
        await Api(context).get(path: ManageReposotory.getselectDocuments());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        // String expFormattedDate = convertIsoToDayMonthYear(item['expDate']);
        // String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(SelectDocuments(
            documentId: item['document_id'],
            documentTypeId: item['document_type_id'],
            documentSubTypeId: item['document_subtype_id'],
            docName: item['doc_name'],
            docCreated: item['doc_created_at']??"",
            url: item['url']??"",
            expiryType: item['expiry_type'],
            expiryDate: item['expiry_date'],
            expiryReminder: item['expiry_reminder'],
            companyId: item['company_id'],
            officeId: item['office_id'],
            idOfDocument: item['idOfDocument']??""));
      }
    } else {
      print("Select Documents");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Update license
Future<ApiData> updateLicensePatch(
    BuildContext context,
    int licenseId,
    String country,
    int employeeId,
    String expDate,
    String issueDate,
    String licenseUrl,
    String licensure,
    String licenseNumber,
    String org,
    String documentType) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.updateEmployeeLicenses(licensedId: licenseId),
      data: {
        "country": country,
        "employeeId": employeeId,
        "expDate": "${expDate}T00:00:00Z",
        "issueDate": "${issueDate}T00:00:00Z",
        "licenseUrl": licenseUrl,
        "licensure": licensure,
        "licenseNumber": licenseNumber,
        "org": org,
        "documentType": documentType
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("License Updated");
      // orgDocumentGet(context);
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// PreFill Licences data
Future<QulificationLicensesPreFillData> getEmployeeLicensesPreFill(
    BuildContext context, int licensesId,) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response = await Api(context).get(
        path: ManageReposotory.getEmployeePreFillLicenses(licensesId: licensesId));
    if (response.statusCode == 200 || response.statusCode == 201) {

        String expFormattedDate = convertIsoToDayMonthYear(response.data['expDate']);
        String issueFormattedDate = convertIsoToDayMonthYear(response.data['issueDate']);
        itemsData = QulificationLicensesPreFillData(
          licenseId: response.data['licenseId']??"--",
          country: response.data['country']??"--",
          employeeId: response.data['employeeId']??0,
          expData: expFormattedDate,
          issueDate: issueFormattedDate,
          licenseUrl: response.data['licenseUrl']??"--",
          licenure: response.data['licensure']??"--",
          licenseNumber: response.data['licenseNumber']??"--",
          org: response.data['org']??"--",
          documentType: response.data['documentType']??"--",
          approved: response.data['approved'],
          documentName: response.data['documentName'] ?? '--',
          sucess: true,
          message: response.statusMessage!,
        );
    } else {
      print("Employee Licenses prefill");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Reject license
Future<ApiData> rejectLicensePatch(BuildContext context, int licenseId) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.rejectEmployeeLicenses(licensedId: licenseId),
      data: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("License rejected");
      // orgDocumentGet(context);
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Approve license
Future<ApiData> approveLicensePatch(BuildContext context, int licenseId) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.approveEmployeeLicenses(licensedId: licenseId),
      data: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("License Approved");
      // orgDocumentGet(context);
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
