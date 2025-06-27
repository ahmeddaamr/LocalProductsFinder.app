class UserModel {
  final String name;
  final String email;
  final String password;
  final String country;
  final String? imagePath;

  UserModel({ 
    required this.name,
    required this.email,
    required this.password, 
    required this.country,
    this.imagePath,
  });




  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     name: json['name'] ?? '',
  //     email: json['email'] ?? '',
  //     imagePath: json['imagePath'],
  //   );
  // }






///////////////////////for editing the user profile/////////////////////
  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? country,
    String? imagePath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password, 
      country: country ?? this.country,
      imagePath: imagePath ?? this.imagePath, 
    );
  }
}
UserModel? currentUser;
