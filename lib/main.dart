import 'package:flutter/material.dart';
import 'package:hacktheflow/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	
	await Supabase.initialize(
		url: "https://knnndpivzxgzvtarcqfz.supabase.co",
		anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtubm5kcGl2enhnenZ0YXJjcWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg0OTM3ODcsImV4cCI6MTk5NDA2OTc4N30.l-CDukSGhpi68jIQ41UKEem753e29yOml-KATbIfaRI"
	);
  runApp(const HomePage());
}

