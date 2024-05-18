import 'package:blm_registration/investment.dart';
import 'package:blm_registration/renewal_recipt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'membership_form.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFFF54B435),
      body: Column(
        children: <Widget>[

          Center(
            child: Padding(
              padding:  EdgeInsets.only(top: 200),
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Investment()));  },
                    child: cardWidget(
                        context,
                        'assets/kengenlogo.jpeg',
                        'Investment Contribution Form',
                        'ID: 123456789',
                        'Auto Pay on 24th May 18',
                        '\$1240.00',
                        'Due in 3 days',
                        Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Renewal()));
                    },
                    child: cardWidget(
                        context,
                        'assets/totallogo.jpg',
                        'Renewal Receipt Details',
                        'ID: 123456789',
                        'Enable Auto Pay',
                        '\$1490.00',
                        'Due in 2 days',
                        Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                  ),
                  TextButton(
                    onPressed: () {  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Membership())); },
                    child: cardWidget(
                        context,
                        'assets/airtellogo.png',
                        'Membership Application',
                        'ID: 123456789',
                        'Enable Auto Pay',
                        '\$1000.00',
                        'Due in 2 days',
                        Colors.grey),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget cardWidget(BuildContext context, String image, String title,
      String subtitle, String desc, String amount, String days, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width - 30.0,
      height: 130.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: Colors.white,
      ),
      child: Center(
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ),


        ),
      ),
    );
  }
}

class OrangeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2 + 85.0, size.height);

    var firstControlPoint = Offset(size.width / 2 + 140.0, size.height - 105.0);
    var firstEndPoint = Offset(size.width - 1.0, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BlackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2 - 30.0, size.height);

    var firstControlPoint =
    Offset(size.width / 2 + 175.0, size.height / 2 - 30.0);
    var firstEndPoint = Offset(size.width / 2, 0.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width / 2 + 75.0, size.height / 2 - 30.0);

    path.lineTo(size.width / 2, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}