import 'package:ESGVida/view/Chat/screen.dart';
import 'package:ESGVida/view/Home/screen.dart';
import 'package:ESGVida/view/Profile/screen.dart';
import 'package:ESGVida/view/Market/screen.dart';
import 'package:ESGVida/view/Share/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ESGVida/pkg/language.dart';

class DashBordScreen extends StatefulWidget {
  int? selectedIndex;

  DashBordScreen({super.key, this.selectedIndex});

  @override
  State<DashBordScreen> createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> {
  int _selectedIndex = -0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> navigationItemList = [
    const HomeScreen(),
    const ChatScreen(),
    const ShareAndPostScreen(),
    const ShoppingScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.selectedIndex != null) {
      setState(() {
        _selectedIndex = widget.selectedIndex ?? 0;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationItemList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: true,
        backgroundColor: const Color(0xFFB592F9),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Home.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              icon: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Home.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              activeIcon: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chat,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Chat.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              icon: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chat,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Chat.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              activeIcon: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Share.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              icon: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Share.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              activeIcon: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.storefront,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Market.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              icon: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.storefront,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.Market.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              activeIcon: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.ME.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              icon: SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.black,
                    ),
                    Text(
                      LanguageGlobalVar.ME.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              label: '',
              backgroundColor: Colors.white),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
