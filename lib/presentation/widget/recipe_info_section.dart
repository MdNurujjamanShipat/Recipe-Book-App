import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';

class RecipeInfoSection extends StatelessWidget {
  final Recipe recipeDetails;

  const RecipeInfoSection({super.key, required this.recipeDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRecipeTitle(recipeDetails.title),
        const SizedBox(height: 12),
        _buildRatingAndInfo(recipeDetails),
      ],
    );
  }

  Widget _buildRecipeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildRatingAndInfo(Recipe recipeDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.starColor, size: 18),
              const SizedBox(width: 4),
              Text(
                recipeDetails.spoonacularScore != null
                    ? (recipeDetails.spoonacularScore! / 20).toStringAsFixed(1)
                    : AppStrings.defaultRating,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          if (recipeDetails.readyInMinutes != null)
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${recipeDetails.readyInMinutes}${AppStrings.mins}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          const SizedBox(width: 16),
          if (recipeDetails.servings != null)
            Row(
              children: [
                const Icon(
                  Icons.people,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${recipeDetails.servings}${AppStrings.servings}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
