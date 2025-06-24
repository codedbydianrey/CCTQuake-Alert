import 'package:cctquake/alertscreen/evacuation_map.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cctquake/screens/Safety/Safety.dart';
import 'package:cctquake/screens/About/DEV/About.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cctquake/alertscreen/alert_helper.dart';
import 'package:cctquake/screens/History/Analytics.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _selectedIndex = 0;
  Timer? _timer;

  // Variables to store the fetched data
  final List<Map<String, String>> _earthquakeData = [];
  bool _isAlertShowing = false; // Add this state variable

  @override
  void initState() {
    super.initState();
    listenToFirestore(); // Start Firestore real-time listener
    _resetDataAtMidnight(); // Schedule data reset at midnight
    _startTimer();
  }

  // Function to listen to Firestore changes
  void listenToFirestore() {
    FirebaseFirestore.instance
        .collection('earthquake_data')
        .orderBy('timestamp', descending: true)
        .limit(1000) // Fetch the latest 1000 documents
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data();
          String timestamp = data['timestamp'];

          DateTime parsedTimestamp;
          try {
            parsedTimestamp =
                DateFormat('HH:mm:ss dd/MM/yyyy').parse(timestamp);
          } catch (e) {
            print("Error parsing date: $e");
            continue;
          }

          // Convert to required format
          String formattedDate =
              DateFormat("MMMM d, yyyy").format(parsedTimestamp);
          String formattedTime =
              DateFormat("h:mm a").format(parsedTimestamp); // 12-hour format

          DateTime now = DateTime.now();
          if (parsedTimestamp.year == now.year &&
              parsedTimestamp.month == now.month &&
              parsedTimestamp.day == now.day) {
            // Display earthquake alert BEFORE setting state
            showEarthquakeAlert(
                context,
                data['intensity'],
                "$formattedTime - $formattedDate",
                _isAlertShowing, (bool value) {
              setState(() {
                _isAlertShowing = value;
              });
            });

            setState(() {
              _earthquakeData.add({
                'intensity': data['intensity'].toString(),
                // Safe handling of 'peis_value'. If it's missing, use 'N/A'
                'peis_value': data['peis_value']?.toString() ??
                    'N/A', // Safely handle missing peis_value
                'date': formattedDate,
                'time': formattedTime,
              });
            });
          }
        }
      }
    });
  }

  // Function to reset data at midnight
  void _resetDataAtMidnight() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    Duration timeUntilMidnight = nextMidnight.difference(now);

    Timer(timeUntilMidnight, () {
      setState(() {
        _earthquakeData.clear();
      });
      _resetDataAtMidnight(); // Schedule the next reset
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(days: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final List<Widget> _screens = [
    Center(),
    AnalyticsScreen(),
    Safety(),
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset('images/home_bckg.jpg'),
              ),
            ),
            Positioned(
              top: mediaQuery.size.height * 0.06,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left logo
                    SizedBox(
                      height: mediaQuery.size.height * 0.07,
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: mediaQuery.size.height * 0.05,
                          child: Image.asset(
                            'images/cct.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: mediaQuery.size.width * 0.03),
                        SizedBox(
                          height: mediaQuery.size.height * 0.05,
                          child: Image.asset(
                            'images/scs.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return IndexedStack(
                  index: _selectedIndex,
                  children: [
                    _buildHomeContent(context, constraints, mediaQuery),
                    _screens[1],
                    _screens[2],
                    _screens[3],
                  ],
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _selectedIndex,
          onTap: _onItemTapped,
          items: <Widget>[
            _buildTabIcon('images/home..png', 'Home', 0, mediaQuery),
            _buildTabIcon('images/Analytics.png', 'Analytics', 1, mediaQuery),
            _buildTabIcon('images/safety...png', 'Safety', 2, mediaQuery),
            _buildTabIcon(
              'images/.about.png',
              'About',
              3,
              mediaQuery,
            )
          ],
          color: Color.fromARGB(255, 68, 10, 10),
          backgroundColor: const Color.fromARGB(255, 214, 206, 206),
          buttonBackgroundColor: Color.fromARGB(255, 57, 6, 6),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 100),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, BoxConstraints constraints,
      MediaQueryData mediaQuery) {
    double padding = constraints.maxWidth * 0.04;
    double containerHeight = constraints.maxHeight * 0.17;
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.12,
          right: screenWidth * 0.05,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => EvacuationMap(),
              );
            },
            child: SizedBox(
              width: mediaQuery.size.width * 0.08,
              height: mediaQuery.size.width *
                  0.160,
              child: Image.asset(
                'images/MAP PIN.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        RefreshIndicator(
          color: const Color.fromARGB(
              255, 61, 5, 1),
          onRefresh: () async {
            List<Map<String, String>> newData = [];
            QuerySnapshot snapshot = await FirebaseFirestore.instance
                .collection('earthquake_data')
                .orderBy('timestamp', descending: true)
                .limit(1000)
                .get();

            if (snapshot.docs.isNotEmpty) {
              for (var doc in snapshot.docs) {
                final data = doc.data() as Map<String, dynamic>;
                String timestamp = data['timestamp'];

                DateTime parsedTimestamp;
                try {
                  parsedTimestamp =
                      DateFormat('HH:mm:ss dd/MM/yyyy').parse(timestamp);
                } catch (e) {
                  print("Error parsing date: $e");
                  continue;
                }

                String formattedDate =
                    DateFormat("MMMM d, yyyy").format(parsedTimestamp);
                String formattedTime =
                    DateFormat("h:mm a").format(parsedTimestamp);

                DateTime now = DateTime.now();
                if (parsedTimestamp.year == now.year &&
                    parsedTimestamp.month == now.month &&
                    parsedTimestamp.day == now.day) {
                  newData.add({
                    'intensity': data['intensity'].toString(),
                    'peis_value': data['peis_value']?.toString() ?? 'N/A',
                    'date': formattedDate,
                    'time': formattedTime,
                  });
                }
              }
              setState(() {
                _earthquakeData.clear();
                _earthquakeData.addAll(newData);
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 105.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                Container(
                  height: containerHeight,
                  width: screenWidth,
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.jm().format(DateTime.now()),
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 4, 4),
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        DateFormat.yMMMd().format(DateTime.now()),
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 4, 4),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight *
                          0.10,
                      maxHeight: screenHeight * 0.6, 
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 82, 27, 27),
                      borderRadius: BorderRadius.circular(9.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        width: 2.0,
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: _earthquakeData.length, // Display logs
                      itemBuilder: (context, index) {
                        final data = _earthquakeData[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 82, 24, 24),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: const Color.fromARGB(
                                  100, 255, 255, 255), 
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.5),
                                spreadRadius: 2, 
                                blurRadius: 5, 
                                offset:
                                    Offset(0, 3), 
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              'Date: ${data['date']}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 222, 222, 222),
                              ),
                            ),
                            subtitle: Text(
                              // Now showing 'peis_value' safely with a fallback
                              'Time: ${data['time']} \nIntensity: ${data['intensity']} \nPHIVOLCS Earthquake \nIntensity Scale: ${data['peis_value']}', // Show PEIS here
                              style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 227, 225, 225),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildTabIcon(
      String assetPath, String label, int index, MediaQueryData mediaQuery) {
    bool isSelected = _selectedIndex == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetPath,
          height: mediaQuery.size.height * 0.03,
          color: isSelected ? Colors.white : null,
        ),
        SizedBox(height: mediaQuery.size.height * 0.005),
        isSelected
            ? SizedBox.shrink()
            : Text(
                label,
                style: TextStyle(
                  fontSize: mediaQuery.size.width * 0.03,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
