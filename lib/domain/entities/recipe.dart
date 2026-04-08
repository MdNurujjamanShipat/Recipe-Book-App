class Recipe {
  final int id;
  final String title;
  final String image;
  final String? summary;
  final String? instructions;
  final int? readyInMinutes;
  final int? servings;
  final double? healthScore;
  final double? spoonacularScore;
  final List<ExtendedIngredient>? extendedIngredients;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    this.summary,
    this.instructions,
    this.readyInMinutes,
    this.servings,
    this.healthScore,
    this.spoonacularScore,
    this.extendedIngredients,
  });
}

class ExtendedIngredient {
  final int id;
  final String name;
  final String original;
  final double? amount;
  final String unit;
  final String? image;
  final String? consistency;
  final String? aisle;

  ExtendedIngredient({
    required this.id,
    required this.name,
    required this.original,
    this.amount,
    required this.unit,
    this.image,
    this.consistency,
    this.aisle,
  });

  String get imageUrl {
    if (image == null || image!.isEmpty) return '';
    return 'https://img.spoonacular.com/ingredients_100x100/$image';
  }
}
