import 'package:flutter/material.dart';
import 'ui/products/products_manager.dart';
import 'ui/products/product_detail_screen.dart';
import 'ui/products/user_products_screen.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/orders/orders_screen.dart';
import 'ui/screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'


Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
        return MaterialApp(
      title: 'My shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.deepOrange,
        ),
      ),
      home: authManager.isAuth
              ? const ProductsOverviewScreen()
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  },
                ),
      routes: {
        CartScreen.routeName: (ctx) => const CartScreen(),
        OrdersScreen.routeName: (ctx) => const OrdersScreen(),
        UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == EditProductScreen.routeName) {
          final productId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (ctx) {
              return EditProductScreen(
                productId != null
                ? ctx.read<ProductsManager>().findById(productId)
                : null,
              );
            },
          );
        }
        return null;
      },
    ),
    );
  }
}

