import 'package:flutter/material.dart';
import 'package:nike_shop/screen/authentication/auth.dart';
import 'package:nike_shop/screen/home/home.dart';
import 'package:nike_shop/screen/root.dart';
import 'package:nike_shop/screen/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    const defaultTextStyle = TextStyle( fontFamily: 'IranSansFa', color: LightThemeColors.primaryTextColor,fontSize: 18);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            bodyMedium: defaultTextStyle,
            bodySmall: defaultTextStyle.apply(  color: LightThemeColors.secondaryTextColor,fontSizeFactor: 0.8),
            displaySmall:
                defaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          //چیزی که روی Secondary قرار میگیره رنگش ....
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: Directionality(textDirection: TextDirection.rtl, child: AuthScreen()),
    );
  }
}
