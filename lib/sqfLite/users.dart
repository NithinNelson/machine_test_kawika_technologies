final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id,
    userName,
    userImage,
    noOfRepos,
    location,
    blog,
    followers,
    following,
  ];

  static final String id = '_id';
  static final String userName = 'userName';
  static final String userImage = 'userImage';
  static final String noOfRepos = 'noOfRepos';
  static final String location = 'location';
  static final String blog = 'blog';
  static final String followers = 'followers';
  static final String following = 'following';
}
// rege

class Users {
  final int? id;
  final String userName;
  final String userImage;
  final int noOfRepos;
  final String location;
  final String blog;
  final int followers;
  final int following;

  const Users({
    this.id,
    required this.userName,
    required this.userImage,
    required this.noOfRepos,
    required this.location,
    required this.blog,
    required this.followers,
    required this.following,
  });

  Users copy({
    int? id,
    String? userName,
    String? userImage,
    int? noOfRepos,
    String? location,
    String? blog,
    int? followers,
    int? following,
  }) =>
      Users(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        userImage: userImage ?? this.userImage,
        noOfRepos: noOfRepos ?? this.noOfRepos,
        location: location ?? this.location,
        blog: blog ?? this.blog,
        followers: followers ?? this.followers,
        following: following ?? this.following,
      );

  static Users fromJson(Map<String, Object?> json) => Users(
        id: json[UserFields.id] as int?,
        userName: json[UserFields.userName] as String,
        userImage: json[UserFields.userImage] as String,
        noOfRepos: json[UserFields.noOfRepos] as int,
        location: json[UserFields.location] as String,
        blog: json[UserFields.blog] as String,
        followers: json[UserFields.followers] as int,
        following: json[UserFields.following] as int,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.userName: userName,
        UserFields.userImage: userImage,
        UserFields.noOfRepos: noOfRepos,
        UserFields.location: location,
        UserFields.blog: blog,
        UserFields.followers: followers,
        UserFields.following: following,
      };
}
