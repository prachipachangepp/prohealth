import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:http/http.dart' as http;

import '../../../../../../data/api_data/api_data.dart';
//
// Future<int> uploadData(String imageFilePath, String url, String name, String id) async {
//   try {
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//
//     request.files.add(await http.MultipartFile.fromPath(
//       'image',
//       imageFilePath,
//       filename: 'image_$name.jpg',
//     ));
//
//     // Add additional fields
//     request.fields['companyName'] = name;
//     request.fields['own_id'] = id;
//
//     // Send the request
//     var response = await request.send();
//
//     // Get the response status code
//     return response.statusCode;
//   } catch (e) {
//     print('Error uploading data: $e');
//     return 500;
//   }
// }
///
// Future<ApiData> addPhotoUpload(
//     BuildContext context,
//     int employeeId,
//     String code,
//     int userId,
//     String firstName,
//     String lastName,
//     int dptID,
//     int emplyTypeId,
//     String expritise,
//     int cityID,
//     int countryID,
//     int zoneID,
//     String ssnnBr,
//     String primeNo,
//     String secNo,
//     String workNo,
//     String regOfficeId,
//     String personalEmail,
//     String workEmail,
//     String address,
//     String dob,
//     String emgContact,
//     String coverage,
//     String employment,
//     String gender,
//     String status,
//     String service,
//     XFile imageFile,
//     String resumeUrl,
//     int companyID,
//     bool terminationFlag,
//     bool approved,
//     String onboardingStatus,
//     String createdAt,
//     String driverLicenceNbr,
//     String dateofTermination,
//     String dateofResignation,
//     String dateofHire,
//     String rehirable,
//     String position,
//     String finaladdress,
//     String checkDate,
//     int grossPay,
//     String type,
//     String reason,
//     int finalPayCheck,
//     int netpay,
//     String method,
//     String material,
//     String race,
//     ) async {
//   try {
//     final uri = Uri.parse(HRModuleAEClinicalRepository.addphoto(employeeID: employeeId));
//     final request = http.MultipartRequest('POST', uri);
//
//     final accessToken = await TokenManager.getAccessToken();
//
//     request.headers.addAll({
//       'Authorization': 'Bearer $accessToken',
//       'Content-Type': 'multipart/form-data',
//     });
//
//     // Add other fields
//     request.fields['employeeId'] = employeeId.toString();
//     request.fields['code'] = code;
//     // Add all other form fields similarly
//
//     // Add the image file
//     final imageBytes = await imageFile.readAsBytes();
//     request.files.add(
//       http.MultipartFile.fromBytes(
//         'file',
//         imageBytes,
//         filename: 'image.jpg',
//         contentType: MediaType('image', 'jpg'),
//       ),
//     );
//
//     final response = await request.send();
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseBody = await response.stream.bytesToString();
//       final jsonResponse = jsonDecode(responseBody);
//
//       return ApiData(
//         statusCode: response.statusCode,
//         success: true,
//         message: jsonResponse['message'] ?? 'Upload successful',
//         imageUrl: jsonResponse['imageUrl'],
//       );
//     } else {
//       return ApiData(
//         statusCode: response.statusCode,
//         success: false,
//         message: 'Failed to upload image: ${response.reasonPhrase}',
//       );
//     }
//   } catch (e) {
//     return ApiData(
//       statusCode: 404,
//       success: false,
//       message: 'Something went wrong: $e',
//     );
//   }
// }
///
// Future<ApiData> addPhotoUpload(
//     BuildContext context,
//     int employeeId,
//     String code,
//     int userId,
//     String firstName,
//     String lastName,
//     int dptID,
//     int emplyTypeId,
//     String expritise,
//     int cityID,
//     int countryID,
//     int zoneID,
//     String ssnnBr,
//     String primeNo,
//     String secNo,
//     String workNo,
//     String regOfficeId,
//     String personalEmail,
//     String workEmail,
//     String address,
//     String dob,
//     String emgContact,
//     String coverage,
//     String employment,
//     String gender,
//     String status,
//     String service,
//     XFile imageFile, // Change type to XFile
//     String resumeUrl,
//     int companyID,
//     bool terminationFlag,
//     bool approved,
//     String onboardingStatus,
//     String createdAt,
//     String driverLicenceNbr,
//     String dateofTermination,
//     String dateofResignation,
//     String dateofHire,
//     String rehirable,
//     String position,
//     String finaladdress,
//     String checkDate,
//     int grossPay,
//     String type,
//     String reason,
//     int finalPayCheck,
//     int netpay,
//     String method,
//     String material,
//     String race,
//     ) async {
//   try {
//     final dio = Dio();
//     final String accessToken = await TokenManager.getAccessToken(); // Get access token
//
//     final formData = FormData.fromMap({
//       "employeeId": employeeId,
//       "code": code,
//       "userId": userId,
//       "firstName": firstName,
//       "lastName": lastName,
//       "departmentId": dptID,
//       "employeeTypeId": emplyTypeId,
//       "expertise": expritise,
//       "cityId": cityID,
//       "countryId": countryID,
//       "zoneId": zoneID,
//       "SSNNbr": ssnnBr,
//       "primaryPhoneNbr": primeNo,
//       "secondryPhoneNbr": secNo,
//       "workPhoneNbr": workNo,
//       "regOfficId": regOfficeId,
//       "personalEmail": personalEmail,
//       "workEmail": workEmail,
//       "address": address,
//       "dateOfBirth": "${dob}T00:00:00Z",
//       "emergencyContact": emgContact,
//       "covreage": coverage,
//       "employment": employment,
//       "gender": gender,
//       "status": status,
//       "service": service,
//       "resumeurl": resumeUrl,
//       "companyId": companyID,
//       "onboardingStatus": onboardingStatus,
//       "createdAt": "${createdAt}T00:00:00Z",
//       "terminationFlag": terminationFlag,
//       "approved": approved,
//       "dateofTermination": "${dateofTermination}T00:00:00Z",
//       "dateofResignation": "${dateofResignation}T00:00:00Z",
//       "dateofHire": "${dateofHire}T00:00:00Z",
//       "rehirable": rehirable,
//       "position": position,
//       "driverLicenceNbr": driverLicenceNbr,
//       "finalAddress": finaladdress,
//       "type": type,
//       "reason": reason,
//       "finalPayCheck": finalPayCheck,
//       "checkDate": "${checkDate}T00:00:00Z",
//       "grossPay": grossPay,
//       "netPay": netpay,
//       "methods": method,
//       "materials": material,
//       "race": race,
//       "file": await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg') // Convert XFile to MultipartFile
//     });
//
//     final response = await dio.post(
//       HRModuleAEClinicalRepository.addphoto(employeeID: employeeId),
//       data: formData,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json'
//         },
//       ),
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: true,
//         message: response.statusMessage!,
//       );
//     } else {
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: false,
//         message: response.data['message'],
//       );
//     }
//   } catch (e) {
//     return ApiData(
//       statusCode: 404,
//       success: false,
//       message: 'Something went wrong',
//     );
//   }
// }










//
//
// Future<ApiData> addPhotoUpload(
//     BuildContext context,
//     int emplyId,
//     String code,
//     int userId,
//     String firstName,
//     String lastName,
//     int dptID,
//     int emplyTypeId,
//     String expritise,
//     int cityID,
//     int countryID,
//     int zoneID,
//     String ssnnBr,
//     String primeNo,
//     String secNo,
//     String workNo,
//     String regOfficeId,
//     String personalEmail,
//     String workEmail,
//     String address,
//     String dob,
//     String emgContact,
//     String coverage,
//     String employment,
//     String gender,
//     String status,
//     String service,
//     XFile? imageFile, // Assuming imageFile is an XFile
//     String resumeUrl,
//     int companyID,
//     bool terminationFlag,
//     bool approved,
//     String onboardingStatus,
//     String createdAt,
//     String driverLicenceNbr,
//     String dateofTermination,
//     String dateofResignation,
//     String dateofHire,
//     String rehirable,
//     String position,
//     String finaladdress,
//     String checkDate,
//     int grossPay,
//     String type,
//     String reason,
//     int finalPayCheck,
//     int netpay,
//     String method,
//     String material,
//     String race,
//     ) async {
//   try {

    // final FormData formData = FormData.fromMap({
    //   "employeeId": emplyId,
    //   "code": code,
    //   "userId": userId,
    //   "firstName": firstName,
    //   "lastName": lastName,
    //   "departmentId": dptID,
    //   "employeeTypeId": emplyTypeId,
    //   "expertise": expritise,
    //   "cityId": cityID,
    //   "countryId": countryID,
    //   "zoneId": zoneID,
    //   "SSNNbr": ssnnBr,
    //   "primaryPhoneNbr": primeNo,
    //   "secondryPhoneNbr": secNo,
    //   "workPhoneNbr": workNo,
    //   "regOfficId": regOfficeId,
    //   "personalEmail": personalEmail,
    //   "workEmail": workEmail,
    //   "address": address,
    //   "dateOfBirth": "${dob}T00:00:00Z",
    //   "emergencyContact": emgContact,
    //   "covreage": coverage,
    //   "employment": employment,
    //   "gender": gender,
    //   "status": status,
    //   "service": service,
    //   "resumeurl": resumeUrl,
    //   "companyId": companyID,
    //   "onboardingStatus": onboardingStatus,
    //   "createdAt": "${createdAt}T00:00:00Z",
    //   "terminationFlag": terminationFlag,
    //   "approved": approved,
    //   "dateofTermination": "${dateofTermination}T00:00:00Z",
    //   "dateofResignation": "${dateofResignation}T00:00:00Z",
    //   "dateofHire": "${dateofHire}T00:00:00Z",
    //   "rehirable": rehirable,
    //   "position": position,
    //   "driverLicenceNbr": driverLicenceNbr,
    //   "finalAddress": finaladdress,
    //   "type": type,
    //   "reason": reason,
    //   "finalPayCheck": finalPayCheck,
    //   "checkDate": "${checkDate}T00:00:00Z",
    //   "grossPay": grossPay,
    //   "netPay": netpay,
    //   "methods": method,
    //   "materials": material,
    //   "race": race,
    //   if (imageFile != null) 'file': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    // });

    // Prepare the request
//     final Api api = Api(context);
//     final response = await api.post(
//       path: HRModuleAEClinicalRepository.addphoto(employeeID: emplyId),
//       data: {
//         "employeeId": emplyId,
//         "code": code,
//         "userId": userId,
//         "firstName": firstName,
//         "lastName": lastName,
//         "departmentId": dptID,
//         "employeeTypeId": emplyTypeId,
//         "expertise": expritise,
//         "cityId": cityID,
//         "countryId": countryID,
//         "zoneId": zoneID,
//         "SSNNbr": ssnnBr,
//         "primaryPhoneNbr": primeNo,
//         "secondryPhoneNbr": secNo,
//         "workPhoneNbr": workNo,
//         "regOfficId": regOfficeId,
//         "personalEmail": personalEmail,
//         "workEmail": workEmail,
//         "address": address,
//         "dateOfBirth": "${dob}T00:00:00Z",
//         "emergencyContact": emgContact,
//         "covreage": coverage,
//         "employment": employment,
//         "gender": gender,
//         "status": status,
//         "service": service,
//         "resumeurl": resumeUrl,
//         "companyId": companyID,
//         "onboardingStatus": onboardingStatus,
//         "createdAt": "${createdAt}T00:00:00Z",
//         "terminationFlag": terminationFlag,
//         "approved": approved,
//         "dateofTermination": "${dateofTermination}T00:00:00Z",
//         "dateofResignation": "${dateofResignation}T00:00:00Z",
//         "dateofHire": "${dateofHire}T00:00:00Z",
//         "rehirable": rehirable,
//         "position": position,
//         "driverLicenceNbr": driverLicenceNbr,
//         "finalAddress": finaladdress,
//         "type": type,
//         "reason": reason,
//         "finalPayCheck": finalPayCheck,
//         "checkDate": "${checkDate}T00:00:00Z",
//         "grossPay": grossPay,
//         "netPay": netpay,
//         "methods": method,
//         "materials": material,
//         "race": race,
//       },
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Photo Uploaded");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: true,
//         message: response.statusMessage!,
//       );
//     } else {
//       print("Error 1");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: false,
//         message: response.data['message'],
//       );
//     }
//   } catch (e) {
//     print("Error $e");
//     return ApiData(
//       statusCode: 404,
//       success: false,
//       message: AppString.somethingWentWrong,
//     );
//   }
// }
//
//
//
//
//
//
//
// Future<ApiData> addPhotoUpload(
//     BuildContext context,
//     int emplyId,
//     String code,
//     int userId,
//     String firstName,
//     String lastName,
//     int dptID,
//     int emplyTypeId,
//     String expritise,
//     int cityID,
//     int countryID,
//     int zoneID,
//     String ssnnBr,
//     String primeNo,
//     String secNo,
//     String workNo,
//     String regOfficeId,
//     String personalEmail,
//     String workEmail,
//     String address,
//     String dob,
//     String emgContact,
//     String coverage,
//     String employment,
//     String gender,
//     String status,
//     String service,
//     File? imageFile, // Updated to handle file
//     String imgUrl,
//     String resumeUrl,
//     int companyID,
//     bool terminationFlag,
//     bool approved,
//     String onboardingStatus,
//     String createdAt,
//     String driverLicenceNbr,
//     String dateofTermination,
//     String dateofResignation,
//     String dateofHire,
//     String rehirable,
//     String position,
//     String finaladdress,
//     String checkDate,
//     int grossPay,
//     String type,
//     String reason,
//     int finalPayCheck,
//     int netpay,
//     String method,
//     String material,
//     String race,
//     ) async {
//   try {
//     final Api api = Api(context);
//
//     final FormData data = FormData.fromMap({
//       "employeeId": emplyId,
//       "code": code,
//       "userId": userId,
//       "firstName": firstName,
//       "lastName": lastName,
//       "departmentId": dptID,
//       "employeeTypeId": emplyTypeId,
//       "expertise": expritise,
//       "cityId": cityID,
//       "countryId": countryID,
//       "zoneId": zoneID,
//       "SSNNbr": ssnnBr,
//       "primaryPhoneNbr": primeNo,
//       "secondryPhoneNbr": secNo,
//       "workPhoneNbr": workNo,
//       "regOfficId": regOfficeId,
//       "personalEmail": personalEmail,
//       "workEmail": workEmail,
//       "address": address,
//       "dateOfBirth": "${dob}T00:00:00Z",
//       "emergencyContact": emgContact,
//       "covreage": coverage,
//       "employment": employment,
//       "gender": gender,
//       "status": status,
//       "service": service,
//       "imgurl": imgUrl,
//       "resumeurl": resumeUrl,
//       "companyId": companyID,
//       "onboardingStatus": onboardingStatus,
//       "createdAt": "${createdAt}T00:00:00Z",
//       "terminationFlag": terminationFlag,
//       "approved": approved,
//       "dateofTermination": "${dateofTermination}T00:00:00Z",
//       "dateofResignation": "${dateofResignation}T00:00:00Z",
//       "dateofHire": "${dateofHire}T00:00:00Z",
//       "rehirable": rehirable,
//       "position": position,
//       "driverLicenceNbr": driverLicenceNbr,
//       "finalAddress": finaladdress,
//       "type": type,
//       "reason": reason,
//       "finalPayCheck": finalPayCheck,
//       "checkDate": "${checkDate}T00:00:00Z",
//       "grossPay": grossPay,
//       "netPay": netpay,
//       "methods": method,
//       "materials": material,
//       "race": race,
//       if (imageFile != null) 'file': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
//     });
//
//     final response = await api.postMultipart(
//       path: HRModuleAEClinicalRepository.addphoto(employeeID: emplyId),
//       data: data,
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Photo Uploaded");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: true,
//         message: response.statusMessage!,
//       );
//     } else {
//       print("Error 1");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: false,
//         message: response.data['message'] ?? 'Unknown error',
//       );
//     }
//   } catch (e) {
//     print("Error $e");
//     return ApiData(
//       statusCode: 404,
//       success: false,
//       message: 'Something went wrong',
//     );
//   }
// }

///
// class ImageUploadService {
//   final Dio _dio = Dio();
//   final Map<String, String> headers = {
//     'Authorization': 'Bearer YOUR_BEARER_TOKEN_HERE'
//   };
//
//   Future<void> uploadImage(XFile? pickedFile) async {
//     if (pickedFile == null) {
//       print("No image selected.");
//       return;
//     }
//
//     try {
//       FormData data = FormData.fromMap({
//         'files': [
//           MultipartFile.fromBytes(
//             await pickedFile.readAsBytes(),
//             filename: pickedFile.name,
//           )
//         ],
//       });
//
//       Response response = await _dio.request(
//         'http://50.112.139.35:3000/employees/attach-photo/27',
//         options: Options(
//           method: 'POST',
//           headers: headers,
//         ),
//         data: data,
//       );
//
//       if (response.statusCode == 200) {
//         print("Image uploaded successfully");
//         print(response.data);
//       } else {
//         print("Image upload failed. Status code: ${response.statusCode}");
//         print("Error: ${response.statusMessage}");
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//       if (e is DioError) {
//         if (e.response != null) {
//           print('Dio error response data: ${e.response?.data}');
//           print('Dio error response headers: ${e.response?.headers}');
//           print('Dio error response status code: ${e.response?.statusCode}');
//         } else {
//           print('Error sending request: ${e.message}');
//         }
//       }
//     }
//   }
// }
//
// Future<ApiData> addPhotoUpload(
//     BuildContext context,
//     int emplyId,
//     String code,
//     int userId,
//     String firstName,
//     String lastName,
//     int dptID,
//     int emplyTypeId,
//     String expritise,
//     int cityID,
//     int countryID,
//     int zoneID,
//     String ssnnBr,
//     String primeNo,
//     String secNo,
//     String workNo,
//     String regOfficeId,
//     String personalEmail,
//     String workEmail,
//     String address,
//     String dob,
//     String emgContact,
//     String coverage,
//     String employment,
//     String gender,
//     String status,
//     String service,
//     String imgUrl, // This is the URL of the image
//     String resumeUrl,
//     int companyID,
//     bool terminationFlag,
//     bool approved,
//     String onboardingStatus,
//     String createdAt,
//     String driverLicenceNbr,
//     String dateofTermination,
//     String dateofResignation,
//     String dateofHire,
//     String rehirable,
//     String position,
//     String finaladdress,
//     String checkDate,
//     int grossPay,
//     String type,
//     String reason,
//     int finalPayCheck,
//     int netpay,
//     String method,
//     String material,
//     String race,
//     ) async {
//   try {
//     var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/tea/')); // Replace with your API endpoint
//
//     // If you want to use the image URL directly instead of a file
//     request.fields['imageUrl'] = imgUrl; // Replace 'imageUrl' with the correct field name if different
//
//     request.fields['employeeId'] = emplyId.toString();
//     request.fields['code'] = code;
//     request.fields['userId'] = userId.toString();
//     request.fields['firstName'] = firstName;
//     request.fields['lastName'] = lastName;
//     request.fields['departmentId'] = dptID.toString();
//     request.fields['employeeTypeId'] = emplyTypeId.toString();
//     request.fields['expertise'] = expritise;
//     request.fields['cityId'] = cityID.toString();
//     request.fields['countryId'] = countryID.toString();
//     request.fields['zoneId'] = zoneID.toString();
//     request.fields['SSNNbr'] = ssnnBr;
//     request.fields['primaryPhoneNbr'] = primeNo;
//     request.fields['secondryPhoneNbr'] = secNo;
//     request.fields['workPhoneNbr'] = workNo;
//     request.fields['regOfficId'] = regOfficeId;
//     request.fields['personalEmail'] = personalEmail;
//     request.fields['workEmail'] = workEmail;
//     request.fields['address'] = address;
//     request.fields['dateOfBirth'] = "${dob}T00:00:00Z";
//     request.fields['emergencyContact'] = emgContact;
//     request.fields['covreage'] = coverage;
//     request.fields['employment'] = employment;
//     request.fields['gender'] = gender;
//     request.fields['status'] = status;
//     request.fields['service'] = service;
//     request.fields['resumeurl'] = resumeUrl;
//     request.fields['companyId'] = companyID.toString();
//     request.fields['onboardingStatus'] = onboardingStatus;
//     request.fields['createdAt'] = "${createdAt}T00:00:00Z";
//     request.fields['terminationFlag'] = terminationFlag.toString();
//     request.fields['approved'] = approved.toString();
//     request.fields['dateofTermination'] = "${dateofTermination}T00:00:00Z";
//     request.fields['dateofResignation'] = "${dateofResignation}T00:00:00Z";
//     request.fields['dateofHire'] = "${dateofHire}T00:00:00Z";
//     request.fields['rehirable'] = rehirable;
//     request.fields['position'] = position;
//     request.fields['driverLicenceNbr'] = driverLicenceNbr;
//     request.fields['finalAddress'] = finaladdress;
//     request.fields['type'] = type;
//     request.fields['reason'] = reason;
//     request.fields['finalPayCheck'] = finalPayCheck.toString();
//     request.fields['checkDate'] = "${checkDate}T00:00:00Z";
//     request.fields['grossPay'] = grossPay.toString();
//     request.fields['netPay'] = netpay.toString();
//     request.fields['methods'] = method;
//     request.fields['materials'] = material;
//     request.fields['race'] = race;
//
//     var response = await request.send();
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return ApiData(
//         statusCode: response.statusCode,
//         success: true,
//         message: 'Upload Successful',
//       );
//     } else {
//       return ApiData(
//         statusCode: response.statusCode,
//         success: false,
//         message: 'Upload Failed',
//       );
//     }
//   } catch (e) {
//     return ApiData(
//       statusCode: 500,
//       success: false,
//       message: 'Something went wrong: $e',
//     );
//   }
// }
//
//
//
//
