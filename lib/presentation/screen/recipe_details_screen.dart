import 'package:flutter/material.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:recipe_book_app/presentation/widget/recipe_details_body.dart';

import '../../core/app_colors.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  late Future<Recipe> _recipeDetailsFuture;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _recipeDetailsFuture = RecipeDetailsBody.fetchRecipeDetails(
      widget.recipe.id,
    );
  }

  void toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: RecipeDetailsBody(
        recipe: widget.recipe,
        recipeDetailsFuture: _recipeDetailsFuture,
        isFavorite: _isFavorite,
        onFavoriteToggle: toggleFavorite,
      ),
    );
  }
}
