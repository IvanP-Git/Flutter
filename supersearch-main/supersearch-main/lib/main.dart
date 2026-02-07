import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hkmljjxwrntdeknshumu.supabase.co',
    anonKey: 'sb_publishable_6e3DiMxNleAqfZRycdmv2g__9CeFJN2',
  );
  runApp(App());
}