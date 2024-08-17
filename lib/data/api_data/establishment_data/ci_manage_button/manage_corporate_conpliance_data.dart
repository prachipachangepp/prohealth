class ManageCCDoc {
  final int docId;
  final int documentTypeId;
  final int documentSubTypeId;
  final String? docname;
  final String doccreatedAt;
  final String url;
  final String? expiryType;
  final String? expiryDate;
  final String expiryReminder;
  final int companyId;
  final String officeId;
  final bool sucess;
  final String message;

  ManageCCDoc(
      {required this.documentTypeId,
        required this.documentSubTypeId,
        required this.url,
        required this.expiryReminder,
        required this.companyId,
        required this.officeId,
        required this.sucess,
        required this.message,
        required this.doccreatedAt,
        required this.docId,
        this.docname,
        this.expiryType,
        this.expiryDate,
      });
}


