import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetails({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(recipe.images),
            SizedBox(height: 20),
            Text("Rating: ${recipe.rating}"),
            SizedBox(height: 10),
            Text("Total Time: ${recipe.totalTime}"),
          ],
        ),
      ),
    );
  }
}
