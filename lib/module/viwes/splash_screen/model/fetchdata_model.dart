class FetchDataModel {
  String? RecipeName;
  String? Recipe;

  FetchDataModel({required this.RecipeName, required this.Recipe});

  @override
  String toString() {
    return 'RecipeName: $RecipeName, Recipe: $Recipe';
  }
}
