import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/provider/delete_popup_provider.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/heading_constant_widget.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../widgets/error_popups/delete_success_popup.dart';

class HealthEmpDocProvider extends ChangeNotifier {
  final int metaDocID;
  HealthEmpDocProvider({required this.metaDocID});

  final StreamController<List<EmployeeDocumentModal>> _controller = StreamController<List<EmployeeDocumentModal>>();
  final int itemsPerPage = 10;
  bool _isLoading = false;
  int currentPage = 1;
  int flexVal = 2;

  Stream<List<EmployeeDocumentModal>> get employeeDocumentsStream => _controller.stream;

  /// Explicit init method to pass BuildContext
  void init(BuildContext context) {
    _fetchEmployeeDocs(context);
  }

  /// Fetch data with BuildContext
  void _fetchEmployeeDocs(BuildContext context) async {
    try {
      final data = await getEmployeeDoc(context, metaDocID, 1, 20);
      _controller.add(data);
    } catch (error) {
      _controller.addError(error);
    }
  }

  List<EmployeeDocumentModal> getPaginatedData(List<EmployeeDocumentModal> docs) {
    return docs.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
  }

  String getSerialNumber(int index) {
    return (index + 1 + (currentPage - 1) * itemsPerPage).toString().padLeft(2, '0');
  }

  void onPreviousPagePressed() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  void onPageNumberPressed(int pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }

  void onNextPagePressed() {
    currentPage++;
    notifyListeners();
  }
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  void handleEdit(BuildContext context, EmployeeDocumentModal doc) async {
    // Set the loading state to true
    setLoading(true);

    try {
      final snapshotPrefill = await getPrefillEmployeeDocTab(context, doc.employeeDocTypesetupId);
      TextEditingController idOfDocController = TextEditingController(text: snapshotPrefill.idOfDocument.toString());
      TextEditingController nameDocController = TextEditingController(text: snapshotPrefill.docName.toString());
      TextEditingController daysController = TextEditingController(text: snapshotPrefill.reminderThreshold.toString());
      String? expiryType = snapshotPrefill.expiryType;
      int empSetupId = snapshotPrefill.employeeDocTypesetupId ?? 0;
      String docName = snapshotPrefill.docName ?? '';

      // Show the edit dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => EmpDocEditPopupProvider(),
            child: EmpDocEditPopup(
              title: EditPopupString.editDocument,
              expiryType: expiryType,
              idOfDocController: idOfDocController,
              enable: true,
              nameDocController: nameDocController,
              daysController: daysController,
              empsetupId: empSetupId,
              docname: docName,
              empdoctype: doc.employeeDocTypeMetaId == AppConfig.healthDocId
                  ? AppStringEM.health
                  : doc.employeeDocTypeMetaId == AppConfig.certificationDocId
                  ? AppStringEM.certifications
                  : doc.employeeDocTypeMetaId == AppConfig.employmentDocId
                  ? AppStringEM.employment
                  : doc.employeeDocTypeMetaId == AppConfig.clinicalVerificationDocId
                  ? AppStringEM.clinicalVerify
                  : doc.employeeDocTypeMetaId == AppConfig.acknowledgementDocId
                  ? AppStringEM.acknowledgement
                  : doc.employeeDocTypeMetaId == AppConfig.compensationDocId
                  ? AppStringEM.compensation
                  : AppStringEM.performance,
              employeeDocTypeMetaDataId: doc.employeeDocTypeMetaId,
              onEditSuccess: () {
                _fetchEmployeeDocs(context);
              },
            ),
          );
        },
      );
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void handleDelete(BuildContext context, EmployeeDocumentModal doc) async {
    // Show the confirmation dialog for deleting the document
    showDialog(
      context: context,
      builder: (context) {
              return DeletePopupProvider(
                title: DeletePopupString.deleteDocument,
                loadingDuration: _isLoading,
                onCancel: () {
                  Navigator.pop(context);
                },
                onDelete: () async {
                  setLoading(true);
                  try {
                    // Perform the delete operation
                    await employeedoctypeSetupIdDelete(context, doc.employeeDocTypesetupId);
                    _fetchEmployeeDocs(context);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => DeleteSuccessPopup(),
                    );
                  } finally{
                    _fetchEmployeeDocs(context);
                    setLoading(false);
                  }
                },
              );}
    );
  }
}

class HealthEmpDoc extends StatelessWidget {
  final int metaDocID;
  const HealthEmpDoc({super.key, required this.metaDocID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HealthEmpDocProvider>(
      create: (context) {
        final provider = HealthEmpDocProvider(metaDocID: metaDocID);
        provider.init(context); // Pass context here
        return provider;
      },
      child: Consumer<HealthEmpDocProvider>(
        builder: (context, provider, _) {
          return Container(
            child: Column(
              children: [
                TableHeadingConst(),
                SizedBox(height: AppSize.s10),
                Expanded(
                  child: StreamBuilder<List<EmployeeDocumentModal>>(
                    stream: provider.employeeDocumentsStream,
                    builder: (context, snapshot) {
                      provider._fetchEmployeeDocs(context);
                      print('Connection state: ${snapshot.connectionState}');
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.blueprime,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: AllNoDataAvailable.customTextStyle(context),
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        print('No data found');
                        return Center(
                          child: Text(
                            ErrorMessageString.noEmpDocc,
                            style: AllNoDataAvailable.customTextStyle(context),
                          ),
                        );
                      }

                      final employeeDocs = snapshot.data!;
                      print('Fetched ${employeeDocs.length} employee documents');

                      final paginatedData = provider.getPaginatedData(employeeDocs);

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: paginatedData.length,
                              itemBuilder: (context, index) {
                                final serialNumber = provider.getSerialNumber(index);
                                final employeeDoc = paginatedData[index];

                                return Column(
                                  children: [
                                    SizedBox(height: AppSize.s5),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: AppPadding.p5),
                                      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m50),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorManager.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      height: AppSize.s56,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Center(
                                              child: Text(
                                                serialNumber,
                                                style: DocumentTypeDataStyle.customTextStyle(context),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 114.0),
                                              child: Text(
                                                employeeDoc.idOfDocument ?? 'N/A',
                                                style: DocumentTypeDataStyle.customTextStyle(context),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                          const Expanded(flex: 1, child: SizedBox()),
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: AppPadding.p20),
                                              child: Text(
                                                employeeDoc.docName ?? 'N/A',
                                                textAlign: TextAlign.start,
                                                style: DocumentTypeDataStyle.customTextStyle(context),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Center(
                                              child: Text(
                                                employeeDoc.reminderThreshold ?? 'N/A',
                                                style: DocumentTypeDataStyle.customTextStyle(context),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      provider.handleEdit(context, employeeDoc);
                                                    },
                                                    icon: Icon(
                                                      Icons.edit_outlined,
                                                      size: IconSize.I18,
                                                      color: IconColorManager.bluebottom,
                                                    ),
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  IconButton(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    onPressed: () {
                                                      provider.handleDelete(context, employeeDoc);
                                                    },
                                                    icon: Icon(
                                                      size: IconSize.I18,
                                                      Icons.delete_outline_outlined,
                                                      color: IconColorManager.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          PaginationControlsWidget(
                            currentPage: provider.currentPage,
                            items: employeeDocs,
                            itemsPerPage: provider.itemsPerPage,
                            onPreviousPagePressed: provider.onPreviousPagePressed,
                            onPageNumberPressed: provider.onPageNumberPressed,
                            onNextPagePressed: provider.onNextPagePressed,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

