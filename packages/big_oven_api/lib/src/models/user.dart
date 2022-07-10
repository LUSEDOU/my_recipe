import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(copyWith: false)
/// {@template user}
/// Recipe's "owner" returned by the BigOven API
/// Each [User] contains a [user] itself as well as a [thumbnail]
/// {@endtemplate}
class User with _$User {
  /// {@macro user}
  const factory User({
    /// The username of a recipe's owner
    @JsonKey(name: 'UserName')
    required String user,

    /// The profile image's url of a recipe's owner
    @JsonKey(name: 'ImageURL48')
    required String thumbnail,
  }) = _User;

  /// Converts a [Map<String, dynamic>] into a [User] instance.
  factory User.fromJson(Map<String, dynamic> json) 
      => _$UserFromJson(json);
}
