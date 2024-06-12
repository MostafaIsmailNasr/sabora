import 'package:flutter/material.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../domain/usecases/settings_use_case.dart';

class SettingsController extends BaseController  {
  SettingsController(this._settingsUseCase);

  final SettingsUseCase _settingsUseCase;

  late TabController _tabController;

  late TextEditingController phoneController;

  @override
  void onInit() async {
    super.onInit();
    phoneController = TextEditingController();
    //passController = TextEditingController();
    // _tabController= new TabController(vsync: this, length: 3);
    // _tabController.addListener(_handleTabSelection);
  }

}
