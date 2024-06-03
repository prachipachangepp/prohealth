///get api get company by id(var name can be random)
// class CompanyDataGet {
//   final String? company_id;
//   final String? address;
//   final Contact? contact;
//   final Office? offices;
//   final String? name;
//   final String? description;
//   final Logo? logo;
//   final String? url;
//   final String? headOfficeId;
//
//
//   CompanyDataGet({
//   required this.company_id,
//   required this.address,
//   required this.contact,
//   required this.offices,
//   required this.name,
//   required this.description,
//   required this.logo,
//   required this.url,
//   required this.headOfficeId,
//   });
//
//   factory CompanyDataGet.fromJson(Map<String, dynamic> json) {
//     return CompanyDataGet(
//         company_id: json['companyId'] as String?,
//       name: json['company']['name'] as String?,
//       description: json['company']['description'] as String?,
//       url: json['company']['url'] as String?,
//       address: json['company']['address'] as String?,
//       headOfficeId: json['company']['head_office_id'] as String?,
//      // logo: Logo.fromJson(json['company']['logo']) as Logo?,
//         logo: Logo.fromJson({
//           "app": "https://www.abchealthcare.com/app_logo.png",
//           "web": "https://www.abchealthcare.com/web_logo.png",
//           "main": "https://www.abchealthcare.com/logo.png"
//         }),
//      // contact: Contact.fromJson(json['company']['contact']) as Contact?,
//         contact: Contact.fromJson(
//             {
//               "fax": [
//                 "+1-555-1234567",
//                 "+1-555-9876543"
//               ],
//               "phones": [
//                 {
//                   "secondary": "+1-555-1234567",
//                   "primary": "+1-555-1234567"
//                 }
//               ],
//               "email": "info@abchealthcare.com"
//             }
//         ),
//     //  offices: Office.fromJson(json['company']['offices']) as Office?
//       offices: Office.fromJson(
//         {
//           "address": "1234 Elm Street, Suite 567, Springfield, IL 62704",
//           "documents": [
//             {
//               "corporate_docs": {
//                 "licenses": [
//                   {
//                     "doc_id": "",
//                     "doc_name": "",
//                     "doc_data": [
//                       {
//                         "created_at": "2023-04-11T16:27:17.666Z",
//                         "url": "https://documents-hr-module.s3.us-west-1.amazonaws.com/1681230437493123",
//                         "expiry": {
//                           "type": 2,
//                           "date": "",
//                           "reminder": 32
//                         }
//                       }
//                     ]
//                   }
//                 ]
//               }
//             },
//             {
//               "policies": {},
//               "insurance_contracts": {
//                 "no_subtype": [
//                   {
//                     "doc_id": "",
//                     "doc_name": "",
//                     "doc_data": [
//                       {
//                         "created_at": "2023-04-11T16:27:17.666Z",
//                         "url": "https://documents-hr-module.s3.us-west-1.amazonaws.com/1681230437493123",
//                         "expiry": {
//                           "type": 2,
//                           "date": "",
//                           "reminder": 32
//                         }
//                       }
//                     ]
//                   }
//                 ]
//               },
//               "vendor_contracts": {}
//             }
//           ],
//           "name": "Head Office",
//           "phones": [
//             "+1-555-1234567"
//           ],
//           "id": "office_1",
//           "services": [
//             {
//               "npi_number": "1234567890",
//               "service_name": "Cardiology",
//               "service_id": "cardio_123",
//               "medicare_provider_id": "MPID123",
//               "hco_num_id": "65687"
//             },
//             {
//               "npi_number": "0987654321",
//               "service_name": "Dermatology",
//               "service_id": "derma_456",
//               "medicare_provider_id": "MPID456",
//               "hco_num_id": "65687"
//             }
//           ],
//           "email": "info@abchealthcare.com"
//         },
//       )
//     );
//   }
// }
//
// class Logo {
//   final String? main;
//   final String? app;
//   final String? web;
//
//   Logo({required this.main, required this.app, required this.web});
//
//   factory Logo.fromJson(Map<String, dynamic> json) {
//     return Logo(
//       main: json['main'] as String?,
//       app: json['app'] as String?,
//       web: json['web'] as String?,
//     );
//   }
// }
//
// class Contact {
//   final List<String> phones;
//   final List<String> fax;
//   final String email;
//   Contact({required this.phones,
//     required this.fax,
//     required this.email});
//
//   factory Contact.fromJson(Map<String, dynamic> json) {
//     return Contact(
//       phones: List<String>.from(json['phones']),
//      fax: ['one'],
//      // fax: List<String>.from(json['company']['fax'][]),
//       email: json['email'],
//     );
//   }
// }
//
// class Phone {
//   final String? primary;
//   final String? secondary;
//
//   Phone({
//     required this.primary,
//     required this.secondary,
//   });
//
//   factory Phone.fromJson(Map<String, dynamic> json) {
//     return Phone(
//       primary: json['primary'] as String?,
//       secondary: json['secondary'] as String?,
//     );
//   }
// }
//
// class Office {
//   final String? id;
//   final String? name;
//   final String? address;
//   final String? email;
//   final Phone? phones;
//   final String? zones;
//   final Service? services;
//   //final Document? documents;
//
//   Office({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.email,
//     required this.phones,
//     required this.zones,
//     required this.services,
//     //required this.documents,
//   });
//
//   factory Office.fromJson(Map<String, dynamic> json) {
//     return Office(
//       id: json['id'] as String?,
//       name: json['name'] as String? ,
//       address: json['address'] as String?,
//       email: json['email'] as String?,
//       //logo: Logo.fromJson(json['logo']) as Logo?,
//       phones: Phone.fromJson(json['phones']) as Phone?,
//       zones: json['zones']  as String?,
//       services: Service.fromJson(json['services']) as Service?,
//       //documents: Document.fromJson(json['documents'])  as Document?
//     );
//   }
// }
//
// class Service {
//   final String? serviceName;
//   final String? serviceId;
//   final String? npiNumber;
//   final String? medicareProviderId;
//   final String? hcoNumId;
//
//   Service({
//     required this.serviceName,
//     required this.serviceId,
//     required this.npiNumber,
//     required this.medicareProviderId,
//     required this.hcoNumId,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       serviceName: json['service_name'] as String?,
//       serviceId: json['service_id'] as String?,
//       npiNumber: json['npi_number'] as String?,
//       medicareProviderId: json['medicare_provider_id'] as String?,
//       hcoNumId: json['hco_num_id'] as String?,
//     );
//   }
// }
//
// class Document {
//   final Map<String, dynamic> corporateDocs;
//   final Map<String, dynamic> insuranceContracts;
//   final Map<String, dynamic> vendorContracts;
//   final Map<String, dynamic> policies;
//
//   Document({
//     required this.corporateDocs,
//     required this.insuranceContracts,
//     required this.vendorContracts,
//     required this.policies,
//   });
//
//   factory Document.fromJson(Map<String, dynamic> json) {
//     return Document(
//       corporateDocs: json['corporate_docs'] ?? {},
//       insuranceContracts: json['insurance_contracts'] ?? {},
//       vendorContracts: json['vendor_contracts'] ?? {},
//       policies: json['policies'] ?? {},
//     );
//   }
// }

//
// class CorporateDocs {
//   final List<License> licenses;
//
//   CorporateDocs({
//     required this.licenses,
//   });
//
//   factory CorporateDocs.fromJson(Map<String, dynamic> json) {
//     return CorporateDocs(
//       licenses:
//       List<License>.from(json['company']['licenses'].map((x) => License.fromJson(x))),
//     );
//   }
// }
//
// class License {
//   final String docId;
//   final String docName;
//   final List<DocData> docData;
//
//   License({
//     required this.docId,
//     required this.docName,
//     required this.docData,
//   });
//
//   factory License.fromJson(Map<String, dynamic> json) {
//     return License(
//       docId: json['company']['doc_id'],
//       docName: json['company']['doc_name'],
//       docData: List<DocData>.from(json['company']['doc_data'].map((x) => DocData.fromJson(x))),
//     );
//   }
// }
//
// class DocData {
//   final String createdAt;
//   final Expiry expiry;
//
//   DocData({
//     required this.createdAt,
//     required this.expiry,
//   });
//
//   factory DocData.fromJson(Map<String, dynamic> json) {
//     return DocData(
//       createdAt: json['company']['created_at'],
//       expiry: Expiry.fromJson(json['company']['expiry']),
//     );
//   }
// }
//
// class Expiry {
//   final int type;
//   final String date;
//   final int reminder;
//
//   Expiry({
//     required this.type,
//     required this.date,
//     required this.reminder,
//   });
//
//   factory Expiry.fromJson(Map<String, dynamic> json) {
//     return Expiry(
//       type: json['company']['type'],
//       date: json['company']['date'],
//       reminder: json['company']['reminder'],
//     );
//   }
// }
//
// class InsuranceContracts {
//   final List<InsuranceContract> noSubtype;
//
//   InsuranceContracts({
//     required this.noSubtype,
//   });
//
//   factory InsuranceContracts.fromJson(Map<String, dynamic> json) {
//     return InsuranceContracts(
//       noSubtype: List<InsuranceContract>.from(
//           json['no_subtype'].map((x) => InsuranceContract.fromJson(x))),
//     );
//   }
// }
//
// class InsuranceContract {
//   final String docId;
//   final String docName;
//   final List<DocData> docData;
//
//   InsuranceContract({
//     required this.docId,
//     required this.docName,
//     required this.docData,
//   });
//
//   factory InsuranceContract.fromJson(Map<String, dynamic> json) {
//     return InsuranceContract(
//       docId: json['company']['doc_id'],
//       docName: json['company']['doc_name'],
//       docData:
//       List<DocData>.from(json['company']['doc_data'].map((x) => DocData.fromJson(x))),
//     );
//   }
// }
//
// class VendorContracts {
//   final List<dynamic> contracts;
//
//   VendorContracts({
//     required this.contracts,
//   });
//
//   factory VendorContracts.fromJson(Map<String, dynamic> json) {
//     return VendorContracts(
//       contracts: List<dynamic>.from(json['company']['contracts']),
//     );
//   }
// }
//
// class Policies {
//   final List<dynamic> policies;
//
//   Policies({
//     required this.policies,
//   });
//
//   factory Policies.fromJson(Map<String, dynamic> json) {
//     return Policies(
//       policies: List<dynamic>.from(json['company']['policies']),
//     );
//   }
// }
///
class Office {
  final String? address;
  final String? name;

  Office({required this.address, required this.name});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      address: json['address'] as String?,
      name: json['name'] as String?,
    );
  }
}

///
///unchanged
// ///get api get company by id
// class CompanyDataGet {
//   final String? companyId;
//   final String? name;
//   final String? description;
//   final String? url;
//   final Logo? logo;
//   final Contact? contact;
//   final String? address;
//   final String? headOfficeId;
//   final List<Office>? offices;
//
//   CompanyDataGet({
//     required this.companyId,
//     required this.name,
//     required this.description,
//     required this.url,
//     required this.logo,
//     required this.contact,
//     required this.address,
//     required this.headOfficeId,
//     required this.offices,
//   });
//
//   factory CompanyDataGet.fromJson(Map<String, dynamic> json) {
//     return CompanyDataGet(
//       companyId: json['company_id'] as String?,
//       name: json['name'] as String?,
//       description: json['description'] as String?,
//       url: json['url'] as String?,
//       logo: Logo.fromJson(json['logo']) as Logo?,
//       contact: Contact.fromJson(json['contact']) as Contact?,
//       address: json['address'] as String?,
//       headOfficeId: json['head_office_id'] as String?,
//       offices: List<Office>.from(
//           json['offices'].map((office) => Office.fromJson(office))),
//     );
//   }
// }
//
// class Logo {
//   final String main;
//   final String app;
//   final String web;
//
//   Logo({required this.main, required this.app, required this.web});
//
//   factory Logo.fromJson(Map<String, dynamic> json) {
//     return Logo(
//       main: json['main'],
//       app: json['app'],
//       web: json['web'],
//     );
//   }
// }
//
// class Contact {
//   final List<String> phones;
//   final List<String> fax;
//   final String email;
//   Contact({required this.phones, required this.fax, required this.email});
//
//   factory Contact.fromJson(Map<String, dynamic> json) {
//     return Contact(
//       phones: List<String>.from(json['phones']),
//       fax: List<String>.from(json['fax']),
//       email: json['email'],
//     );
//   }
// }
//
// class Phone {
//   final String primary;
//   final String secondary;
//
//   Phone({
//     required this.primary,
//     required this.secondary,
//   });
//
//   factory Phone.fromJson(Map<String, dynamic> json) {
//     return Phone(
//       primary: json['primary'],
//       secondary: json['secondary'],
//     );
//   }
// }
//
// class Office {
//   final String id;
//   final String? name;
//   final String? address;
//   final String email;
//   final List<String> phones;
//   final List<String> zones;
//   final List<Service> services;
//   final List<Document> documents;
//
//   Office({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.email,
//     required this.phones,
//     required this.zones,
//     required this.services,
//     required this.documents,
//   });
//
//   factory Office.fromJson(Map<String, dynamic> json) {
//     return Office(
//       id: json['id'],
//       name: json['name'] as String? ,
//       address: json['address'] as String?,
//       email: json['email'],
//       phones: List<String>.from(json['phones']),
//       zones: json['zones'] != null ? List<String>.from(json['zones']) : [],
//       services: List<Service>.from(
//           json['services'].map((service) => Service.fromJson(service))),
//       documents: json['documents'] != null
//           ? List<Document>.from(
//               json['documents'].map((doc) => Document.fromJson(doc)))
//           : [],
//     );
//   }
// }
//
// class Service {
//   final String serviceName;
//   final String serviceId;
//   final String npiNumber;
//   final String medicareProviderId;
//   final String hcoNumId;
//
//   Service({
//     required this.serviceName,
//     required this.serviceId,
//     required this.npiNumber,
//     required this.medicareProviderId,
//     required this.hcoNumId,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       serviceName: json['service_name'],
//       serviceId: json['service_id'],
//       npiNumber: json['npi_number'],
//       medicareProviderId: json['medicare_provider_id'],
//       hcoNumId: json['hco_num_id'],
//     );
//   }
// }
//
// class Document {
//   final Map<String, dynamic> corporateDocs;
//   final Map<String, dynamic> insuranceContracts;
//   final Map<String, dynamic> vendorContracts;
//   final Map<String, dynamic> policies;
//
//   Document({
//     required this.corporateDocs,
//     required this.insuranceContracts,
//     required this.vendorContracts,
//     required this.policies,
//   });
//
//   factory Document.fromJson(Map<String, dynamic> json) {
//     return Document(
//       corporateDocs: json['corporate_docs'] ?? {},
//       insuranceContracts: json['insurance_contracts'] ?? {},
//       vendorContracts: json['vendor_contracts'] ?? {},
//       policies: json['policies'] ?? {},
//     );
//   }
// }
//
// class CorporateDocs {
//   final List<License> licenses;
//
//   CorporateDocs({
//     required this.licenses,
//   });
//
//   factory CorporateDocs.fromJson(Map<String, dynamic> json) {
//     return CorporateDocs(
//       licenses:
//           List<License>.from(json['licenses'].map((x) => License.fromJson(x))),
//     );
//   }
// }
//
// class License {
//   final String docId;
//   final String docName;
//   final List<DocData> docData;
//
//   License({
//     required this.docId,
//     required this.docName,
//     required this.docData,
//   });
//
//   factory License.fromJson(Map<String, dynamic> json) {
//     return License(
//       docId: json['doc_id'],
//       docName: json['doc_name'],
//       docData:
//           List<DocData>.from(json['doc_data'].map((x) => DocData.fromJson(x))),
//     );
//   }
// }
//
// class DocData {
//   final String createdAt;
//   final Expiry expiry;
//
//   DocData({
//     required this.createdAt,
//     required this.expiry,
//   });
//
//   factory DocData.fromJson(Map<String, dynamic> json) {
//     return DocData(
//       createdAt: json['created_at'],
//       expiry: Expiry.fromJson(json['expiry']),
//     );
//   }
// }
//
// class Expiry {
//   final int type;
//   final String date;
//   final int reminder;
//
//   Expiry({
//     required this.type,
//     required this.date,
//     required this.reminder,
//   });
//
//   factory Expiry.fromJson(Map<String, dynamic> json) {
//     return Expiry(
//       type: json['type'],
//       date: json['date'],
//       reminder: json['reminder'],
//     );
//   }
// }
//
// class InsuranceContracts {
//   final List<InsuranceContract> noSubtype;
//
//   InsuranceContracts({
//     required this.noSubtype,
//   });
//
//   factory InsuranceContracts.fromJson(Map<String, dynamic> json) {
//     return InsuranceContracts(
//       noSubtype: List<InsuranceContract>.from(
//           json['no_subtype'].map((x) => InsuranceContract.fromJson(x))),
//     );
//   }
// }
//
// class InsuranceContract {
//   final String docId;
//   final String docName;
//   final List<DocData> docData;
//
//   InsuranceContract({
//     required this.docId,
//     required this.docName,
//     required this.docData,
//   });
//
//   factory InsuranceContract.fromJson(Map<String, dynamic> json) {
//     return InsuranceContract(
//       docId: json['doc_id'],
//       docName: json['doc_name'],
//       docData:
//           List<DocData>.from(json['doc_data'].map((x) => DocData.fromJson(x))),
//     );
//   }
// }
//
// class VendorContracts {
//   final List<dynamic> contracts;
//
//   VendorContracts({
//     required this.contracts,
//   });
//
//   factory VendorContracts.fromJson(Map<String, dynamic> json) {
//     return VendorContracts(
//       contracts: List<dynamic>.from(json['contracts']),
//     );
//   }
// }
//
// class Policies {
//   final List<dynamic> policies;
//
//   Policies({
//     required this.policies,
//   });
//
//   factory Policies.fromJson(Map<String, dynamic> json) {
//     return Policies(
//       policies: List<dynamic>.from(json['policies']),
//     );
//   }
// }
