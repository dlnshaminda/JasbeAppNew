import 'package:get/get.dart';
import 'package:jasbe/auth/model/user.dart';
import 'package:jasbe/main.dart';

// Reactive Style [GetxController]
class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }


  Rx<JasbeUser> currentUser = JasbeUser(
    userId: "",
    name: "Tester",
    email: "test@hotmail.com",
    phone: "+00000",
    profile: null,
  ).obs;

  

  Future<void> saveUserData(JasbeUser userData) async {
    // id
    pref.setString("userId", userData.userId);

    //  name
    pref.setString("name", userData.name);

    // email
    pref.setString("email", userData.email);

    // phone
    pref.setString("phone", userData.phone);

    // profile
    if (userData.profile != null) {
      pref.setString("profile", userData.profile!);
    } else {
      pref.remove("profile");
    }
  }

  JasbeUser? loadUserData() {
    final userId = pref.getString("userId");
    final name = pref.getString("name");
    final email = pref.getString("email");
    final phone = pref.getString("phone");
    final profile = pref.getString("profile");

    if (userId != null && name != null && email != null && phone != null) {
      return JasbeUser(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        profile: profile,
      );
    }

    return null;
  }

  Future<void> clearUserData() async {
    await pref.clear();
  }

  Future<void> setUserData(JasbeUser user) async {
    currentUser(user);
    await saveUserData(user);
    
  }

  Future<void> updateUserData(JasbeUser user) async {
  
    // server update 
  }

  Future<void> getUserData(int userId) async {
    // server update 
  }

  Future<Map<String, dynamic>?> logIn(String phone, String password, String messageToken) async {
    // final response = await QuackStore.instance.logIn(phone: phone, password: password, messageToken: messageToken);
    // if (response != null && response.data is Map) {
    //   return response.data;
    // }
    return null;
  }

  Future<void> logOut() async {
    await clearUserData();
  }
}
