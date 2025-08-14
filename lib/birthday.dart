
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/summary.dart';




class BirthdayPage extends StatefulWidget {
  const BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  final Map<String, List<bool>> _selectedImages = {
    'Theme': List.generate(5, (_) => false),
    'Cake': List.generate(5, (_) => false),
    'Music': List.generate(5, (_) => false),
    'Food': List.generate(5, (_) => false),
    'Beverage': List.generate(5, (_) => false),
    'Desert': List.generate(5, (_) => false),
  };

  final Map<String, List<int>> _itemCosts = {
    'Theme': [500, 700, 600, 800, 650],
    'Cake': [550, 600, 700, 750, 650],
    'Music': [300, 350, 400, 500, 450],
    'Food': [1000, 1200, 1500, 1100, 1300],
    'Beverage': [150, 200, 250, 180, 220],
    'Desert': [100, 120, 150, 130, 140],
  };

  int get selectedCount {
    return _selectedImages.values
        .expand((list) => list)
        .where((selected) => selected)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          'Birthday Event',
          style: GoogleFonts.quicksand(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
               child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(0),
                    ).copyWith(
                      elevation: WidgetStateProperty.all(0),
                    ),
                    onPressed: () {  },
                    child:  InkWell(
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Select Here!',
                        style: GoogleFonts.dancingScript(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  
                  ),
                  ),
            ),
            const SizedBox(height: 16),
            scrollImage(context, 'Theme'),
            const SizedBox(height: 16),
            scrollImage(context, 'Cake'),
            const SizedBox(height: 16),
            scrollImage(context, 'Music'),
            const SizedBox(height: 16),
            scrollImage(context, 'Food'),
            const SizedBox(height: 16),
            scrollImage(context, 'Beverage'),
            const SizedBox(height: 16),
            scrollImage(context, 'Desert'),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: selectedCount > 0
                    ? () => _navigateToSummaryScreen(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor:
                      selectedCount > 0 ? Colors.black : Colors.grey,
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
                          fontSize: 17,
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

  Widget scrollImage(BuildContext context, String category) {
    final names = {
      'Theme': [
        'Elegant Glow',
        'Glamorous Bash',
        'Fairytale Fantasy',
        'Superhero Party',
        'Secret Garden',
      ],
      'Cake': [
        'Peach Melba',
        'Chocolate Truffle',
        'Berry Blis',
        'Pista Magic',
        'Red Velvet',
      ],
      'Music': ['Marathi', 'Hindi', 'Punjabi', 'Gujarati', 'English'],
      'Food': [
        'Italian',
        'Maharashtrian',
        'South_Indian',
        'Punjabi',
        'Non_Veg'
      ],
      //'Activity': ['Games', 'Dance', 'Karaoke', 'Photo Booth', 'Trivia'],
      'Beverage': ['mojito', 'Juices', 'Coffee', 'Wine', 'Soda'],
      'Desert': ['Ice_Cream', 'Sweets', 'Pudding', 'Brownies', 'Donuts'],
    };

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages[category]!.length,
              itemBuilder: (context, index) {
                return _buildEventCard(
                  'assets/birthday/b1/${category.toLowerCase()}${index + 1}.png',
                  names[category]![index],
                  category,
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
      String imagePath, String title, String category, int index) {
    return GestureDetector(
      onTap: () {
        if (category == 'Theme' || category == 'Food' || category == 'Cake' ||  category == 'Music' || category == 'Beverage' || category == 'Desert') {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.black,
                child: InteractiveViewer(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          );
        }
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Checkbox(
                value: _selectedImages[category]![index],
                onChanged: (bool? newValue) {
                  setState(() {
                    _selectedImages[category]![index] = newValue!;
                  });
                },
                checkColor: Colors.white,
                activeColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSummaryScreen(BuildContext context) {
    final selectedItems = <Map<String, dynamic>>[];
    int totalBudget = 0;

    for (var category in _selectedImages.keys) {
      for (var i = 0; i < _selectedImages[category]!.length; i++) {
        if (_selectedImages[category]![i]) {
          selectedItems.add({
            'category': category,
            'name': '$category Option ${i + 1}',
            'cost': _itemCosts[category]![i],
            'imagePath': 'assets/birthday/b1/${category.toLowerCase()}${i + 1}.png',
          });
          totalBudget += _itemCosts[category]![i];
        }
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
            selectedItems: selectedItems, totalBudget: totalBudget),
      ),
    );
  }
}
