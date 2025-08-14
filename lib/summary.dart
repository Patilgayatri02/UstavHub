
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/payment.dart';

class SummaryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  final int totalBudget;

  const SummaryScreen(
      {super.key, required this.selectedItems, required this.totalBudget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          'Order Summary',
          style: GoogleFonts.quicksand(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Items',
              style: GoogleFonts.quicksand(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final item = selectedItems[index];
                  return ListTile(
                    leading: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        item['imagePath'],
                        fit: BoxFit.cover,
                      ),
                    
                    ),
                    title: Text(item['name'],
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: Colors.white
                    ) ,
                    ),
                    subtitle: Text('Cost: ₹${item['cost']}',
                     style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: Colors.white
                     ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Budget: ₹$totalBudget',
              style: GoogleFonts.quicksand(
                 fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PaymentScreen(totalAmount: totalBudget),
                    ),
                  );
                },
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
                      width: 300,
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
                        'Proceed to Payment',
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
