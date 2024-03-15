import 'dart:async';
import 'package:final_exam/module/viwes/splash_screen/model/fetchdata_model.dart';
import 'package:get/get.dart';

import '../../../helper/database_helper.dart';

class SplashScreenController extends GetxController {
  List<FetchDataModel> fetchStudentData = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    await DataBaseHelper.databaseHelper.initDB();
    List data = await DataBaseHelper.databaseHelper.fetchAllData();
    fetchStudentData = data.map((e) {
      return FetchDataModel(RecipeName: e['recipename'], Recipe: e['recipe']);
    }).toList();
    update();
    print(fetchStudentData.map((e) => e.RecipeName).toList());
    super.onInit();
    Timer(Duration(seconds: 3), () => Get.offAllNamed('/'));
    update();
  }
}
