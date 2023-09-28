import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:threads_clone/models/user_model.dart';

class UserViewModel extends StateNotifier<UserModel> {
  UserViewModel(super.state);

  set changeThemeMode(bool isDarkMode) => state.isDarkMode = isDarkMode;
}
