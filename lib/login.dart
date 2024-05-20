import 'package:blm_registration/home.dart';
import 'package:blm_registration/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final form_key = GlobalKey<FormState>();
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(pattern);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: form_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 375.w,
                  height: 256.h,
                  child: Image.asset(
                    'assets/1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.w, top: 48.h),
                  child: SizedBox(
                    width: 282.w,
                    child: Text(
                      'Sign in into your account',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.60.h,
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 26.w,
                    top: 4.h,
                  ),
                  child: SizedBox(
                    width: 325.w,
                    child: Text(
                      'Get access to your account',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        color: Color(0xFF79747E),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.43.h,
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 26.w,
                    top: 40.h,
                  ),
                  child: SizedBox(
                    width: 78.w,
                    height: 14,
                    child: Text(
                      'Email',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.17.h,
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 8.h, right: 20.w),
                  child: Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Container(
                      padding: EdgeInsets.only(left: 24.w),
                      width: 350.w,
                      height: 52.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !regex.hasMatch(value)) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: GoogleFonts.lato(
                                textStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                              color: Color(0xFF79747E),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.88.h,
                            ))),
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 26.w,
                    top: 16.h,
                  ),
                  child: SizedBox(
                    width: 78.w,
                    height: 14,
                    child: Text(
                      'Password',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.17.h,
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 6.h, right: 20.w),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Container(
                      padding: EdgeInsets.only(left: 24.w),
                      width: 350.w,
                      height: 52.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: TextFormField(
                        controller: password,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return 'Password should be atleast 3 character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: GoogleFonts.lato(
                                textStyle: GoogleFonts.lato(
                                    textStyle: TextStyle(
                              color: Color(0xFF79747E),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.88.h,
                            ))),
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final isValid = form_key.currentState?.validate();
                    if (isValid == true) {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (context) =>  Home1()), (
                          route) => false);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 32.h, left: 24.w, right: 24.w),
                    width: 327.w,
                    height: 48.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFF54B435),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: Text('Sign in',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.h,
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 100.w, top: 21.h, right: 111.w),
                  child: SizedBox(
                    width: 144.w,
                    child: Text('Forgot Password?',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color(0xFFFF4400),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.h,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.w, top: 45.h, right: 22.w, bottom: 91.h),
                  child: Row(
                    children: [
                      Text(
                        'Don’t have an account ?',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.25.h,
                        )),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      SizedBox(
                        width: 130.w,
                        child: GestureDetector(
                          onTap: () async{
                            // Obtain shared preferences.
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool("Token", true);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignupScreen()));
                          },
                          child: Text(
                            'Register now',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                              color: Color(0xFFFF54B435),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.h,
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.clear();
    password.clear();
    super.dispose();
  }
}
