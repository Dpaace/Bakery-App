import '../data_source/local_data_source/user_data_source.dart';
import '../data_source/remote_data_sourse/userRemoteDataSourse.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUser();
  Future<int> addUser(User user);
  Future<bool> loginUser(String email, String password);
  Future<bool> loginAdmin(String email, String password);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(User user) {
    // return UserDataSource().addUser(user);
    return UserRemoteDataSourse().addUser(user);
  }

  @override
  Future<List<User>> getAllUser() {
    return UserDataSource().getAllUser();
  }

  @override
  Future<bool> loginUser(String email, String password) {
    return UserRemoteDataSourse().loginUser(email, password);
  }

  @override
  Future<bool> loginAdmin(String email, String password) {
    return UserRemoteDataSourse().loginAdmin(email, password);
  }
}
