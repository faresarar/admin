import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'firebase_cloud_messaging.dart';
import 'firebase_messaging_navigate.dart';
import 'get_all_notification.dart';
import 'providers/notification_provider.dart';
import 'providers/product_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/admin_message_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/edit_upload_product_form.dart';
import 'screens/inner_screens/orders/orders_screen.dart';
import 'screens/search_screen.dart';
import 'dart:io';
import 'package:flutter/services.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await EnvVariable.instance.init(envType: EnvTypeEnum.dev);
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBxU7D-agwmxkAip_cJsnI0xls6TQbQOVM',
            appId: '1:577423224501:android:8d4cd48f1d4560850558fc',
            messagingSenderId: '577423224501',
            projectId: 'twins-shop',
            storageBucket: "twins-shop.appspot.com",
          ),
        )
      : await Firebase.initializeApp().whenComplete(() {});
  await FirebaseCloudMessaging().init() ;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Future<void> initFirebaseMessaging() async {
    await FirebaseMessagingNavigate.init(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFirebaseMessaging();
  }
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: SelectableText(
                    "An error has been occurred ${snapshot.error}"),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ThemeProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ProductProvider(),
              ),
              ChangeNotifierProvider(create: (_)=> NotificationProvider())
            ],
            child: Consumer<ThemeProvider>(builder: (
              context,
              themeProvider,
              child,
            ) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Shop Smart ADMIN AR',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const DashboardScreen(),
                routes: {
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                 EditOrUploadProductScreen.routeName: (context) => const EditOrUploadProductScreen(),
                  AdminMessageScreen.routeName: (context) =>
                      const AdminMessageScreen(),
                  GetAllNotification.routeName : (context)=> const GetAllNotification()
                },
              );
            }),
          );
        });
  }
}
