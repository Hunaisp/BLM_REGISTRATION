import 'package:blm_registration/login.dart';
import 'package:blm_registration/profile.dart';
import 'package:blm_registration/renewal_recipt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'investment.dart';
import 'membership_form.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF54B435),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProfileEightPage()));
          }, icon:   Icon(
            Icons.account_circle,
            color: Colors.white,
          ),),

          SizedBox(
            width: 25.w,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Abhishek Mishra",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abhishekm977@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Account Management '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              title: const Text('Investment Form'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Investment()));
              },
            ), ListTile(
              leading: const Icon(Icons.card_membership),
              title: const Text('Membership Form'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Membership()));
              },
            ), ListTile(
              leading: const Icon(Icons.autorenew),
              title: const Text('Renewal Details '),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Renewal()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.notification_add_outlined),
              title: const Text(' Notification '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Branch '),
              onTap: () {
                Navigator.pop(context);
              },
            ),  ListTile(
              leading: const Icon(Icons.feed_outlined),
              title: const Text('Feedback '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) =>  LoginScreen()), (
                    route) => false);
              },
            ),
          ],
        ),
      ), //Drawer
    );
  }
}
