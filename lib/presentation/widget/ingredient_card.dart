import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';

class IngredientCard extends StatelessWidget {
  final ExtendedIngredient ingredient;

  const IngredientCard({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ingredient.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: ingredient.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.grey200,
                        child: const Icon(
                          Icons.restaurant,
                          color: AppColors.grey,
                          size: 32,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.grey200,
                        child: const Icon(
                          Icons.restaurant,
                          color: AppColors.grey,
                          size: 32,
                        ),
                      ),
                    )
                  : Container(
                      color: AppColors.grey200,
                      child: const Icon(
                        Icons.restaurant,
                        color: AppColors.grey,
                        size: 32,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ingredient.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getAmountText(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _getAmountText() {
    if (ingredient.amount == null || ingredient.amount == 0) {
      return ingredient.unit;
    }

    String amount = ingredient.amount!.toString();
    if (amount.endsWith('.0')) {
      amount = amount.substring(0, amount.length - 2);
    }
    return '$amount ${ingredient.unit}';
  }
}
