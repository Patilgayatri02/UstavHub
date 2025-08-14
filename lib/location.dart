import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manager.dart';

class EventManagerPage extends StatefulWidget {
  const EventManagerPage({super.key});

  @override
  _EventManagerPageState createState() => _EventManagerPageState();
}

class _EventManagerPageState extends State<EventManagerPage> {
  final List<String> cities = [
    'Mumbai',
    'Chennai',
    'Delhi',
    'Kashmir',
    'Pune',
    'Nagpur',
    'Kerala',
    'Hyderabad',
  ];

  final List<String> cityImages = [
    'assets/city/mumbai.jpg',
    'assets/city/chennai.jpg',
    'assets/city/delhi.jpg',
    'assets/city/kashmir.jpg',
    'assets/city/pune.jpg',
    'assets/city/nagpur.jpg',
    'assets/city/kerala.jpg',
    'assets/city/haidrabad.jpg',
  ];

  bool isCityListVisible = false;
  DateTime? selectedDate;

  void toggleCityList() {
    setState(() {
      isCityListVisible = !isCityListVisible;
    });
  }

  void navigateToManagerPage(String city) {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date first.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManagerPage(
          selectedCity: city,
          selectedDate: selectedDate!, 
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.purple,
            dialogBackgroundColor: Colors.purple[100],
            colorScheme: const ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Selected Date: ${pickedDate.toLocal()}".split(' ')[0]),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text('Choose Location', style: GoogleFonts.quicksand(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _pickDate,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: toggleCityList,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purpleAccent, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Select Location',
                  style: GoogleFonts.quicksand(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            if (isCityListVisible)
              Container(
                height: 150,
                margin: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cities[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        navigateToManagerPage(cities[index]);
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            Text(
              'Where you can find us!',
              style: GoogleFonts.dancingScript(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cityImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          cityImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          cities[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
