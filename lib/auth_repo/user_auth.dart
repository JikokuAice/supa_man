import 'package:supa_man/model/user_model/Users.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuth {
  final client2 = Supabase.instance.client;

  Future<void> Register(Users user) async {
    print(user.toJson());
    final res =
        await client2.auth.signUp(email: user.email, password: user.Password);

    final userToInsert = Users(
        id: int.parse(res.user!.id),
        name: user.name,
        email: user.email,
        Password: user.Password,
        confirm: user.confirm,
        desc: "dsdsd",
        image: "sdsdsd"
        // Include other necessary fields from your Users model
        );
    final insert = await client2
        .from("USER")
        .upsert(userToInsert.toJson())
        .catchError((e) => print(e));
    print(insert);
  }
}
