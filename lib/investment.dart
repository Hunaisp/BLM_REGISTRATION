import 'package:blm_registration/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart'; // Add this for date formatting

class Investment extends StatefulWidget {
  const Investment({Key? key}) : super(key: key);

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final categoryPlanController = TextEditingController();
  final termsController = TextEditingController();
  final contributionAmountController = TextEditingController();
  final dateController = TextEditingController();
  final expectedValueController = TextEditingController();
  final modeOfPaymentController = TextEditingController();
  final installmentsController = TextEditingController();
  final admissionFeeController = TextEditingController();
  final totalController = TextEditingController();
  final dobController = TextEditingController();
  final soDoWoController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();
  final mobileController = TextEditingController();
  final adharNumberController = TextEditingController();
  final panNumberController = TextEditingController();

  final nomineeNameController = TextEditingController();
  final nomineeRelationController = TextEditingController();
  final nomineeDobController = TextEditingController();
  final nomineePanController = TextEditingController();

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
          'Investment Form',
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
                buildTextFormField(label: "Name of Applicant", controller: nameController),
                buildTextFormField(label: "Category Plan Name", controller: categoryPlanController),
                buildTextFormField(label: "Terms of Plan", controller: termsController),
                buildTextFormField(label: "Contribution Amount", controller: contributionAmountController, keyboardType: TextInputType.number),
                buildDateField(label: "Date of Commencement", controller: dateController),
                buildTextFormField(label: "Expected Value", controller: expectedValueController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Mode of Payment", controller: modeOfPaymentController),
                buildTextFormField(label: "Installments", controller: installmentsController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Admission Fee", controller: admissionFeeController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Total", controller: totalController, keyboardType: TextInputType.number),
                buildTextFormField(label: "DOB", controller: dobController),
                buildTextFormField(label: "SO/DO/WO", controller: soDoWoController),
                buildTextFormField(label: "District", controller: districtController),
                buildTextFormField(label: "State", controller: stateController),
                buildTextFormField(label: "Pin", controller: pinController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Mobile", controller: mobileController, keyboardType: TextInputType.phone),
                buildTextFormField(label: "Adhar Number", controller: adharNumberController),
                buildTextFormField(label: "Pan Number", controller: panNumberController),
                buildTextFormField(label: "Nominee's Name", controller: nomineeNameController),
                buildTextFormField(label: "Relation with Nominee", controller: nomineeRelationController),
                buildDateField(label: "Nominee's DOB", controller: nomineeDobController),
                buildTextFormField(label: "Nominee's Pan Number", controller: nomineePanController),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: ()async {
                    if (formKey.currentState!.validate()) {
                      // Handle form submission
                      // (save data, navigate, etc.)
                      _handleFormSubmission();
                      Razorpay razorpay = Razorpay();
                      var options = {
                        'key': 'rzp_test_1DP5mmOlF5G5ag',
                        'amount': double.parse(totalController.text)*100,
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
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF54B435)), // Change background color
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Change text color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 80), // Adjust padding
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust border radius
                        // You can also customize other properties like border color, border width, etc.
                      ),
                    ),
                  ),
                  child: Text(
                    'PAY AMOUNT',
                    style: TextStyle(fontSize: 16), // Adjust text size
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleFormSubmission() {
    // Retrieve data from the form fields
    String name = nameController.text;
    String categoryPlan = categoryPlanController.text;
    String terms = termsController.text;
    String contributionAmount = contributionAmountController.text;
    String date = dateController.text;
    String expectedValue = expectedValueController.text;
    String modeOfPayment = modeOfPaymentController.text;
    String installments = installmentsController.text;
    String admissionFee = admissionFeeController.text;
    String total = totalController.text;
    String dob = dobController.text;
    String soDoWo = soDoWoController.text;
    String district = districtController.text;
    String state = stateController.text;
    String pin = pinController.text;
    String mobile = mobileController.text;
    String adharNumber = adharNumberController.text;
    String panNumber = panNumberController.text;

    String nomineeName = nomineeNameController.text;
    String nomineeRelation = nomineeRelationController.text;
    String nomineeDob = nomineeDobController.text;
    String nomineePan = nomineePanController.text;

    // Do something with the form data, like saving to database or sending to server
    // For now, let's print the data
    print('Name of Applicant: $name');
    print('Category Plan Name: $categoryPlan');
    print('Terms of Plan: $terms');
    print('Contribution Amount: $contributionAmount');
    print('Date of Commencement: $date');
    print('Expected Value: $expectedValue');
    print('Mode of Payment: $modeOfPayment');
    print('Installments: $installments');
    print('Admission Fee: $admissionFee');
    print('Total: $total');
    print('DOB: $dob');
    print('SO/DO/WO: $soDoWo');
    print('District: $district');
    print('State: $state');
    print('Pin: $pin');
    print('Mobile: $mobile');
    print('Adhar Number: $adharNumber');
    print('Pan Number: $panNumber');

    print('Nominee\'s Name: $nomineeName');
    print('Relation with Nominee: $nomineeRelation');
    print('Nominee\'s DOB: $nomineeDob');
    print('Nominee\'s Pan Number: $nomineePan');

    // Optionally, you can also save the form data using shared preferences
    // Example:
    // saveFormData(name, categoryPlan, terms, contributionAmount, date, expectedValue, modeOfPayment, installments, admissionFee, total, dob, soDoWo, district, state, pin, mobile, adharNumber, panNumber, nomineeName, nomineeRelation, nomineeDob, nomineePan);
  }

  Widget buildTextFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(textInputAction: TextInputAction.next,
        controller: controller,
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

          // Add other validators as needed

          return null;
        },
      ),
    );
  }

  Widget buildDateField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(
        controller: controller,textInputAction: TextInputAction.next,
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
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PaymentSuccessPage(Amount: totalController.text, name: nameController.text,)));
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



}
