import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) => AdvancedDrawer(
        backdropColor: Colors.black,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        drawer: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    'Cosy Contacts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    child: ListTile(
                      title: const Text('Категории'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              title: const Text('Категории'),
              leading: Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  onPressed: _openMenu,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image.asset(
                            'assets/images/partners.png',
                          ),
                        ),
                        const Divider(),
                        const Expanded(
                          child: Text(
                            'Партнеры',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image.asset(
                            'assets/images/workers.png',
                          ),
                        ),
                        const Divider(),
                        const Expanded(
                          child: Text(
                            'Сотрудники',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _openMenu() => _advancedDrawerController.showDrawer();
}
