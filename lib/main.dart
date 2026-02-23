import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicity_tpa/src/features/auth/ui/splash_screen.dart';
import 'package:medicity_tpa/src/services/payment_provider.dart';
import 'package:medicity_tpa/src/services/tpa_provider.dart';
import 'package:medicity_tpa/src/shared/router/app_router.dart';
import 'package:medicity_tpa/src/shared/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TpaProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: MaterialApp.router(
        title: 'Medicity',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}


