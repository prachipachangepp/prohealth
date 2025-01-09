// TODO Implement this library.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';

import '../../../../data/api_data/establishment_data/user/user_modal.dart';
import '../../../widgets/error_popups/delete_success_popup.dart';

///See all screen provider class
// class SeeAllProvider with ChangeNotifier {
//   final StreamController<List<UserModal>>  _companyUsersList = StreamController<List<UserModal>>();
//
//   Stream<List<UserModal>> get userStream =>  _companyUsersList.stream;
//
//   bool _isLoading = false;
//   final StreamController<List<UserModal>> _companyUsersStreamController = StreamController<List<UserModal>>.broadcast();
//
//   bool get isLoading => _isLoading;
//   Stream<List<UserModal>> get companyUsersListStream => _companyUsersStreamController.stream;
//   // Add getUser method here
//   // Modify the method name to avoid conflict
//
//   Future<void> fetchUser(BuildContext context) async {
//     List<UserModal> userList = await getUser(context); // Call the original getUser function
//     _companyUsersList.add(userList); // Add the data to the stream
//   }
//
//
//   void dispose() {
//     _companyUsersList.close();
//     super.dispose();
//   }
//   List<UserModal> _allUsers = [];
//   int _currentPage = 1;
//   int _itemsPerPage = 10;
//
//   /// Fetch user data (simulate with API or local data)
//   Future<void> fetchUsers() async {
//     // Fetch data from API or local source
//     // _allUsers = fetchedData;
//     notifyListeners();
//   }
//   ///delete method
//   // Method to delete user
//
//
//
//
//   List<UserModal> get paginatedUsers {
//     int startIndex = (_currentPage - 1) * _itemsPerPage;
//     int endIndex = startIndex + _itemsPerPage;
//     return _allUsers.sublist(
//       startIndex,
//       endIndex > _allUsers.length ? _allUsers.length : endIndex,
//     );
//   }
//
//   int get totalPages => (_allUsers.length / _itemsPerPage).ceil();
//   int get currentPage => _currentPage;
//
//   void goToPage(int pageNumber) {
//     if (pageNumber >= 1 && pageNumber <= totalPages) {
//       _currentPage = pageNumber;
//       notifyListeners();
//     }
//   }
//
//   void nextPage() {
//     if (_currentPage < totalPages) {
//       _currentPage++;
//       notifyListeners();
//     }
//   }
//
//   void previousPage() {
//     if (_currentPage > 1) {
//       _currentPage--;
//       notifyListeners();
//     }
//   }
// }

///
class SeeAllProvider with ChangeNotifier {
  final StreamController<List<UserModal>> _companyUsersList = StreamController<List<UserModal>>();

  Stream<List<UserModal>> get userStream => _companyUsersList.stream;

  bool _isLoading = false;
  final StreamController<List<UserModal>> _companyUsersStreamController = StreamController<List<UserModal>>.broadcast();

  bool get isLoading => _isLoading;
  Stream<List<UserModal>> get companyUsersListStream => _companyUsersStreamController.stream;

  List<UserModal> _allUsers = [];
  int _currentPage = 1;
  int _itemsPerPage = 10;

  // Fetch user data (simulate with API or local data)
  Future<void> fetchUser(BuildContext context) async {
    try {

      List<UserModal> fetchedUsers = await getUser(context);
      _allUsers = fetchedUsers;
      _companyUsersList.add(_allUsers);
      notifyListeners();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  /// Method to update the user in the list
  void updateUserInList(UserModal updatedUser) {
    int index = _allUsers.indexWhere((user) => user.userId == updatedUser.userId);
    if (index != -1) {
      _allUsers[index] = updatedUser; /// Update the user in the list
      _companyUsersList.add(_allUsers); /// Update the stream with the new list
      notifyListeners(); /// Notify listeners to update the UI
    }
  }

  /// Paginated list of users
  List<UserModal> get paginatedUsers {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    return _allUsers.sublist(
      startIndex,
      endIndex > _allUsers.length ? _allUsers.length : endIndex,
    );
  }

  int get totalPages => (_allUsers.length / _itemsPerPage).ceil();
  int get currentPage => _currentPage;

  void goToPage(int pageNumber) {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      _currentPage = pageNumber;
      notifyListeners();
    }
  }

  void nextPage() {
    if (_currentPage < totalPages) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      notifyListeners();
    }
  }

  void dispose() {
    _companyUsersList.close();
    _companyUsersStreamController.close();
    super.dispose();
  }
}

