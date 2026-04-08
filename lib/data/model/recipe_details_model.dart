import 'package:recipe_book_app/domain/entities/recipe.dart';

class RecipeDetailsModel extends Recipe {
  RecipeDetailsModel({
    required super.id,
    required super.title,
    required super.image,
    super.summary,
    super.instructions,
    super.readyInMinutes,
    super.servings,
    super.healthScore,
    super.spoonacularScore,
    super.extendedIngredients,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    List<ExtendedIngredient>? ingredients;
    if (json['extendedIngredients'] != null) {
      ingredients = (json['extendedIngredients'] as List)
          .map(
            (e) => ExtendedIngredient(
              id: e['id'] ?? 0,
              name: e['name'] ?? '',
              original: e['original'] ?? '',
              amount: e['amount']?.toDouble() ?? 0.0,
              unit: e['unit'] ?? '',
              image: e['image'],
              consistency: e['consistency'],
              aisle: e['aisle'],
            ),
          )
          .toList();
    }

    return RecipeDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      summary: json['summary'],
      instructions: json['instructions'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      healthScore: json['healthScore']?.toDouble(),
      spoonacularScore: json['spoonacularScore']?.toDouble(),
      extendedIngredients: ingredients,
    );
  }
}
