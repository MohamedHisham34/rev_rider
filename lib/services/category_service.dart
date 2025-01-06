import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rev_rider/main.dart';

class CategoryService {
  // getCategory() function that return List of categories in { categoryID : categoryName }
  Future<Map<String, String>> getCategory() async {
    Map<String, String> categoryList = {};
    await db.collection('categories').get().then(
      (querySnapshot) {
        try {
          for (var docSnapshot in querySnapshot.docs) {
            categoryList
                .addAll({"${docSnapshot.id}": "${docSnapshot.data()['name']}"});
          }
        } catch (e) {
          print(e);
        }
      },
    );
    return categoryList;
  }
}
