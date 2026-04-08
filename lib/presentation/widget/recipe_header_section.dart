import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';

class RecipeHeaderSection extends StatelessWidget {
  final Recipe recipeDetails;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const RecipeHeaderSection({
    super.key,
    required this.recipeDetails,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 374,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: recipeDetails.image,
              width: double.infinity,
              height: 374,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.grey200,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.grey200,
                child: const Icon(Icons.broken_image, size: 64),
              ),
            ),
            _buildAppBarOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarOverlay(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircularButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'Recipe Details',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildCircularButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? AppColors.favorite
                      : AppColors.textPrimary,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white38,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
