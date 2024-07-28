import 'package:flutter/material.dart';
import 'package:naturemedix/screens/information_screen.dart';
import 'package:naturemedix/screens/notification_screen.dart';
import 'message_screen.dart';
import 'camera_screen.dart';
import 'bookmark_screen.dart';
import 'profile_screen.dart';

  class SampleMainScreen extends StatefulWidget {
    const SampleMainScreen({super.key});
    @override
    _SampleMainScreenState createState() => _SampleMainScreenState();
  }
  class _SampleMainScreenState extends State<SampleMainScreen> with SingleTickerProviderStateMixin {
   int _selectedIndex = 0;
  late TabController _tabController;
  bool _hasNotifications = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    void initState() {
      super.initState();
      _tabController = TabController(length: 6, vsync: this);
    }
    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
 
    });
  }
    void _navigateToNotifications() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ),
      );
    }
     void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
    @override
    Widget build(BuildContext context) {
      final List<Widget> _pages = [
        HomePage(tabController: _tabController),
        const MessageScreen(),
        const CameraScreen(),
        const BookmarkScreen(),
        const ProfileScreen(),
      ];
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('NatureMedix'),
          leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_rounded),
                  onPressed: _navigateToNotifications,
                ),
                if (_hasNotifications)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          bottom: _selectedIndex == 0
              ? TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Plants'),
                    Tab(text: 'Remedies'),
                    Tab(text: 'Ailments'),
                    Tab(text: 'Recommendation'),
                    Tab(text: 'New'),
                  ],
                )
              : null,
        ),
        drawer: _buildDrawer(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        );
    }
     Widget _buildDrawer() {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Colors.green.shade100, Colors.green.shade300],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            accountName: const Text(
              'User Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text(
              'user@example.com',
              style: TextStyle(fontSize: 16),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_image.png'),
            ),
            otherAccountsPictures: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  
                },
              ),
            ],
          ),
          _buildDrawerItem(
            icon: Icons.history,
            text: 'History',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.info,
            text: 'About Us',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {},
          ),
          const Divider(color: Colors.white),
          _buildDrawerItem(
            icon: Icons.exit_to_app,
            text: 'Log Out',
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

Widget _buildDrawerItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.green.shade800),
    title: Text(
      text,
      style: TextStyle(color: Colors.green.shade800, fontSize: 16),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    tileColor: Colors.white,
    onTap: onTap,
    hoverColor: Colors.green.shade50,
    focusColor: Colors.green.shade100,
    selectedTileColor: Colors.green.shade200,
    selectedColor: Colors.green.shade900,
  );
}
  }

  class HomePage extends StatelessWidget {
    final TabController tabController;
    const HomePage({required this.tabController, super.key});
    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AllTab(tabController: tabController),
                const PlantsTab(),
                const RemediesTab(),
                const AilmentsTab(),
                const Recommendation(),
                const New(),
              ],
            ),
          ),
        ],
      );
    }
  }

  class AllTab extends StatelessWidget {
    final TabController tabController;
    const AllTab({required this.tabController, super.key});
    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SectionGrid(
              title: 'Featured Remedies',
              items: List.generate(4, (index) => ItemData('Tea $index', 'Description $index', 'assets/images/BG1.png')),
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      title: item.name,
                      description: item.description,
                      imageUrl: item.image,
                    ),
                  ),
                );
              },
              tabController: tabController,
              targetTabIndex: 2,
            ),
            SectionGrid(
              title: 'Featured Plants',
              items: List.generate(4, (index) => ItemData('Plant $index', 'Description $index', 'assets/images/BG2.png')),
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      title: item.name,
                      description: item.description,
                      imageUrl: item.image,
                    ),
                  ),
                );
              },
              tabController: tabController,
              targetTabIndex: 1,
            ),
            SectionGrid(
              title: 'Ailments',
              items: List.generate(4, (index) => ItemData('Ailment $index', 'Description $index', 'assets/images/BG1.png')),
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      title: item.name,
                      description: item.description,
                      imageUrl: item.image,
                    ),
                  ),
                );
              },
              tabController: tabController,
              targetTabIndex: 3,
            ),
            SectionGrid(
              title: 'Recommendation',
              items: List.generate(4, (index) => ItemData('Recommended $index', 'Description $index', 'assets/images/BG2.png')),
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      title: item.name,
                      description: item.description,
                      imageUrl: item.image,
                    ),
                  ),
                );
              },
              tabController: tabController,
              targetTabIndex: 4,
            ),
            SectionGrid(
              title: 'New',
              items: List.generate(4, (index) => ItemData('New $index', 'Description $index', 'assets/images/BG2.png')),
              onItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      title: item.name,
                      description: item.description,
                      imageUrl: item.image,
                    ),
                  ),
                );
              },
              tabController: tabController,
              targetTabIndex: 5,
            ),
          ],
        ),
      );
    }
  }

  class SectionGrid extends StatelessWidget {
    final String title;
    final List<ItemData> items;
    final void Function(ItemData item) onItemTap;
    final TabController tabController;
    final int targetTabIndex;
    const SectionGrid({
      required this.title,
      required this.items,
      required this.onItemTap,
      required this.tabController,
      required this.targetTabIndex,
      super.key,
    });
    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    tabController.animateTo(targetTabIndex);
                  },
                  child: const Text('See all'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250.0, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () => onItemTap(item),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SizedBox(
                      width: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(item.description, style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
  //laman ng cards
  class ItemData {
    final String name;
    final String description;
    final String image;
    ItemData(this.name, this.description, this.image);
  }
  //para sa tab ng Plants
  class PlantsTab extends StatelessWidget {
    const PlantsTab({super.key});
    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                      child: Image.asset(
                        'assets/images/BG2.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Plant $index', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Description $index', style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      );
    }
  }
  //para sa tab ng Remedies
  class RemediesTab extends StatelessWidget {
    const RemediesTab({super.key});
    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                      child: Image.asset(
                        'assets/images/BG1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Remedy $index', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Description $index', style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      );
    }
  }
  //para sa tab ng Ailments
  class AilmentsTab extends StatelessWidget {
    const AilmentsTab({super.key});
    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                      child: Image.asset(
                        'assets/images/BG2.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ailment $index', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Description $index', style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      );
    }
  }
  //para sa tab ng Reccomendation
  class Recommendation extends StatelessWidget {
    const Recommendation({super.key});
    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                      child: Image.asset(
                        'assets/images/BG1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Recommended $index', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Description $index', style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      );
    }
  }
  //para sa tab ng New
  class New extends StatelessWidget {
    const New({super.key});
    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                      child: Image.asset(
                        'assets/images/BG1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('New $index', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Description $index', style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      );
    }
  }