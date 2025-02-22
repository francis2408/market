import 'package:flutter/material.dart';

import 'core/app/app.dart';
import 'core/network/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClient.initialize();
  runApp(const App());
}
