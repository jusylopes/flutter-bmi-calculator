import 'package:bmi_calculator/view/favorite_screen.dart';
import 'package:bmi_calculator/view/select_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const SelectCharacterScreen(),
    const FavoriteScreen(),
    const FavoriteScreen(),
  ];

  final List<String> _titleAppBar = const [
    'Selecione um personagem',
    'Resultados salvos',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            _titleAppBar[_selectedIndex],
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.archive_1),
            label: 'Resultados',
          )
        ],
      ),
    );
  }
}
