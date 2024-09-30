import 'package:flutter/material.dart';


void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: RecipeListPage(),
    );
  }
}

class Recipe {
  final String name;
  final List<String> ingredients;
  final String instructions;
  final String imageUrl; // Optional, can be used to show images for each recipe

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
  });
}

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> recipes = [
    Recipe(
      name: 'Chicken Curry',
      ingredients: ['Chicken', 'Onions', 'Tomatoes', 'Garlic', 'Curry Powder'],
      instructions: '1. Sauté onions and garlic.\n2. Add chicken and cook until brown.\n3. Add spices and tomatoes, then simmer.',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_Qbtb-n49WbBkWVUeN8do_iivCM75okHYEw&s',
    ),


    Recipe(
      name: 'Spaghetti Bolognese',
      ingredients: ['Spaghetti', 'Ground Beef', 'Tomato Sauce', 'Garlic'],
      instructions: '1. Cook spaghetti.\n2. Prepare sauce.\n3. Mix and serve.',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj9XSI0jUOU9bPdDa6N895defc1q1Iil14Zg&s', // Example URL
    ),
    Recipe(
      name: 'Grilled Cheese Sandwich',
      ingredients: ['Bread', 'Cheese', 'Butter'],
      instructions: '1. Butter the bread.\n2. Place cheese between bread.\n3. Grill.',
      imageUrl: 'https://cdn.loveandlemons.com/wp-content/uploads/2023/01/grilled-cheese.jpg',
    ),
    Recipe(
      name: 'Pancakes',
      ingredients: ['Flour', 'Eggs', 'Milk', 'Sugar', 'Baking Powder'],
      instructions: '1. Mix ingredients.\n2. Cook on griddle.\n3. Serve with syrup.',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9JgEkcyZDOQg6R9xpSDI0VWo2c0uWSRLgPw&s',
    ),
  ];

  TextEditingController searchController = TextEditingController();
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void _filterRecipes(String query) {
    setState(() {
      filteredRecipes = recipes.where((recipe) {
        return recipe.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.purpleAccent,
        title: Center(child: Text('Recipe List')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                labelText: 'Search recipes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    filteredRecipes[index].imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(filteredRecipes[index].name),
                  subtitle: Text('Tap to view details'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(recipe: filteredRecipes[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.purpleAccent,
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Ingredients', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            for (var ingredient in recipe.ingredients)
              Text(ingredient, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Instructions', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(recipe.instructions, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}