import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/screen/home/home.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  void _onPopInvokedWithResult(bool didPop, dynamic result) {
    if (didPop) return;

    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // جلوگیری از خروج مستقیم
      onPopInvokedWithResult: _onPopInvokedWithResult, // استفاده از متد جدید
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _navigator(_homeKey, homeIndex, const Home()),
            _navigator(
              _cartKey,
              cartIndex,
              const Center(child: Text('Cart')),
            ),
            _navigator(
              _profileKey,
              profileIndex,
              const Center(child: Text('Profile')),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
          ],
          currentIndex: selectedScreenIndex,
          onTap: (selectedIndex) {
            setState(() {
              _history.remove(selectedScreenIndex);
              _history.add(selectedScreenIndex);
              selectedScreenIndex = selectedIndex;
            });
          },
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index, 
                child: child,
              ),
            ),
          );
  }
}
