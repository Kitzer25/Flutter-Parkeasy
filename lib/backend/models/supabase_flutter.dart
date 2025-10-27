import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: 'https://oujyaboxrhskskibotqt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91anlhYm94cmhza3NraWJvdHF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE0MzAyNzksImV4cCI6MjA3NzAwNjI3OX0.b6p5Ac1LqymS4Zf6H7ile7jhAlbKMMGet-2TzrsseOY',
  );
}