import 'package:blm_registration/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
                    'assets/splash_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.w, top: 48.h),
                  child: SizedBox(
                    width: 282.w,
                    child: Text(
                      'Register your account',
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
                        fontFamily: 'Lato',
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
                      'User Name',
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
                        controller: userName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Should Not Be Empty';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "User Name",
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 26.w,
                    top: 16.h,
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
                      'Phone',
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
                        controller: phone,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return 'Invalid Phone Number';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
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
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password Should Be At least 6 character';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
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
                    height: 14,
                    child: Text(
                      'Confirm Password',
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
                        obscureText: true,
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Should Not Be Empty';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
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
                GestureDetector(
                  onTap: () {
                    final isValid = form_key.currentState?.validate();
                    if (isValid == true) {
                      if (password.text == confirmPassword.text) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen()));
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 32.h, left: 24.w, right: 24.w),
                    width: 327.w,
                    height: 48.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFF54B435),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: Text('Sign up',
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
                  padding: EdgeInsets.only(
                      left: 40.w, top: 40.h, right: 40.w, bottom: 55.h),
                  child: Row(
                    children: [
                      Text(
                        'Already have an account ?',
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
                        width: 50.w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            'Sign in',
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
    userName.clear();
    email.clear();
    phone.clear();
    password.clear();
    confirmPassword.clear();
    super.dispose();
  }
}
