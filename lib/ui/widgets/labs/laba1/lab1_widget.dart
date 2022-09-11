import 'package:flutter/material.dart';
import 'package:numerical_methods/ui/Navigation/main_navigation.dart';

class Lab1Widget extends StatelessWidget {
  const Lab1Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №1',
        ),
      ),
      drawer: const _NavigationDrawer(),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            buildHeader(context),
            SizedBox(height: 10),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => const SizedBox(
        height: 100,
        width: double.infinity,
        child: ColoredBox(
          color: Colors.blueAccent,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Programming vector and matrix operations',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Product of a vector and a scalar',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => Navigator.of(context).pushNamed(mainNavigationNameRoute.lab1_1), // Replacement
            ),
            ListTile(
              title: Text(
                'Sum of two vectors',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Scalar product of vectors',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Vector module',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Matrix transpose',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Product of a matrix and a scalar',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Product of a matrix and a vector',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Sum of two matrices',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Product of two matrices',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 16),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {},
            ),
          ],
        ),
      );
}
