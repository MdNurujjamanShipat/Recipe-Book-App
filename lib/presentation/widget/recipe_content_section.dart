import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/core/app_strings.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:recipe_book_app/presentation/widget/ingredient_card.dart';
import 'package:recipe_book_app/presentation/widget/recipe_info_section.dart';

class RecipeContentSection extends StatelessWidget {
  final Recipe recipeDetails;
  final String Function(String) stripHtmlTags;

  const RecipeContentSection({
    super.key,
    required this.recipeDetails,
    required this.stripHtmlTags,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 374 - 30,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(19),
            topRight: Radius.circular(19),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              RecipeInfoSection(recipeDetails: recipeDetails),
              const SizedBox(height: 24),
              if (recipeDetails.extendedIngredients != null &&
                  recipeDetails.extendedIngredients!.isNotEmpty)
                _buildIngredientsSection(recipeDetails.extendedIngredients!),
              const SizedBox(height: 24),
              if (recipeDetails.summary != null)
                _buildDescriptionSection(recipeDetails.summary!),
              const SizedBox(height: 24),
              if (recipeDetails.instructions != null &&
                  recipeDetails.instructions!.isNotEmpty)
                _buildInstructionsSection(recipeDetails.instructions!),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientsSection(List<ExtendedIngredient> ingredients) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.ingredients,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 142,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return IngredientCard(ingredient: ingredients[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String summary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stripHtmlTags(summary),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection(String instructions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.instructions,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stripHtmlTags(instructions),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
