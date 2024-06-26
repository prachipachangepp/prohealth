

//
//
// class S3Service {
//   final String _accessKeyId = 'AKIAU5UP6ITKKAGCXEXK';
//   final String _secretAccessKey = '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';
//   final String _region = ' us-west-2 ';
//   final String _bucketName = 'symmetry-office-document';
//
//   Set getS3Client() {
//     final s3 = S3(
//       region: _region,
//       credentials: AwsClientCredentials(
//         accessKey: _accessKeyId,
//         secretKey: _secretAccessKey,
//       ),
//     );
//     return s3;
//   }
//
//   Future<String> getPresignedUrl(String key) async {
//     final s3 = getS3Client();
//     final params = GetObjectRequest(bucket: _bucketName, key: key);
//     final url = s3.getSignedUrl('getObject', params, expires: 900);
//     return url;
//   }
// }
