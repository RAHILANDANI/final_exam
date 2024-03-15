import 'package:final_exam/module/helper/database_helper.dart';
import 'package:final_exam/module/helper/firestore_helper.dart';
import 'package:final_exam/module/viwes/home_screen/homepage_controller/homepage_controller.dart';
import 'package:final_exam/module/viwes/splash_screen/splash_screen_controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String RecipeName = "";
    String Recipe = "";
    HomePageController homePageController = HomePageController();
    SplashScreenController splashScreenController = Get.find<SplashScreenController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Recipes"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Enter your Reciepe Name : "),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      RecipeName = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Enter your Reciepe : "),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      Recipe = value;
                    },
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Date - ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}     Time - ${DateTime.now().hour} - ${DateTime.now().minute}"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          DataBaseHelper.databaseHelper
                              .insertData(RecipeName, Recipe)
                              .then((value) => Get.back());
                        },
                        child: Text("Save"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel")),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.red.shade200,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Recipe App"),
        backgroundColor: Colors.red.shade200,
      ),
      body: Column(
        children: splashScreenController.fetchStudentData.map((e) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.red.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("${e.RecipeName}"),
                  SizedBox(height: 10,),
                  Text("${e.Recipe}"),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        FireStoreHelper.fireStoreHelper.FavouriteRecipe(e.RecipeName!, e.Recipe!);
                      }, icon: Icon(Icons.favorite))
                    ],
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
