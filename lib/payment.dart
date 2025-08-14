import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/homescreen.dart';

class PaymentScreen extends StatelessWidget {
  final int totalAmount;

  const PaymentScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          'Payment Options',
          style: GoogleFonts.quicksand(
            fontSize: 24,
            color: Colors.white,
          ),
          // style: TextStyle(
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Amount: ₹$totalAmount',
              style: GoogleFonts.quicksand(
                // fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Payment Method:',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/gpay.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'UPI - GooglePay',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/phonepay.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'UPI - PhonePay',
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/paytm.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'UPI - Paytm',
                  style: GoogleFonts.quicksand(
                    // fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  // )
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.purple),
                title: Text(
                  ' Credit Card',
                  style: GoogleFonts.quicksand(
                    // fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  // )
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading:
                    const Icon(Icons.account_balance, color: Colors.purple),
                title: Text(
                  ' Net Banking',
                  style: GoogleFonts.quicksand(
                    // fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
                onTap: () {},
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => _showPaymentSuccessDialog(context),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: InkWell(
                    child: Container(
                      width: 200,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Place Order',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showPaymentSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color.fromARGB(255, 213, 151, 224),
      title: Text(
        'Payment Successful',
        style: GoogleFonts.quicksand(
           fontSize: 15,
           fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Text(
        'You have successfully completed your payment.',
        style: GoogleFonts.quicksand(
           fontSize: 15,
           fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EventScreen()));
      
          },
          child: Text(
            'Done',
            style: GoogleFonts.quicksand(
              fontSize: 17,
               fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
