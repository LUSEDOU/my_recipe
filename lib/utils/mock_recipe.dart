import 'package:big_oven_api/big_oven_api.dart';

const mock = MockRecipe();

class Mocks {
  static const recipe = MockRecipe();

  static final recipeFull =  recipe.mockRecipe;
  static final recipeNoUser = mock.copyWith(user: User.empty).mockRecipe;
  static final recipeNoCuisine = mock.copyWith(cuisine: '').mockRecipe;
  static final recipeNoCuisineNoUser = mock.copyWith(
    user: User.empty, 
    cuisine: '',
  ).mockRecipe;
  static final recipeNoCategory = mock.copyWith(category: '').mockRecipe;
  static final recipeNoCategoryNoUser = mock.copyWith(
    category: '',
    user: User.empty,
  ).mockRecipe;
  static final recipeNoSubCategory = mock.copyWith(subCategory: '').mockRecipe;
  static final recipeNoSubCategoryNoUser = mock.copyWith(
    subCategory: '',
    user: User.empty,
  ).mockRecipe;
  static final recipeNoSubNoCategory = mock.copyWith(
    subCategory: '',
    category: '',
  ).mockRecipe;
  static final recipeNoSubNoCategoryNoUser = mock.copyWith(
    subCategory: '',
    category: '',
    user: User.empty,
  ).mockRecipe;
  static final recipeNoSubNoCategoryNoCuisine = mock.copyWith(
    subCategory: '',
    category: '',
    cuisine: '',
  ).mockRecipe;
  static final recipeIncomplete = mock.copyWith(
    subCategory: '',
    category: '',
    cuisine: '',
    user: User.empty,
  ).mockRecipe;

} 

const mockUser = User(
    user: 'AllRecipesRecipes', 
    thumbnail: 'https://bigoven-res.cloudinary.com/image/upload/t_recipe-48,d_avatar-default.png/avatar-default.png',
);

class MockRecipe {
  const MockRecipe({
    this.id = 89987, 
    this.title = 'Gelfite Fish 711', 
    this.image = 'https://redirect.bigoven.com/pics/rs/256/gefilte-fish.jpg', 
    this.thumbnail = 'https://redirect.bigoven.com/pics/rs/120/gefilte-fish.jpg', 
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
