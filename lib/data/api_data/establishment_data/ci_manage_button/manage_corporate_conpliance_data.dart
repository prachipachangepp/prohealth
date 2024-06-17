///get doc type : /document-type
class GetManageDetailsHeadData{
  final int? id;
  final String? docName;
  final bool sucess;
  final String message;

  GetManageDetailsHeadData({this.id, this.docName, required this.sucess, required this.message,});
}

///get document subtype: /identity/GetDocType/{document_type_id}
class GetManageDetailsSubHeadData{
  final int docTypeId;
  final String docType;
  final int subDocTypeId;
  final String subDocType;
  final bool sucess;
  final String message;
  GetManageDetailsSubHeadData({required this.docTypeId, required this.docType,required this.subDocTypeId,required this.subDocType,required this.sucess,required this.message, });
}