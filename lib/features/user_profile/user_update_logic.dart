import 'package:flutter_application_1/features/user_profile/user_model.dart';

class UserUpdateHelper {
  static UserModel? getUpdatedUser({
    required UserModel currentUser,
    required String newName,
    required String newEmail,
    required String newPassword,
    required String newCountry,
    String? newImagePath,
  }) {
    final bool hasChanged =
        newName != currentUser.name ||
        newEmail != currentUser.email ||
        (newPassword.isNotEmpty && newPassword != currentUser.password) ||
        newCountry != currentUser.country ||
        newImagePath != currentUser.imagePath;

    if (!hasChanged) return null;
    return currentUser.copyWith(
      name: newName != currentUser.name ? newName : null,
      email: newEmail != currentUser.email ? newEmail : null,
      password: (newPassword.isNotEmpty && newPassword != currentUser.password)
          ? newPassword
          : null,
      country: newCountry != currentUser.country ? newCountry : null,
      imagePath: newImagePath != currentUser.imagePath ? newImagePath : null,
    );
  }
}
