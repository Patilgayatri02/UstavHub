import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  class EventAnalyticsScreen extends StatefulWidget {
  const EventAnalyticsScreen({super.key});

  @override
  _EventAnalyticsScreenState createState() => _EventAnalyticsScreenState();
}

class _EventAnalyticsScreenState extends State<EventAnalyticsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title:Text("Event Analytics",
        style: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 223, 173, 232))
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
    
          
              _buildAnalyticsCard(
                "Total Events",
                _getTotalEvents().toString(),
                Icons.event,
              ),
          
              _buildAnalyticsCard(
                "Upcoming Events",
                _getUpcomingEvents().toString(),
                Icons.event_available,
              ),
          
             
              _buildAnalyticsCard(
                "Past Events",
                _getPastEvents().toString(),
                Icons.event_busy,
              ),
          
             
              _buildAnalyticsCard(
                "Event Categories",
                _getEventCategories(),
                Icons.category,
              ),
          
             
              _buildAnalyticsCard(
                "Average Event Duration",
                _getAverageEventDuration(),
                Icons.access_time,
              ),
          
            
              _buildAnalyticsCard(
                "Most Popular Event",
                _getMostPopularEvent(),
                Icons.star,
              ),
          
             
              _buildAnalyticsCard(
                "Events per Month",
                _getEventsPerMonth(),
                Icons.calendar_today,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 223, 173, 232), size: 30),
        title: Text(
          title,
          style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
        ),
        subtitle: Text(value, style: GoogleFonts.quicksand(fontSize: 13, color: Colors.white),),
      ),
    );
  }

  int _getTotalEvents() {
    return 20;
  }

  int _getUpcomingEvents() {
    return 10; 
  }

  int _getPastEvents() {
    return 10; 
  }

  String _getEventCategories() {
    return "Music: 5, Tech: 7, Sports: 8";
  }

  String _getAverageEventDuration() {
    return "2.5 hours"; 
  }

  String _getMostPopularEvent() {
    return "Music Festival - 500 attendees"; 
  }

  String _getEventsPerMonth() {
    return "4 events per month"; 
  }
}