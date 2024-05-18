import 'dart:io';

import 'package:blm_registration/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Membership extends StatefulWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  State<Membership> createState() => _MembershipState();
}

final formKey = GlobalKey<FormState>();

class _MembershipState extends State<Membership> {
  final fullNameController = TextEditingController();
  final fatherHusbandNameController = TextEditingController();
  final ageController = TextEditingController();
  final occupationController = TextEditingController();
  final annualIncomeController = TextEditingController();
  final residenceAddressController = TextEditingController();
  final aadharNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final membershipNumberController = TextEditingController();
  final shareTakenController = TextEditingController();
  final discontinuanceReasonController = TextEditingController();

  String? selectedGender;
  final dateController = TextEditingController();
  final dateAdmissionController = TextEditingController();
  final discontinuanceDateController = TextEditingController();
  File? _image;
  bool isExMember = false;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: mheight * 0.085,
        titleSpacing: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFF54B435),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Membership Form ',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 1.h,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                _buildPhotoUploadSection(),
                buildTextFormField(label: "Full Name", controller: fullNameController),
                buildTextFormField(label: "Father's/Husband's Name", controller: fatherHusbandNameController),
                buildGenderDropDown(),
                buildTextFormField(label: "Age", controller: ageController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Occupation", controller: occupationController),
                buildTextFormField(label: "Annual Income", controller: annualIncomeController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Residence Address", controller: residenceAddressController),
                buildTextFormField(label: "Aadhar Number", controller: aadharNumberController, keyboardType: TextInputType.number),
                buildTextFormField(label: "PAN Number", controller: panNumberController),
                buildDateField(label: "Date of Membership", controller: dateController),
                SizedBox(height: 20.h),
                CheckboxListTile(
                  title: Text('Ex-Member of the Society?'),
                  value: isExMember,
                  onChanged: (value) {
                    setState(() {
                      isExMember = value!;
                    });
                  },
                ),
                Visibility(
                  visible: isExMember,
                  child: Column(
                    children: [
                      buildDateField(label: "Date of Admission", controller: dateAdmissionController),
                      buildTextFormField(label: "Membership Number", controller: membershipNumberController),
                      buildTextFormField(label: "Share Taken", controller: shareTakenController, keyboardType: TextInputType.number),
                      buildDateField(label: "Date of Discontinuance from Membership", controller: discontinuanceDateController),
                      buildTextFormField(label: "Reasons for Discontinuance from Membership", controller: discontinuanceReasonController),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Handle form submission
                      // (save data, navigate, etc.)
                      _handleFormSubmission();
                      Razorpay razorpay = Razorpay();
                      var options = {
                        'key': 'rzp_test_1DP5mmOlF5G5ag',
                        'amount': double.parse("1000")*100,
                        'name': 'BLM',
                        'description': 'Fine T-Shirt',
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com'
                        },
                        'external': {
                          'wallets': ['paytm']
                        }
                      };
                      razorpay.on(
                          Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          handlePaymentSuccessResponse);
                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          handleExternalWalletSelected);
                      razorpay.open(options);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF54B435)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text(
                    'PAY AMOUNT',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.data.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PaymentSuccessPage(Amount: '1000', name: fullNameController.text,)));
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void _handleFormSubmission() {
    String fullName = fullNameController.text;
    String fatherHusbandName = fatherHusbandNameController.text;
    String age = ageController.text;
    String occupation = occupationController.text;
    String annualIncome = annualIncomeController.text;
    String residenceAddress = residenceAddressController.text;
    String aadharNumber = aadharNumberController.text;
    String panNumber = panNumberController.text;
    String date = dateController.text;

    print('Full Name: $fullName');
    print('Father\'s/Husband\'s Name: $fatherHusbandName');
    print('Gender: $selectedGender');
    print('Age: $age');
    print('Occupation: $occupation');
    print('Annual Income: $annualIncome');
    print('Residence Address: $residenceAddress');
    print('Aadhar Number: $aadharNumber');
    print('PAN Number: $panNumber');
    print('Date: $date');

    if (isExMember) {
      String dateAdmission = dateAdmissionController.text;
      String membershipNumber = membershipNumberController.text;
      String shareTaken = shareTakenController.text;
      String discontinuanceDate = discontinuanceDateController.text;
      String discontinuanceReason = discontinuanceReasonController.text;

      print('Date of Admission: $dateAdmission');
      print('Membership Number: $membershipNumber');
      print('Share Taken: $shareTaken');
      print('Date of Discontinuance from Membership: $discontinuanceDate');
      print('Reasons for Discontinuance from Membership: $discontinuanceReason');
    }
    // You can also handle the photo here if needed.
  }

  Widget buildTextFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }

  Widget buildGenderDropDown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        decoration: InputDecoration(
          labelText: 'Gender',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        items: <String>['Male', 'Female', 'Other'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedGender = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select gender';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDateField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            setState(() {
              controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select a date";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhotoUploadSection() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () {
            getImage();
          },
          child: _image != null
              ? Container(
            width: 120,
            height: 120, // Set the height to maintain a square shape
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2), // Add a border around the image
            ),
            child: ClipRect(
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
            ),
          )
              : Container(
            width: 120,
            height: 120, // Set the height to maintain a square shape
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2), // Add a border around the placeholder
              color: Colors.grey[200], // Placeholder color
            ),
            child: Icon(
              Icons.camera_alt,
              size: 40,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Upload Photo',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
