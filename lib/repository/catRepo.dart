import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cat.dart';

class Supa {
  final _client = Supabase.instance.client;

  Future insertData({required name, required breed, required image}) async {
    final response = await _client
        .from('CAT')
        .insert({'name': name, 'breed': breed, 'image': image});
  }

  fetch() async {
    final res = await _client.from('CAT').select('*');
    final data = res as List;
    return data.map((json) => cat.fromJson(json)).toList();
  }

  get  supabase => _client;
}
