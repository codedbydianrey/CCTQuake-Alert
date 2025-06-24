import 'package:flutter/material.dart';

class EvacuationMap extends StatefulWidget {
  const EvacuationMap({super.key});

  @override
  _EvacuationMapState createState() => _EvacuationMapState();
}

class _EvacuationMapState extends State<EvacuationMap> {

  String currentFloor = 'images/1st_floor.jpg'; 

  // Function to change the floor map
  void changeFloor(String floorImage) {
    setState(() {
      currentFloor = floorImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white, width: 2.0), 
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      backgroundColor:
          const Color.fromARGB(255, 216, 167, 75), 
      title: Text(
        'Evacuation Map',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenWidth * 0.08, 
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 255, 255, 255),
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: const Color.fromARGB(255, 0, 0, 0),
              offset: Offset(2, 0),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center, 
          children: [
            InteractiveViewer(
              boundaryMargin: EdgeInsets.all(1.0),
              minScale: 0.5,
              maxScale: 4.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 217, 187, 79)
                                .withOpacity(0.5),
                            spreadRadius: 6,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0),
                        child: Image.asset(
                          'images/City College of Tagaytay.gif',
                          width: screenWidth,
                          fit: BoxFit.contain, 
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.085, 
                    left: screenWidth * 0.032, 
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 238, 238, 238),
                                    width: 2.0),
                              ),
                              insetPadding: EdgeInsets.symmetric(
                                  horizontal: 9.0, vertical: 10.0),
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    width: screenWidth * 0.95,
                                    height: screenHeight * 0.80,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 216, 167,
                                          75), 
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'CCT Evacuation Map',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: screenWidth *
                                                0.08, 
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            shadows: [
                                              Shadow(
                                                blurRadius: 7.0,
                                                color: const Color.fromARGB(
                                                    255, 14, 12, 12),
                                                offset: Offset(1, 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    3), 
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                4.0), 
                                            child: Image.asset(
                                              'images/Legend.jpg',
                                              width: screenWidth * 0.9,
                                              height: screenWidth * 0.25,
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Expanded(
                                          child: InteractiveViewer(
                                            boundaryMargin: EdgeInsets.all(1.0),
                                            minScale: 0.5,
                                            maxScale: 4.0,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Center(
                                                  child: Image.asset(
                                                    currentFloor,
                                                    width:
                                                        screenWidth, 
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_left,
                                                size: screenWidth *
                                                    0.07, 
                                                color: const Color.fromARGB(
                                                    255, 249, 249, 249),
                                              ),
                                              onPressed: () {
                                                if (currentFloor ==
                                                    'images/2nd_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/1st_floor.jpg';
                                                  });
                                                } else if (currentFloor ==
                                                    'images/3rd_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/2nd_floor.jpg';
                                                  });
                                                } else if (currentFloor ==
                                                    'images/4th_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/3rd_floor.jpg';
                                                  });
                                                } else if (currentFloor ==
                                                    'images/5th_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/4th_floor.jpg';
                                                  });
                                                }
                                              },
                                            ),
                                            Text(
                                              currentFloor ==
                                                      'images/1st_floor.jpg'
                                                  ? '1st floor'
                                                  : currentFloor ==
                                                          'images/2nd_floor.jpg'
                                                      ? '2nd floor'
                                                      : currentFloor ==
                                                              'images/3rd_floor.jpg'
                                                          ? '3rd floor'
                                                          : currentFloor ==
                                                                  'images/4th_floor.jpg'
                                                              ? '4th floor'
                                                              : '5th floor',
                                              style: TextStyle(
                                                fontSize: screenWidth *
                                                    0.045, 
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_right,
                                                size: screenWidth *
                                                    0.07, 
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              onPressed: () {
                                                if (currentFloor ==
                                                    'images/1st_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/2nd_floor.jpg';
                                                  });
                                                } else if (currentFloor ==
                                                    'images/2nd_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/3rd_floor.jpg';
                                                  });
                                                } else if (currentFloor ==
                                                    'images/3rd_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/4th_floor.jpg';
                                                  });
                                                } else if (currentFloor ==
                                                    'images/4th_floor.jpg') {
                                                  setState(() {
                                                    currentFloor =
                                                        'images/5th_floor.jpg';
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: Size(0, 0),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_ios,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  size: screenWidth *
                                                      0.05, 
                                                ),
                                                SizedBox(width: 3),
                                                Text(
                                                  'Back',
                                                  style: TextStyle(
                                                    fontSize: screenWidth *
                                                        0.035,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment
                            .center, 
                        child: Image.asset(
                          'images/YouAreHere.png',
                          width:
                              screenWidth * 0.1, 
                          height:
                              screenHeight * 0.1, 
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(height: 4),
        Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), 
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(5.0), 
              child: Image.asset(
                'images/Legend.jpg',
                width: screenWidth * 0.9,
                height: screenWidth * 0.25,
                fit: BoxFit.cover, 
              ),
            ),
          ),
        ),
        Center(
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: screenWidth * 0.040,
                  color: const Color.fromARGB(255, 250, 250, 250),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
