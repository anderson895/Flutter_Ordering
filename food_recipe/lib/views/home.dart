import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe.api.dart';
import 'package:food_recipe/models/recipe.dart';
import 'package:food_recipe/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fastfood),
              SizedBox(width: 10),
              Text('Padillas FoodHub')
            ],
          ),



              actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: RecipeSearch(_recipes));
          },
        ),
      ],


        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images);
                },
              ));
  }

  
}

class RecipeSearch extends SearchDelegate<Recipe> {
  final List<Recipe> recipes;

  RecipeSearch(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Recipe> results = query.isEmpty
        ? []
        : recipes.where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return RecipeCard(
            title: results[index].name,
            cookTime: results[index].totalTime,
            rating: results[index].rating.toString(),
            thumbnailUrl: results[index].images);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Recipe> suggestionList = query.isEmpty
        ? []
        : recipes.where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
