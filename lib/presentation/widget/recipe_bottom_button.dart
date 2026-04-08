import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/domain/entities/recipe.dart';
import 'package:recipe_book_app/presentation/screen/video_player_screen.dart';

class RecipeBottomButton extends StatelessWidget {
  final Recipe recipe;

  const RecipeBottomButton({super.key, required this.recipe});

  void _playVideo(BuildContext context) {
    String searchQuery = recipe.title.replaceAll(' ', '+');
    String youtubeUrl =
        "https://www.youtube.com/results?search_query=$searchQuery+recipe+tutorial";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoUrl: youtubeUrl,
          videoTitle: 'How to make ${recipe.title}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 95,
        padding: const EdgeInsets.only(
          top: 11,
          right: 24,
          bottom: 32,
          left: 24,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 24,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: 327,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () => _playVideo(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            icon: const Icon(Icons.play_circle_fill, size: 24),
            label: const Text(
              'Watch Videos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
