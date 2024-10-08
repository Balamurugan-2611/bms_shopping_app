import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bms_shopping_app/feature/cart/ui/cart_screen.dart';
import 'package:bms_shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:bms_shopping_app/feature/profile/profile_screen.dart';
import 'package:bms_shopping_app/feature/wishlist/ui/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  late DiscoverScreen _discoverScreen;
  late CartScreen _cartScreen;
  late Wishlist _wishlist;
  late ProfileScreen _profileScreen;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _discoverScreen = DiscoverScreen();
    _cartScreen = CartScreen();
    _wishlist = Wishlist();
    _profileScreen = ProfileScreen();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            _discoverScreen,
            _wishlist,
            _cartScreen,
            _profileScreen,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GNav(
            gap: 0,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.pinkAccent,
            tabs: [
              GButton(
                icon: Ionicons.ios_home,
                text: 'Home',
              ),
              GButton(
                icon: Ionicons.ios_heart,
                text: 'Favorite',
              ),
              GButton(
                icon: Ionicons.ios_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Ionicons.ios_person,
                text: 'Profile',
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
