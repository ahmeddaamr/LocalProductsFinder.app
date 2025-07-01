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
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // If the map is wrapped in a 'user' key, extract it
    final userJson = json.containsKey('user') ? json['user'] : json;
    return UserModel(
      name: userJson['username'] ?? '',
      password: userJson['password_hashed'] ?? '',
      email: userJson['email'],
      country: userJson['country'] ?? '',
      imagePath: userJson['imagePath']?? '',
    );
  }

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
