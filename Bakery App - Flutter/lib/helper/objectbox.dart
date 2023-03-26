// import 'package:objectbox/objectbox.dart';
// import 'package:objectbox/objectbox.dart';


import 'package:path_provider/path_provider.dart';

import '../model/user.dart';
import '../objectbox.g.dart';



class ObjectBoxInstance {
  late final Store _store;

  late final Box<User> _user;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
  }
  // initialization of ObjectBox
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/user_choices',
    );
    return ObjectBoxInstance(store);
  }

  int addUser(User user) {
    return _user.put(user);
  }

  List<User> getUser() {
    return _user.getAll();
  }
  User? loginUser(String email, String password) {
    return _user
        .query(
            User_.email.equals(email) & User_.password.equals(password))
        .build()
        .findFirst();
  }
}
