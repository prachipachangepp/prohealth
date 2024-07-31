import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../register/register_enroll_popup.dart';

/// main screen controller
/// prachi
class ScreenSizeController extends GetxController {
  /// Flag to determine if it's a tablet screen
  RxBool isTabletScreen = false.obs;
  RxBool isMobileScreen = false.obs;
  RxBool isDesktopScreen = false.obs;

  /// Method to check and set the screen type
  void checkScreenType(double screenWidth) {
    isTabletScreen.value = screenWidth < 712 && screenWidth > 414;
    isMobileScreen.value = screenWidth <= 414;
    isDesktopScreen.value = screenWidth >= 712;
  }
}

///Login
// class LoginTabBarController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   final List<Widget> tabs;
//   final List<Widget> tabViews;
//   final double tabBarViewHeight;
//   final double tabBarViewWidth;
//
//   LoginTabBarController({
//     required this.tabs,
//     required this.tabViews,
//     this.tabBarViewHeight = 200.0, //320
//     this.tabBarViewWidth = 150.0,
//   });
//
//   @override
//   void onInit() {
//     tabController = TabController(length: tabs.length, vsync: this);
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     tabController.dispose();
//     super.onClose();
//   }
// }

///head 1st tabbar
///saloni
class MyAppTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  MyAppTabBarController(
      {required this.tabs,
      required this.tabViews,
      this.tabBarViewHeight = 600.0,
      required this.tabBarViewWidth});

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

///middle head tabbar
///saloni
class CenteredTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  CenteredTabBarController({
    required this.tabs,
    required this.tabViews,
    this.tabBarViewHeight = 425.0, //320
    this.tabBarViewWidth = 600.0,
  });
//////////////////////////////////////////////////////////////////
  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

///last child tabbar
///saloni
class CenteredTabBarChildController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  CenteredTabBarChildController({
    required this.tabs,
    required this.tabViews,
    this.tabBarViewHeight = 250.0, //250
    this.tabBarViewWidth = 620.0,
  });

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

///saloni
class RegisterController extends GetxController {
  final isDialogOpen = false.obs;

  void openDialog(BuildContext context) {
    isDialogOpen.value = true;
    RegisterEnrollAlertDialog().show(context);
  }

  void closeDialog() {
    isDialogOpen.value = false;
  }
}

///prachi
class AddEmployeeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  AddEmployeeController({
    required this.tabs,
    required this.tabViews,
    this.tabBarViewHeight = 500.0, //250
    this.tabBarViewWidth = 500.0,
  });

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

///prachi
class OnboardingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  OnboardingController({
    required this.tabs,
    required this.tabViews,
    this.tabBarViewHeight = 300.0, //250
    this.tabBarViewWidth = 500.0,
  });

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

///
class QualificationTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  QualificationTabBarController({
    required this.tabs,
    required this.tabViews,
    this.tabBarViewHeight = 400.0, //320
    this.tabBarViewWidth = 600.0,
  });

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}


///rohit
class SeeAllHrController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final double tabBarViewHeight;
  final double tabBarViewWidth;

  SeeAllHrController({
    required this.tabs,
    required this.tabViews,
    this.tabBarViewHeight = 300.0, //250
    this.tabBarViewWidth = 500.0,
  });

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}