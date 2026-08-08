import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String name;
  final String email;
  final String avatar;
  final bool isLoggedIn;
  final bool isGuest;

  const UserModel({
    required this.name,
    required this.email,
    this.avatar = '🧘',
    required this.isLoggedIn,
    required this.isGuest,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? avatar,
    bool? isLoggedIn,
    bool? isGuest,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}

class AuthNotifier extends StateNotifier<UserModel> {
  AuthNotifier()
      : super(const UserModel(
          name: 'Arjun Sharma',
          email: 'arjun@example.com',
          avatar: '🧘',
          isLoggedIn: true,
          isGuest: false,
        )) {
    _loadAuthState();
  }

  static const String _keyLoggedIn = 'find_peace_is_logged_in';
  static const String _keyName = 'find_peace_user_name';
  static const String _keyEmail = 'find_peace_user_email';
  static const String _keyAvatar = 'find_peace_user_avatar';
  static const String _keyIsGuest = 'find_peace_is_guest';

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_keyLoggedIn) ?? true;
    final name = prefs.getString(_keyName) ?? 'Arjun Sharma';
    final email = prefs.getString(_keyEmail) ?? 'arjun@example.com';
    final avatar = prefs.getString(_keyAvatar) ?? '🧘';
    final isGuest = prefs.getBool(_keyIsGuest) ?? false;

    state = UserModel(
      name: name,
      email: email,
      avatar: avatar,
      isLoggedIn: isLoggedIn,
      isGuest: isGuest,
    );
  }

  Future<void> updateProfile({String? name, String? email, String? avatar}) async {
    final newName = name ?? state.name;
    final newEmail = email ?? state.email;
    final newAvatar = avatar ?? state.avatar;

    state = state.copyWith(name: newName, email: newEmail, avatar: newAvatar);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, newName);
    await prefs.setString(_keyEmail, newEmail);
    await prefs.setString(_keyAvatar, newAvatar);
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final userName = email.contains('@') ? email.split('@')[0] : 'Peace Seeker';
    final nameFormatted = userName[0].toUpperCase() + userName.substring(1);

    state = UserModel(
      name: nameFormatted,
      email: email,
      avatar: '🧘',
      isLoggedIn: true,
      isGuest: false,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyName, nameFormatted);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyAvatar, '🧘');
    await prefs.setBool(_keyIsGuest, false);

    return true;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    state = UserModel(
      name: name.trim().isEmpty ? 'Peace Seeker' : name,
      email: email,
      avatar: '🧘',
      isLoggedIn: true,
      isGuest: false,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyName, state.name);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyAvatar, '🧘');
    await prefs.setBool(_keyIsGuest, false);

    return true;
  }

  Future<void> loginAsGuest() async {
    state = const UserModel(
      name: 'Guest Traveler',
      email: 'guest@findpeace.app',
      avatar: '🕊️',
      isLoggedIn: true,
      isGuest: true,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyName, 'Guest Traveler');
    await prefs.setString(_keyEmail, 'guest@findpeace.app');
    await prefs.setString(_keyAvatar, '🕊️');
    await prefs.setBool(_keyIsGuest, true);
  }

  Future<void> logout() async {
    state = const UserModel(
      name: '',
      email: '',
      avatar: '🧘',
      isLoggedIn: false,
      isGuest: false,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, false);
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyAvatar);
    await prefs.remove(_keyIsGuest);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, UserModel>((ref) {
  return AuthNotifier();
});
