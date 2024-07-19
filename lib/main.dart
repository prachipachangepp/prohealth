import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/dateprovider.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';



Future<void> main() async {
  bool token = await checkToken();
  runApp(
      ChangeNotifierProvider(
          create: (context) => DateProvider(),
     child: App(
        signedIn: token,
      )
  ));
}

Future<bool> checkToken() async {
  String token = await TokenManager.getAccessToken();
  if (token.isEmpty) {
    return false;
  } else {
    return true;
  }
}

//
// Future<void> main() async {
//   // final credentials = aws.AwsClientCredentials(
//   //   accessKey: 'your-access-key-id',
//   //   secretKey: 'your-secret-access-key',
//   // );
//   //
//   // // Initialize the AWS client
//   // aws.AWSClient.initialize(credentials);
//   // Amplify.addPlugins([AmplifyStorageS3()]);
//   // Amplify.configure(amplifyconfig);
//   // await _configureAmplify();
//   bool token = await checkToken();
//   runApp(
//       App(
//     signedIn: token,
//   )
//
//   );
// }
// //
// // Future<void> _configureAmplify() async {
// //   try {
// //     final amplify = Amplify;
// //     final storagePlugin = AmplifyStorageS3();
// //     await amplify.addPlugin(storagePlugin);
// //     var  amplifyconfig;
// //     await amplify.configure(amplifyconfig);
// //   } catch (e) {
// //     print('An error occurred configuring Amplify: $e');
// //   }
// // }
//
//
// Future<bool> checkToken() async {
//   String token = await TokenManager.getAccessToken();
//   if (token.isEmpty) {
//     return false;
//   } else {
//     return true;
//   }
// }