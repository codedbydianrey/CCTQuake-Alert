import 'package:cctquake/pdf/pdf_generator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();
  int totalEarthquakesInRange = 0;
  int totalEarthquakes = 0;
  List<Map<String, dynamic>> earthquakeRecords = [];
  Map<String, int> earthquakesByIntensity = {};
  String? _selectedIntensity;
  bool isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Color> pastelColors = [
    Color.fromARGB(255, 205, 121, 121),
    Color.fromARGB(255, 194, 133, 152),
    Color.fromARGB(255, 226, 127, 150),
    Color.fromARGB(255, 215, 187, 198),
    Color.fromARGB(255, 250, 238, 108),
    Color.fromARGB(255, 255, 186, 67),
    Color.fromARGB(255, 255, 219, 134),
    Color.fromARGB(255, 255, 242, 103),
    Color.fromARGB(255, 181, 180, 160),
    Color.fromARGB(255, 228, 187, 204),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _animationController.addListener(() {
      setState(() {});
    });

    fetchAnalytics();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchAnalytics() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('earthquake_data').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;

    int count = 0;
    int totalCount = 0;
    List<Map<String, dynamic>> tempRecords = [];
    Map<String, int> tempEarthquakesByIntensity = {};

    for (var doc in docs) {
      var data = doc.data() as Map<String, dynamic>;
      print(
          'Firestore document data: $data'); // This will show the document structure

      if (data.containsKey('timestamp')) {
        DateTime date;
        try {
          date = (data['timestamp'] as Timestamp).toDate();
        } catch (e) {
          date = DateFormat('HH:mm:ss dd/MM/yyyy').parse(data['timestamp']);
        }

        // Set time to start of day for comparison
        DateTime compareDate = DateTime(date.year, date.month, date.day);
        DateTime compareStartDate =
            DateTime(startDate.year, startDate.month, startDate.day);
        DateTime compareEndDate =
            DateTime(endDate.year, endDate.month, endDate.day);

        // Check if date falls exactly within the selected range
        if (compareDate.isAtSameMomentAs(compareStartDate) ||
            compareDate.isAtSameMomentAs(compareEndDate) ||
            (compareDate.isAfter(compareStartDate) &&
                compareDate.isBefore(compareEndDate))) {
          count++;
          String intensity = data['intensity']?.toString() ?? 'Unknown';

          // Add proper null check for PEIS value
          String peis = 'N/A';
          if (data.containsKey('peis_value') && data['peis_value'] != null) {
            peis = data['peis_value'].toString();
          }

          tempRecords.add({
            'time': DateFormat('hh:mm a dd/MM').format(date),
            'intensity': intensity,
            'peis': peis,
            'date': date,
          });

          tempEarthquakesByIntensity[intensity] =
              (tempEarthquakesByIntensity[intensity] ?? 0) + 1;
        }
        totalCount++;
      }
    }

    tempRecords.sort((a, b) {
      int intensityComparison = a['intensity'].compareTo(b['intensity']);
      return intensityComparison != 0
          ? intensityComparison
          : b['date'].compareTo(a['date']);
    });

    setState(() {
      totalEarthquakesInRange = count;
      totalEarthquakes = totalCount;
      earthquakeRecords = tempRecords;
      earthquakesByIntensity = tempEarthquakesByIntensity;
      isLoading = false;
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final ThemeData theme = Theme.of(context);

    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: const Color.fromARGB(255, 57, 6, 6),
              onPrimary: const Color.fromARGB(255, 255, 183, 0),
              onSurface: const Color.fromARGB(255, 0, 0, 0),
              secondary: Colors.amber,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 107, 90, 84),
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
        _selectedIntensity = null;
      });
      await fetchAnalytics();
    }
  }

  double calculatePieChartRadius(bool isDesktop, bool isTablet) {
    int dataPoints = earthquakesByIntensity.length;
    if (dataPoints <= 2) {
      return isDesktop
          ? 400
          : (isTablet ? 120 : 100); // Larger radius for few data points
    }
    return isDesktop ? 300 : (isTablet ? 90 : 70);
  }

  Map<DateTime, List<Map<String, dynamic>>> getDailyData() {
    Map<DateTime, List<Map<String, dynamic>>> dailyData = {};

    for (var record in earthquakeRecords) {
      DateTime date = record['date'];
      DateTime day = DateTime(date.year, date.month, date.day);

      if (dailyData.containsKey(day)) {
        dailyData[day]!.add(record);
      } else {
        dailyData[day] = [record];
      }
    }

    return dailyData;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    bool isDesktop = screenWidth > 1200;

    double pieChartHeight = isDesktop ? 300 : (isTablet ? 220 : 180);
    double pieChartRadius = calculatePieChartRadius(isDesktop, isTablet);

    List<Map<String, dynamic>> filteredRecords = _selectedIntensity == null
        ? earthquakeRecords
        : earthquakeRecords
            .where((record) => record['intensity'] == _selectedIntensity)
            .toList();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/analytics.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'images/logo.png',
                          height: screenHeight * 0.07,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/cct.png',
                            height: screenHeight * 0.05,
                          ),
                          SizedBox(width: 15.0),
                          Image.asset(
                            'images/scs.png',
                            height: screenHeight * 0.05,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: screenHeight -
                            MediaQuery.of(context).padding.top -
                            screenHeight *
                                0.1,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isTablet ? 20.0 : 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.04),
                            if (isLoading)
                              SizedBox(
                                height: pieChartHeight,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 211, 52, 97),
                                  ),
                                ),
                              )
                            else if (totalEarthquakesInRange > 0)
                              Column(
                                children: [
                                  SizedBox(height: screenHeight * 0.05),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: pieChartHeight,
                                          width: double.infinity,
                                          child: PieChart(
                                            PieChartData(
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 60,
                                              sections: earthquakesByIntensity
                                                  .entries
                                                  .map((entry) {
                                                int index =
                                                    earthquakesByIntensity.keys
                                                        .toList()
                                                        .indexOf(entry.key);
                                                bool isSelected =
                                                    _selectedIntensity ==
                                                        entry.key;
                                                double baseRadius =
                                                    pieChartRadius;
                                                double expandedRadius =
                                                    pieChartRadius * 1.1;
                                                double sectionRadius = isSelected
                                                    ? baseRadius +
                                                        (expandedRadius -
                                                                baseRadius) *
                                                            _animation.value
                                                    : baseRadius -
                                                        (isSelected
                                                            ? 0
                                                            : (_selectedIntensity !=
                                                                    null
                                                                ? 5
                                                                : 0));

                                                return PieChartSectionData(
                                                  value: entry.value.toDouble(),
                                                  title:
                                                      '${entry.value}', // Show count inside
                                                  titleStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        isTablet ? 16 : 14,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  color: pastelColors[index %
                                                      pastelColors.length],
                                                  radius: sectionRadius,
                                                  borderSide: isSelected
                                                      ? BorderSide(
                                                          color: Colors.black,
                                                          width: 2)
                                                      : BorderSide.none,
                                                  badgeWidget: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 112, 46, 46),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0)
                                                              .withOpacity(0.1),
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          offset: Offset(0, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      entry
                                                          .key, // Only show intensity outside
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 255, 255, 255),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            isTablet ? 14 : 12,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  badgePositionPercentageOffset:
                                                      1.4, // Increased distance from pie
                                                  showTitle: true,
                                                );
                                              }).toList(),
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  if (event is FlTapUpEvent &&
                                                      pieTouchResponse !=
                                                          null &&
                                                      pieTouchResponse
                                                              .touchedSection !=
                                                          null) {
                                                    final touchedSection =
                                                        pieTouchResponse
                                                            .touchedSection;
                                                    final touchedIntensity =
                                                        earthquakesByIntensity
                                                                .keys
                                                                .toList()[
                                                            touchedSection!
                                                                .touchedSectionIndex];

                                                    setState(() {
                                                      if (_selectedIntensity ==
                                                          touchedIntensity) {
                                                        _selectedIntensity =
                                                            null;
                                                        _animationController
                                                            .reset(); // Reset instead of reverse
                                                      } else {
                                                        _selectedIntensity =
                                                            touchedIntensity;
                                                        _animationController
                                                            .forward(from: 0.0);
                                                      }
                                                    });
                                                  }
                                                },
                                                enabled: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_selectedIntensity == null)
                                          Container(
                                            padding: EdgeInsets.all(27),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  231, 255, 255, 255),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0,
                                                      3), 
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "$totalEarthquakesInRange",
                                                  style: TextStyle(
                                                    fontSize:
                                                        isTablet ? 28 : 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 43, 1, 1),
                                                  ),
                                                ),
                                                Text(
                                                  "In Range",
                                                  style: TextStyle(
                                                    fontSize:
                                                        isTablet ? 14 : 11,
                                                    color: const Color.fromARGB(
                                                        255, 72, 1, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.07),
                                ],
                              )
                            else
                              SizedBox(
                                height: pieChartHeight,
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 24, 1, 1)
                                          .withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "No Earthquake Data Available",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 234, 234, 234),
                                        fontSize: isTablet ? 18 : 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: screenHeight * 0.02),

                            SizedBox(height: screenHeight * 0.02),
                            Container(
                              width: isDesktop
                                  ? screenWidth * 0.5
                                  : (isTablet
                                      ? screenWidth * 0.7
                                      : screenWidth * 0.9),
                              padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 20 : 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(160, 255, 255,
                                    255),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 31, 0, 0),
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      child: Text(
                                        isTablet
                                            ? "Selected Range: ${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}"
                                            : "Range: ${DateFormat('dd/MM/yy').format(startDate)} - ${DateFormat('dd/MM/yy').format(endDate)}",
                                        style: TextStyle(
                                          fontSize: isTablet ? 16 : 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _selectDateRange(context),
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors
                                          .black,
                                      size: isTablet ? 40 : 20,
                                    ),
                                    tooltip: 'Select Date Range',
                                  ),
                                  IconButton(
                                    onPressed: () => generatePdf(
                                        earthquakeRecords, startDate, endDate),
                                    icon: Icon(
                                      Icons.download,
                                      color: Colors.black,
                                    ),
                                    tooltip: 'Download Records',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 80, 22, 22),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              padding: EdgeInsets.all(
                                  isDesktop ? 30.0 : (isTablet ? 20.0 : 10.0)),
                              constraints: BoxConstraints(
                                minHeight: screenHeight * 0.3,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, 
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, 
                                children: [
                                  if (_selectedIntensity != null)
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 250, 235, 235),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color.fromARGB(255, 95, 0, 0),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Filtered by Intensity: $_selectedIntensity",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: isTablet ? 16 : 14,
                                              color:
                                                  Color.fromARGB(255, 40, 0, 0),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedIntensity = null;
                                                _animationController
                                                    .reset(); // Reset instead of reverse
                                              });
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: isTablet ? 20 : 18,
                                              color: Color(0xFF800000),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Center(
                                    child: filteredRecords.isEmpty
                                        ? Padding(
                                            padding: EdgeInsets.all(30.0),
                                            child: Text(
                                              "No records found for the selected criteria",
                                              style: TextStyle(
                                                fontSize: isTablet ? 16 : 14,
                                                color: Colors.grey[700],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Center(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.center,
                                                child: DataTable(
                                                  columnSpacing:
                                                      isTablet ? 25.0 : 15.0,
                                                  headingRowHeight:
                                                      isTablet ? 50.0 : 40.0,
                                                  dataRowMinHeight:
                                                      isTablet ? 48.0 : 40.0,
                                                  dataRowMaxHeight:
                                                      isTablet ? 60.0 : 48.0,
                                                  columns: [
                                                    DataColumn(
                                                      label: Center(
                                                        child: Text(
                                                          "       Time",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: isTablet
                                                                ? 16
                                                                : 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    204,
                                                                    160,
                                                                    99),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                        child: Text(
                                                          "Intensity",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: isTablet
                                                                ? 16
                                                                : 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    204,
                                                                    160,
                                                                    99),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                        child: Text(
                                                          "PHIVOLCS Earthquake \nIntensity Scale", // Changed from "PEIS"
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: isTablet
                                                                ? 16
                                                                : 11,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    204,
                                                                    160,
                                                                    99),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  rows: filteredRecords
                                                      .map((record) {
                                                    return DataRow(cells: [
                                                      DataCell(Center(
                                                        child: Text(
                                                          record['time'],
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                187, 187, 187),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: isTablet
                                                                ? 15
                                                                : 13,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      DataCell(Center(
                                                        child: Text(
                                                          record['intensity']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                232, 232, 232),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: isTablet
                                                                ? 15
                                                                : 13,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      DataCell(Center(
                                                        child: Text(
                                                          record['peis']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                232, 232, 232),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: isTablet
                                                                ? 15
                                                                : 13,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                    ]);
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
