import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cat.dart';

class Supa {
  final _supbaseClient = Supabase.instance.client;

  Future insertData({required name, required breed}) async {
    final res =
        await _supbaseClient.from('cat').insert({'name': name, 'Breed': breed});
  }

  // Future fetch() async {
  //   final res = await client.from('cat').select('*');

  //   if (res.data == null) {
  //     print('No data found');
  //     return [];
  //   } else {
  //     final data = res.data as List;
  //     return data.map((json) => cat.fromJson(json)).toList();
  //   }
  // }

  fetch() async {
    final res = await _supbaseClient.from('cat').select('*');
    final data = res as List;
    return data.map((json) => cat.fromJson(json)).toList();
  }
}
