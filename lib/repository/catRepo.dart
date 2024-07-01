import 'package:hive_flutter/adapters.dart';
import 'package:supa_man/repository/local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cat.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Supa {
  final _client = Supabase.instance.client;

  Future insertData(Cat cat) async {
    await _client.from('CAT').insert(cat.toJson());
  }

  fetch({int page = 1, int screen = 10}) async {
    final res = await _client
        .from('CAT')
        .select('*')
        .range((page - 1) * screen, screen * page - 1);
    final data = res as List;
    print(data);
    return data.map((json) => Cat.fromJson(json)).toList();
  }

  Future delete(Cat cat) async {
    await _client.from('CAT').delete().inFilter('name', [cat.name]);
  }

  Future update(
    Cat cat,
  ) async {
    await _client
        .from("CAT")
        .update({'name': cat.name, 'breed': cat.breed}).eq('id', cat.id);
  }

  get supabase => _client;
}
