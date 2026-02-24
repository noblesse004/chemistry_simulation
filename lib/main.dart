import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routes.dart';
import 'providers/ai_chat_provider.dart';
import 'providers/lab_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'data/services/chemical_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await FirebaseFirestore.instance
        .collection('test_ket_noi')
        .doc('duy_id')
        .set({
          'du_an': 'Chemistry Hub - Vô Cơ Lớp 9',
          'trang_thai': 'Da ket noi thanh cong!',
          'thoi_gian': DateTime.now().toString(),
        });
    debugPrint(">>> Firebase: Da gui du lieu test thanh cong!");
  } catch (e) {
    debugPrint(">>> Firebase: Loi gui du lieu: $e");
  }
  await ChemicalService().seedDatabase();
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(const ChemistryApp());
}

class ChemistryApp extends StatelessWidget {
  const ChemistryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AIChatProvider()),
        ChangeNotifierProvider(create: (_) => LabProvider()),
      ],
      child: MaterialApp(
        title: 'Chemistry Hub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.auth,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
