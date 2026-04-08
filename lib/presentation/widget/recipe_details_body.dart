import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/data/service/api_service.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:recipe_book_app/presentation/widget/recipe_header_section.dart';
import 'package:recipe_book_app/presentation/widget/recipe_content_section.dart';
import 'package:recipe_book_app/presentation/widget/recipe_bottom_button.dart';

class RecipeDetailsBody extends StatelessWidget {
  final Recipe recipe;
  final Future<Recipe> recipeDetailsFuture;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const RecipeDetailsBody({
    super.key,
    required this.recipe,
    required this.recipeDetailsFuture,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  static Future<Recipe> fetchRecipeDetails(int recipeId) {
    final ApiService apiService = ApiService();
    return apiService.getRecipeDetails(recipeId);
  }

  String stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe>(
      future: recipeDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.failedToLoadRecipe,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final newFuture = fetchRecipeDetails(recipe.id);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final recipeDetails = snapshot.data!;
        return Stack(
          children: [
            RecipeHeaderSection(
              recipeDetails: recipeDetails,
              isFavorite: isFavorite,
              onFavoriteToggle: onFavoriteToggle,
            ),
            RecipeContentSection(
              recipeDetails: recipeDetails,
              stripHtmlTags: stripHtmlTags,
            ),
            RecipeBottomButton(recipe: recipeDetails),
          ],
        );
      },
    );
  }
}
