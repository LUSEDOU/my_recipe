import 'package:recipes_repository/recipes_repository.dart';

final mock = Mocks();


class Mocks {
  static const recipe = MockRecipe();
  static const list = MockRecipeList();

  static final recipeFull =  recipe.mockRecipe;
  static final recipeNoUser = recipe.copyWith(user: User.empty).mockRecipe;
  static final recipeNoCuisine = recipe.copyWith(cuisine: '').mockRecipe;
  static final recipeNoCuisineNoUser = recipe.copyWith(
    user: User.empty, 
    cuisine: '',
  ).mockRecipe;
  static final recipeNoCategory = recipe.copyWith(category: '').mockRecipe;
  static final recipeNoCategoryNoUser = recipe.copyWith(
    category: '',
    user: User.empty,
  ).mockRecipe;
  static final recipeNoSubCategory 
      = recipe.copyWith(subCategory: '').mockRecipe;
  static final recipeNoSubCategoryNoUser = recipe.copyWith(
    subCategory: '',
    user: User.empty,
  ).mockRecipe;
  static final recipeNoSubNoCategory = recipe.copyWith(
    subCategory: '',
    category: '',
  ).mockRecipe;
  static final recipeNoSubNoCategoryNoUser = recipe.copyWith(
    subCategory: '',
    category: '',
    user: User.empty,
  ).mockRecipe;
  static final recipeNoSubNoCategoryNoCuisine = recipe.copyWith(
    subCategory: '',
    category: '',
    cuisine: '',
  ).mockRecipe;
  static final recipeIncomplete = recipe.copyWith(
    subCategory: '',
    category: '',
    cuisine: '',
    user: User.empty,
  ).mockRecipe;

  static final listFull4 = list.create(
      type2: recipe.copyWith(cuisine: ''),
      type3: recipe.copyWith(
        subCategory: '',
        category: '',
        cuisine: '',
        user: User.empty,
      ),
      type4: recipe.copyWith(
        user: User.empty,
      ),
  );
} 


class MockRecipe {
  const MockRecipe({
    this.id = 89987, 
    this.title = 'Gelfite Fish 711', 
    this.image = 'https://redirect.bigoven.com/pics/rs/256/gefilte-fish.jpg', 
    this.thumbnail = 'https://redirect.bigoven.com/pics/rs/120/gefilte-fish.jpg', 
    this.web = 'https://redirect.bigoven.com/pics/rs/256/gefilte-fish.jpg',
    this.cuisine = 'American', 
    this.category = 'Main Dish', 
    this.subCategory = 'Fish and Shellfish',
    this.user,
    this.userName = 'AllRecipesRecipes', 
    this.userThumbnail = 'https://bigoven-res.cloudinary.com/image/upload/t_recipe-48,d_avatar-default.png/avatar-default.png',
  });

  final int id;
  final String title;
  final String image;
  final String thumbnail;
  final String web;
  final String cuisine;
  final String category;
  final String subCategory;
  final User? user;
  final String userName;
  final String userThumbnail;

  Recipe get mockRecipe => Recipe(
      id: id, 
      title: title, 
      image: image, 
      thumbnail: thumbnail, 
      web: web,
      cuisine: cuisine, 
      category: category, 
      subcategory: subCategory,
      user: user ?? User(
        user: userName, 
        thumbnail: userThumbnail,
      ),
    );

  MockRecipe copyWith({
    int? id,
    String? title,
    String? image,
    String? thumbnail,
    String? cuisine,
    String? category,
    String? subCategory,
    String? userName,
    String? userThumbnail,
    User? user,
  }) {
    return MockRecipe(
      id: id ?? this.id ,
      title: title ?? this.title ,
      image: image ?? this.image ,
      thumbnail: thumbnail ?? this.thumbnail ,
      cuisine: cuisine ?? this.cuisine ,
      category: category ?? this.category ,
      subCategory: subCategory ?? this.subCategory ,
      user: user ?? this.user,
      userName: userName ?? this.userName ,
      userThumbnail: userThumbnail ?? this.userThumbnail ,
    );
  }
}

class MockRecipeList {
  const MockRecipeList({
    this.recipes = const [],
  });

  final List<Recipe> recipes;

  MockRecipeList create({
    MockRecipe type1 = const MockRecipe(),
    MockRecipe type2 = const MockRecipe(),
    MockRecipe type3 = const MockRecipe(),
    MockRecipe type4 = const MockRecipe(),
    MockRecipe type5 = const MockRecipe(),
  }) {
    final list = <Recipe> [
      type1.mockRecipe,
      type2.mockRecipe,
      type3.mockRecipe,
      type4.mockRecipe,
      type5.mockRecipe,
      type1.mockRecipe,
      type2.mockRecipe,
      type3.mockRecipe,
      type4.mockRecipe,
      type5.mockRecipe,
    ];
    return MockRecipeList(recipes: list);
  }
}
