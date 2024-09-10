class TypeofDocpopup {
  final int orgDocumentSetupid;
  final int documenttypeid;
  final int documentsubtypeid;
  final String docname;
  final String expirytype;
  final int threshold;
  final String expirydate;
  final String expiryreminder;
  final int companyid;
  final String idOfDocument;

  TypeofDocpopup(
      {required this.orgDocumentSetupid,
      required this.documenttypeid,
      required this.documentsubtypeid,
      required this.docname,
      required this.expirytype,
      required this.threshold,
      required this.expirydate,
      required this.expiryreminder,
      required this.companyid,
      required this.idOfDocument});
}




//////

class NewOrgDocumentManage {
  final int orgOfficeDocumentId;
  final int orgDocumentSetupid;
  final String idOfDocument;
  final String expirydate;
  final String doccreatedat;
  final int companyid;
  final String url;
  final String officeid;

  NewOrgDocumentManage(
      {required this.orgOfficeDocumentId,
      required this.orgDocumentSetupid,
      required this.idOfDocument,
      required this.expirydate,
      required this.doccreatedat,
      required this.companyid,
      required this.url,
      required this.officeid});
}
