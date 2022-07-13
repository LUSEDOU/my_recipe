import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
/// {@template user}
/// Recipe's "owner" returned by the BigOven API
/// Each [User] contains a [user] itself as well as a [thumbnail]
/// {@endtemplate}
class User {
  /// {@macro user}
  const User({
    required this.user,
    required this.thumbnail,
  });

  /// The username of a recipe's owner
  @JsonKey(name: 'UserName')
  final String user;

  /// The profile image's url of a recipe's owner
  @JsonKey(name: 'ImageURL48')
  final String thumbnail;

  /// Converts a [Map<String, dynamic>] into a [User] instance.
  factory User.fromJson(Map<String, dynamic> json) 
      => _$UserFromJson(json);

  /// A empty user.
  static const empty = User(user: '', thumbnail: '');

  /// Is the user empty?
  bool get isEmpty => this == User.empty;

  
  /// Is the user not empty?
  bool get isNotEmpty => this != User.empty;
}
