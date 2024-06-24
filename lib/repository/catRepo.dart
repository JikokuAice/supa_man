import 'package:hive_flutter/adapters.dart';
import 'package:supa_man/repository/local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cat.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Supa {
  final _client = Supabase.instance.client;

  Future insertData({required name, required breed, required image}) async {
    await _client
        .from('CAT')
        .insert({'name': name, 'breed': breed, 'image': image});
  }

  fetch() async {
    final res = await _client.from('CAT').select('*');
    final data = res as List;
    return data.map((json) => cat.fromJson(json)).toList();
  }

  Future delete({required list}) async {
    await _client.from('CAT').delete().inFilter('name', [list.name]);
  }

  Future update(String filter, String name, String breed) async {
    if (breed.isEmpty) {
      await _client.from("CAT").update({'name': name}).eq('name', filter);
    } else if (name.isEmpty) {
      await _client.from("CAT").update({'breed': breed}).eq('breed', filter);
    } else {
      await _client
          .from("CAT")
          .update({'name': name, 'breed': breed}).eq('name', filter);
    }
  }

  get supabase => _client;
}
