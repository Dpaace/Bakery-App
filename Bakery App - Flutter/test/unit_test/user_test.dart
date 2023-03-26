import 'package:bakey/data_source/remote_data_sourse/userRemoteDataSourse.dart';
import 'package:bakey/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "token":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2ZkOTcwNDM5YTI1OGE3NzhlNGVlMTkiLCJlbWFpbCI6ImFkbWluMUBnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE2Nzc1NjM3MDEsImV4cCI6MTY3NzY1MDEwMX0.IyMArAVOxswXBmLnAHy1f5lNfn9h_zNwW3LJhaqcf58"
    });
  });
  WidgetsFlutterBinding.ensureInitialized();

  test('User should be able to log in', () async {
    bool expectedResult = true;
    String email = "khadka@gmail.com";
    String password = "password";
    bool actualResult = await UserRemoteDataSourse().loginUser(email, password);
    expect(actualResult, expectedResult);
  });

  test('User should be able to register', () async {
    int expectedResult = 1;
    User user = User(
      firstName: "Ishwor",
      lastName: "Khadka",
      email: "helloworld1213@gmail.com",
      password: "password",
    );
    int actualResult = await UserRemoteDataSourse().addUser(user);
    expect(actualResult, expectedResult);
  });

  test('Admin should be able to log in', () async {
    bool expectedResult = true;
    String email = "admin1@gmail.com";
    String password = "admin";
    bool actualResult =
        await UserRemoteDataSourse().loginAdmin(email, password);
    expect(actualResult, expectedResult);
  });

  test('Admin should be able to register', () async {
    int expectedResult = 1;
    User user = User(
      firstName: "admin",
      lastName: "admin",
      email: "admin1@gmail.com",
      password: "admin",
      role: "Admin",
    );
    int actualResult = await UserRemoteDataSourse().addAdmin(user);
    expect(actualResult, expectedResult);
  });
}

// flutter test --coverage ./test/unit_test/user_test.dart 
// flutter pub run test_cov_console
