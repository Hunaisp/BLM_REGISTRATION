import 'package:blm_registration/gallery.dart';
import 'package:blm_registration/login.dart';
import 'package:blm_registration/profile.dart';
import 'package:blm_registration/quick_pay.dart';
import 'package:blm_registration/renewal_recipt.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'about_us.dart';
import 'chairman message.dart';
import 'investment.dart';
import 'membership_form.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final _controller = CarouselController();
  List<String> img = [
    'assets/a1.jpg',
    'assets/a2.jpg',
    'assets/a4.jpg',
    'assets/a5.jpg',
    'assets/a6.jpg',
    'assets/a7.jpg',
    'assets/a8.jpg',
  ];
  List<String> txt = [
    'LAND DEVELOPMENT',
    'HOUSING DEVELOPMENT',
    'CIVIL SUPPLIES',
    'BLM JEWELLERY',
    'BLM COLLEGE',
    'CEMENT FACTORY',
    'BLM PLANTS',
  ];
  List<String> img1 = [
    'assets/b1.jpg',
    'assets/b2.jpeg',
    'assets/b3.jpeg',
    'assets/b4.jpeg',
    'assets/b5.jpeg',
    'assets/b6.jpg',
    'assets/b7.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF54B435),centerTitle: true,
        title: Text('BLM'),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProfileEightPage()));
            },
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Investment()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_membership),
              title: const Text('Membership Form'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Membership()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.message_outlined),
              title: const Text('Chairman Message'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ChatScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.autorenew),
              title: const Text('Renewal Details '),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Renewal()));
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
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => GalleryPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.feed_outlined),
              title: const Text('Feedback '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline), // Change the icon to an appropriate one
              title: const Text('About Us'), // Update the title text
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AboutUs())); // Navigate to the AboutUs page
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment_outlined), // Use the outlined icon for Quick Pay
              title: const Text('Quick Pay'), // Update the title text
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => QuickPay())); // Navigate to the QuickPay page
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 25.h,
          ),
          CarouselSlider.builder(
            itemCount: img1.length,
            itemBuilder: (context, index, realindex) {
              var height = 170.h;
              var width = MediaQuery.of(context).size.width;
              return Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9.r),
                  child: Image.asset(
                    img1[index].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            carouselController: _controller,
            options: CarouselOptions(
              height: 170.h,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.95,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 20.h),
            child: Text(
              'Services',
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 13.h,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling for the grid
            children: List.generate(
              img.length,
                  (index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('img.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 106,
                            child: Image.asset(
                              img[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: Text(
                              txt[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

  }
}
