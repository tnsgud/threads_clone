class UserModel {
  bool _isDarkMode;

  UserModel({required bool isDarkMode}) : _isDarkMode = isDarkMode;

  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool isDarkMode) => _isDarkMode = isDarkMode;

  UserModel copyWith({bool? isDarkMode}) {
    return UserModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
