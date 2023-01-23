import 'package:flutter/material.dart';
import 'package:fp_app/controller/auth_controller.dart';
import '../widgets/my_profile.dart';
import '../widgets/my_drawer_header.dart';
import '../widgets/my_slots.dart';
import '../widgets/book_slots.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentPage = DrawerSections.profile;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.profile) {
      container = ProfilePage();
    } else if (currentPage == DrawerSections.bookslots) {
      container = BookingPage();
    } else if (currentPage == DrawerSections.myslots) {
      container = MySlotsPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.deepPurple,
        shadowColor: Colors.transparent,
      ),
      body: container,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "My Profile", Icons.person,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(2, "Book Slots", Icons.dns,
              currentPage == DrawerSections.bookslots ? true : false),
          menuItem(3, "My Slots", Icons.playlist_add_check,
              currentPage == DrawerSections.myslots ? true : false),
          SizedBox(
            height: 390,
          ),
          Divider(
            height: 0,
            color: Colors.deepPurple[400],
            thickness: 2,
          ),
          Material(
            color: Colors.deepPurple[400],
            child: InkWell(
              onTap: () {
                setState(() {
                  AuthController.logOut();
                });
              },
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.logout,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.deepPurple[200] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.profile;
            } else if (id == 2) {
              currentPage = DrawerSections.bookslots;
            } else if (id == 3) {
              currentPage = DrawerSections.myslots;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.deepPurple,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  profile,
  bookslots,
  myslots,
}
