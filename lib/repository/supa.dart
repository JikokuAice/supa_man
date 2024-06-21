import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/cat.dart';

class Supa {
  late final client;
  Supa() {
    client = SupabaseClient('https://lqevkoivmmqwzumdfgef.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxxZXZrb2l2bW1xd3p1bWRmZ2VmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg4NjExNDMsImV4cCI6MjAzNDQzNzE0M30.QYnGKTBuyUjFFGGcJmCH-CABN4mcKndOc2hzw12SU_M');
  }

  Future insertData({required name, required breed}) async {
    final res = await client.from('cat').insert({'name': name, 'Breed': breed});
  }

  Future fetch() async {
    final res = await client.from('cat').select('*');

    if (res.data == null) {
      print('No data found');
      return [];
    } else {
      final data = res.data as List;
      return data.map((json) => cat.fromJson(json)).toList();
    }
  }
}
