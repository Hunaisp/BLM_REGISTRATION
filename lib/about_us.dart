import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54B435),
        centerTitle: true,
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(),
              SizedBox(height: 16),
              _buildHeader(),
              SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey),
              SizedBox(height: 16),
              _buildAboutText(),
              SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey),
              SizedBox(height: 16),
              _buildWebsiteLink(context),
              SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey),
              SizedBox(height: 16),
              // Add more sections with divider lines here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        width: 200.w,
        height: 170.h,
        child: Image.asset('assets/splash_logo.png'),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bharath Lajhna Multi State Housing Co-operative Society Limited',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Financial Services\nChennai, Tamilnadu',
          style: TextStyle(fontSize: 18.sp),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Us',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Bharath Lajhna Multi State Housing Co-operative Society Limited is one of the leading housing co-operative society in South India. Approved by Government Of India MSCS/CR/235/2006, MSCS Act 2002. BLMSHCS is functional across Tamil Nadu, Kerala, Pondicherry and Andhra Pradesh.',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildWebsiteLink(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchWebsite(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Website',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'http://www.bharathlajhna.com/',
            style: TextStyle(fontSize: 16.sp, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Future<void> _launchWebsite() async {
    const url = 'http://www.bharathlajhna.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
