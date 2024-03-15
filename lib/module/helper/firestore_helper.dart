import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper{
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;



  Future<void> FavouriteRecipe(String RecipeName, String Recipe) async {


    try {
      await firebaseFirestore
          .collection('favourite')
          .add({
        'Recipe Name': RecipeName,
        'Recipe': Recipe,
        'time': DateTime.now(),
      });
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }

}