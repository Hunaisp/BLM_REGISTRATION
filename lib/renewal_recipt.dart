import 'package:blm_registration/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Renewal extends StatefulWidget {
  const Renewal({super.key});

  @override
  State<Renewal> createState() => _RenewalState();
}
final formKey = GlobalKey<FormState>();
class _RenewalState extends State<Renewal> {
  final shopNameController = TextEditingController();
  final agentNameController = TextEditingController();
  final codeNoController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController(); // New controller for date
  final serialNoController = TextEditingController();
  final customerNameController = TextEditingController();
  final rdNumberNewController = TextEditingController();
  final membershipAmountController = TextEditingController();
  final instalmentController = TextEditingController();
  final cashController = TextEditingController();
  final agencyCodeController = TextEditingController();
  final receiptNumberController = TextEditingController();

  String selectedDate = "";

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
        backgroundColor:Color(0xFFFF54B435),
        elevation: 1,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 22.sp,
            )),
        title: Text(
          'Renewal Details ',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                height: 1.h,
              )),
        ),
      ),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                buildTextFormField(label: "Branch Name", controller: shopNameController),
                buildTextFormField(label: "Agent Name", controller: agentNameController),
                buildTextFormField(label: "Code No", controller: codeNoController),
                buildTextFormField(label: "Phone Number", controller: phoneController, keyboardType: TextInputType.phone),
                buildDateField(),
                buildTextFormField(label: "Serial No", controller: serialNoController),
                buildTextFormField(label: "Customer Name", controller: customerNameController),
                buildTextFormField(label: "RD Number New", controller: rdNumberNewController),
                buildTextFormField(label: "Membership Amount", controller: membershipAmountController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Instalment", controller: instalmentController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Cash", controller: cashController, keyboardType: TextInputType.number),
                buildTextFormField(label: "Agency Code", controller: agencyCodeController),
                buildTextFormField(label: "Receipt Number", controller: receiptNumberController),
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
                        'amount': double.parse(cashController.text)*100,
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
    String shopName = shopNameController.text;
    String agentName = agentNameController.text;
    String codeNo = codeNoController.text;
    String phone = phoneController.text;
    String date = dateController.text;
    String serialNo = serialNoController.text;
    String customerName = customerNameController.text;
    String rdNumberNew = rdNumberNewController.text;
    String membershipAmount = membershipAmountController.text;
    String instalment = instalmentController.text;
    String cash = cashController.text;
    String agencyCode = agencyCodeController.text;
    String receiptNumber = receiptNumberController.text;

    // Do something with the form data, like saving to database or sending to server
    // For now, let's print the data
    print('Shop Name: $shopName');
    print('Agent Name: $agentName');
    print('Code No: $codeNo');
    print('Phone: $phone');
    print('Date: $date');
    print('Serial No: $serialNo');
    print('Customer Name: $customerName');
    print('RD Number New: $rdNumberNew');
    print('Membership Amount: $membershipAmount');
    print('Instalment: $instalment');
    print('Cash: $cash');
    print('Agency Code: $agencyCode');
    print('Receipt Number: $receiptNumber');

    // Optionally, you can also save the form data using shared preferences
    // Example:
    // saveFormData(shopName, agentName, codeNo, phone, date, serialNo, customerName, rdNumberNew, membershipAmount, instalment, cash, agencyCode, receiptNumber);
  }

  Widget buildTextFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(
        controller: controller,textInputAction:label == 'Receipt Number' ?TextInputAction.done: TextInputAction.next,
        maxLength: label == 'Phone Number' ? 10 : null, // Limit to 10 characters for phone number field
        decoration: InputDecoration(
          labelText: label,
          prefix: label == 'Phone Number' ? Text('+91 ') : (label == 'Cash' || label == 'Membership Amount' ? Text('₹ ') : null), // Add +91 prefix for phone number field and ₹ prefix for Cash and Membership Amount fields
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

          // Custom validators for Cash and Membership Amount
          if (label == 'Cash' || label == 'Membership Amount') {
            // Assuming these fields should accept numeric values only
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'Please enter a valid amount';
            }
          }

          // Add other validators as needed

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
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PaymentSuccessPage(Amount: cashController.text, name: customerNameController.text,)));
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




  Widget buildDateField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextFormField(
        controller: dateController,
        readOnly: true,textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Date",
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
              dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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


  token() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Registered", true);
  }
}
