class RoleManagerData {
  final int deptID;
  final String deptName;
  final String description;

  RoleManagerData({required this.deptID, required this.deptName, required this.description,});
}

class ModuleMetaData {
  final int? appModuleMetaDataId;
  final String mainModule;
  final String iconUrl;
  final bool sucess;
  final String message;

  ModuleMetaData({required this.sucess, required this.message,required this.appModuleMetaDataId, required this.mainModule, required this.iconUrl,});
}