// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jasbe/auth/presentation/screen/profile_screen.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/food/presentation/screens/landing_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:jasbe/jasbe/order/presentation/screen/cart_screen.dart';
import 'package:jasbe/jasbe/order/presentation/screen/pick_up_option.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.startPageIndex = 0, this.isDelivery = true, this.loadAppData = false}) : super(key: key);

  final int startPageIndex;
  final bool isDelivery;
  final bool loadAppData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late List<Widget> pages;

  int currentIndex = 0;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    currentIndex = widget.startPageIndex;

    pages = const [
      CoffeeLandingScreen(),
      PickUpOption(),
      CartScreen(),
      ProfileScreen(),
    ];

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.loadAppData) await getAppData();
    });
  }

  Future<void> getAppData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          elevation: 0,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            tabController.animateTo(index);
          },
          selectedItemColor: context.primary,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: context.surfaceColor,
              icon: Icon(
                IconlyLight.home,
                color: currentIndex == 0 ? context.primary : context.foregroundColor,
              ),
              label: "Coffee",
            ),
            BottomNavigationBarItem(
              backgroundColor: context.surfaceColor,
              icon: Icon(
                IconlyLight.location,
                color: currentIndex == 1 ? context.primary : context.foregroundColor,
              ),
              label: "Map",
            ),
            BottomNavigationBarItem(
              backgroundColor: context.surfaceColor,
              icon: Icon(
                IconlyLight.buy,
                color: currentIndex == 2 ? context.primary : context.foregroundColor,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              backgroundColor: context.surfaceColor,
              icon: Icon(
                IconlyLight.filter,
                color: currentIndex == 3 ? context.primary : context.foregroundColor,
              ),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
