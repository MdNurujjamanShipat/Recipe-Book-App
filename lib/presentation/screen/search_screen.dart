import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_app/core/app_colors.dart';
import 'package:recipe_book_app/presentation/provider/recipe_provider.dart';
import 'package:recipe_book_app/presentation/widget/search_recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textPrimary,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
        title: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search recipes...',
              hintStyle: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.7),
                fontSize: 15,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
                size: 20,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        context.read<RecipeProvider>().clearSearchResults();
                        setState(() {});
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: (value) {
              setState(() {});
              if (value.isEmpty) {
                context.read<RecipeProvider>().clearSearchResults();
              }
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<RecipeProvider>().searchRecipes(value);
              }
            },
          ),
        ),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.searchResults.isEmpty) {
            return const Center(child: Text('No results found'));
          }
          return ListView.builder(
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              return SearchRecipeCard(recipe: provider.searchResults[index]);
            },
          );
        },
      ),
    );
  }
}
