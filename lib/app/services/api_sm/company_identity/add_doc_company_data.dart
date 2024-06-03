///post addDocToCompany
class Company {
  final String companyId;
  final String name;
  final String description;
  final String url;
  final Logo logo;
  final Contact contact;
  final String address;
  final String headOfficeId;
  final List<Office> offices;

  Company({
    required this.companyId,
    required this.name,
    required this.description,
    required this.url,
    required this.logo,
    required this.contact,
    required this.address,
    required this.headOfficeId,
    required this.offices,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['company_id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      logo: Logo.fromJson(json['logo']),
      contact: Contact.fromJson(json['contact']),
      address: json['address'],
      headOfficeId: json['head_office_id'],
      offices:
          List<Office>.from(json['offices'].map((x) => Office.fromJson(x))),
    );
  }
}

class Logo {
  final String main;
  final String app;
  final String web;

  Logo({
    required this.main,
    required this.app,
    required this.web,
  });

  factory Logo.fromJson(Map<String, dynamic> json) {
    return Logo(
      main: json['company']['main'],
      app: json['app'],
      web: json['web'],
    );
  }
}

class Contact {
  final List<Phone> phones;
  final List<String> fax;
  final String email;

  Contact({
    required this.phones,
    required this.fax,
    required this.email,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phones: List<Phone>.from(json['phones'].map((x) => Phone.fromJson(x))),
      fax: List<String>.from(json['fax']),
      email: json['email'],
    );
  }
}

class Phone {
  final String primary;
  final String secondary;

  Phone({
    required this.primary,
    required this.secondary,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      primary: json['primary'],
      secondary: json['secondary'],
    );
  }
}

class Office {
  final String id;
  final String name;
  final String address;
  final String email;
  final List<String> phones;
  final List<String> zones;
  final List<Service> services;
  final List<Document> documents;

  Office({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phones,
    required this.zones,
    required this.services,
    required this.documents,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phones: List<String>.from(json['phones']),
      zones: List<String>.from(json['zones']),
      services:
          List<Service>.from(json['services'].map((x) => Service.fromJson(x))),
      documents: List<Document>.from(
          json['documents'].map((x) => Document.fromJson(x))),
    );
  }
}

class Service {
  final String serviceName;
  final String serviceId;
  final String npiNumber;
  final String medicareProviderId;
  final String hcoNumId;

  Service({
    required this.serviceName,
    required this.serviceId,
    required this.npiNumber,
    required this.medicareProviderId,
    required this.hcoNumId,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['service_name'],
      serviceId: json['service_id'],
      npiNumber: json['npi_number'],
      medicareProviderId: json['medicare_provider_id'],
      hcoNumId: json['hco_num_id'],
    );
  }
}

class Document {
  final CorporateDocs? corporateDocs;
  final InsuranceContracts? insuranceContracts;
  final VendorContracts? vendorContracts;
  final Policies? policies;

  Document({
    required this.corporateDocs,
    required this.insuranceContracts,
    required this.vendorContracts,
    required this.policies,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      corporateDocs: json['documents']['corporate_docs'] != null
          ? CorporateDocs.fromJson(json['documents']['corporate_docs'])
          : null,
      insuranceContracts: json['documents']['insurance_contracts'] != null
          ? InsuranceContracts.fromJson(
              json['documents']['insurance_contracts'])
          : null,
      vendorContracts: json['documents']['vendor_contracts'] != null
          ? VendorContracts.fromJson(json['documents']['vendor_contracts'])
          : null,
      policies: json['documents']['policies'] != null
          ? Policies.fromJson(json['documents']['policies'])
          : null,
    );
  }
}

class CorporateDocs {
  final List<License> licenses;

  CorporateDocs({
    required this.licenses,
  });

  factory CorporateDocs.fromJson(Map<String, dynamic> json) {
    return CorporateDocs(
      licenses:
          List<License>.from(json['licenses'].map((x) => License.fromJson(x))),
    );
  }
}

class License {
  final String docId;
  final String docName;
  final List<DocData> docData;

  License({
    required this.docId,
    required this.docName,
    required this.docData,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      docId: json['doc_id'],
      docName: json['doc_name'],
      docData:
          List<DocData>.from(json['doc_data'].map((x) => DocData.fromJson(x))),
    );
  }
}

class DocData {
  final String createdAt;
  final Expiry expiry;

  DocData({
    required this.createdAt,
    required this.expiry,
  });

  factory DocData.fromJson(Map<String, dynamic> json) {
    return DocData(
      createdAt: json['created_at'],
      expiry: Expiry.fromJson(json['expiry']),
    );
  }
}

class Expiry {
  final int type;
  final String date;
  final int reminder;

  Expiry({
    required this.type,
    required this.date,
    required this.reminder,
  });

  factory Expiry.fromJson(Map<String, dynamic> json) {
    return Expiry(
      type: json['type'],
      date: json['date'],
      reminder: json['reminder'],
    );
  }
}

class InsuranceContracts {
  final List<InsuranceContract> noSubtype;

  InsuranceContracts({
    required this.noSubtype,
  });

  factory InsuranceContracts.fromJson(Map<String, dynamic> json) {
    return InsuranceContracts(
      noSubtype: List<InsuranceContract>.from(
          json['no_subtype'].map((x) => InsuranceContract.fromJson(x))),
    );
  }
}

class InsuranceContract {
  final String docId;
  final String docName;
  final List<DocData> docData;

  InsuranceContract({
    required this.docId,
    required this.docName,
    required this.docData,
  });

  factory InsuranceContract.fromJson(Map<String, dynamic> json) {
    return InsuranceContract(
      docId: json['doc_id'],
      docName: json['doc_name'],
      docData:
          List<DocData>.from(json['doc_data'].map((x) => DocData.fromJson(x))),
    );
  }
}

class VendorContracts {
  final List<dynamic> contracts;

  VendorContracts({
    required this.contracts,
  });

  factory VendorContracts.fromJson(Map<String, dynamic> json) {
    return VendorContracts(
      contracts: List<dynamic>.from(json['contracts']),
    );
  }
}

class Policies {
  final List<dynamic> policies;

  Policies({
    required this.policies,
  });

  factory Policies.fromJson(Map<String, dynamic> json) {
    return Policies(
      policies: List<dynamic>.from(json['policies']),
    );
  }
}
