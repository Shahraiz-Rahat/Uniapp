import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:info_mobile_application/pages/Clubs/CSSE_doc.dart';
import 'package:info_mobile_application/pages/Departments/Dep_CSSE.dart';
import 'package:info_mobile_application/pages/Departments/Dep_DS.dart';
import 'package:info_mobile_application/pages/Departments/Dep_ISS.dart';
import 'package:info_mobile_application/pages/Departments/Dep_NS.dart';
import 'package:info_mobile_application/pages/profile.dart';
import 'package:info_mobile_application/pages/time_table.dart.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase_auth_implementation/firebase_auth_services.dart';
import '../theme_provider.dart';
import 'Clubs/CSSL_doc.dart';
import 'Clubs/FOSS_doc.dart';
import 'Documentations/Ply_doc.dart';
import 'Documentations/UGC_doc.dart';
import 'Documentations/Vic_doc.dart';
import 'popup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSliderIndex = 0;
  final CarouselController _carouselController = CarouselController();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  String _selectedBatch = 'Select';
  String _selectedUniversity = 'Select';
  String _selectedDegreeProgram = 'Select';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double displayWidth = MediaQuery.of(context).size.width;

    String? userEmail = _auth.getUserEmail();

    return Scaffold(
        backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
        body: ListView(
          children: [
            // Account Button --------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 7, 57, 97),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 100,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    splashColor: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/Profile Pic.png'),
                          const SizedBox(width: 4),

                          // Title and Description
                          // Title and Description
                          Expanded(
                            child: FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userEmail != null
                                        ? 'Email: $userEmail'
                                        : 'User not signed in',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Student ID: 12345',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.more_vert_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Event Slider ----------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! > 0) {
                          // Swipe right - move to the previous slide
                          _carouselController.previousPage();
                        } else if (details.primaryVelocity! < 0) {
                          // Swipe left - move to the next slide
                          _carouselController.nextPage();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                              )
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: true,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentSliderIndex = index;
                                });
                              },
                            ),
                            items: [
                              GestureDetector(
                                onTap: () {
                                  _showImagePopup(
                                    'assets/images/TV Banner2.png',
                                    'Software Freedom Day 2023',
                                    'Software Freedom Day 2023 is a global celebration of open-source technology, featuring workshops, discussions, and a vision for a more inclusive and accessible digital future.',
                                    'Register',
                                    onButtonPressed: () async {
                                      const url =
                                          'https://www.fossnsbm.org/events/sfd-2023';
                                      // ignore: deprecated_member_use
                                      if (await canLaunch(url)) {
                                        // ignore: deprecated_member_use
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'assets/images/TV Banner2.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showImagePopup(
                                    'assets/images/USport.png',
                                    'NSBM USports 2023',
                                    'Starting this September, witness 13 thrilling sports – Athletics, Basketball, Badminton, Cricket, Chess, Football, Hockey, Netball, Rugby, Swimming, Table Tennis, Volleyball and Taekwondo – at the grand university-level competition.',
                                    'More',
                                    onButtonPressed: () {},
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'assets/images/USport.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showImagePopup(
                                    'assets/images/CN.png',
                                    'NSBM Colours 2022',
                                    'Champions crowned, dreams realized, and memories etched forever.\n\n Join us for the NSBM Colors 2022, a night of glory presented by NSBM Green University on 23rd of June 2023, at NSBM auditorium from 06:00pm onwards.\n\n Witness the crowning of our exceptional athletes as they take their well-deserved place in the memoirs of greatness. Let the celebration of victory begin!',
                                    'More',
                                    onButtonPressed: () {},
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'assets/images/CN.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) =>
                              _buildDotIndicator(index == _currentSliderIndex)),
                    ),
                  ],
                ),
              ),
            ),

            // Lecture Search --------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.blueAccent.withOpacity(.2),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Today's Lectures",
                          style: TextStyle(
                              color: themeProvider
                                  .currentTheme.textTheme.bodyText1?.color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Batch & University Dropdowns
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Batch Dropdown
                            ThemedDropdown(
                              label: 'Batch',
                              value: _selectedBatch,
                              items: [
                                'Select',
                                'SP 19',
                                'FA 19',
                                'SP 20',
                                'FA 20',
                                'SP 21',
                                'FA 21',
                                'SP 22',
                                'FA 22',
                                'SP 23',
                                'FA 23',
                                // 'C 2.1',
                                // 'C 2.2',
                                // 'C 2.3',
                                // 'C 2.4',
                                // 'C 2.5',
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedBatch = newValue ?? 'Select';
                                });
                              },
                            ),

                            const SizedBox(width: 70),

                            // University Dropdown
                            ThemedDropdown(
                              label: 'Department',
                              value: _selectedUniversity,
                              items: [
                                'Select',
                                'Computer Science & Software Engineering',
                                'Management & Business Studies',
                                'Engineering & Technology',
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedUniversity = newValue ?? 'Select';
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Degree Program Dropdown
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ThemedDropdown(
                            label: 'Degree Program',
                            value: _selectedDegreeProgram,
                            items: [
                              'Select',
                              'BSc (Honours) in Data Science',
                              'BSc (Hons) Computer Networks',
                              'BSc (Hons) Computer Security',
                              'Bachelor of Information Technology\n(Major in Cyber Security)',
                              'BSc (Hons) Computer Science',
                              'BSc (Hons) Software Engineering',
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDegreeProgram = newValue ?? 'Select';
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TableExampleScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: displayWidth * .05,
                                vertical: displayWidth * .04,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 57, 97),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Search',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // 4 Department Buttons --------------------------------------------
            Padding(
              padding: EdgeInsets.symmetric(vertical: displayWidth * .05),
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.currentTheme.backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(50, 50, 50, 50),
                      // offset: Offset(0.0, 0.0),
                      blurRadius: 5,
                      // spreadRadius: 1,
                      // inset: true,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(50, 50, 50, 50),
                      // offset: Offset(0.0, 0.0),
                      blurRadius: 5,
                      // spreadRadius: 1,
                      // inset: true,
                    ),
                  ],
                  // gradient: LinearGradient(
                  //   colors: [
                  //     const Color.fromARGB(255, 255, 255, 255),
                  //     const Color.fromARGB(255, 255, 255, 255),
                  //     const Color.fromARGB(255, 255, 255, 255),
                  //     const Color.fromARGB(255, 255, 255, 255),
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: displayWidth * .05,
                          vertical: displayWidth * .025),
                      child: Padding(
                        padding: EdgeInsets.only(top: displayWidth * .025),
                        child: Text(
                          'Departments',
                          style: TextStyle(
                            fontSize: displayWidth * .05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Computer Science & Software Engineering Button
                          DepartmentButton(
                            imageAsset: 'assets/images/cssedepartment.png',
                            title: 'Computer Science & Software Engineering',
                            description: 'Department of',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const CSSE();
                                },
                              );
                            },
                          ),

                          // Information & System Science Button
                          DepartmentButton(
                            imageAsset: 'assets/images/issdepartment.png',
                            title: 'Information & System Science',
                            description: 'Department of',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const ISS();
                                },
                              );
                            },
                          ),

                          // Data Science Button
                          DepartmentButton(
                            imageAsset: 'assets/images/dsdepartment.png',
                            title: 'Data Science\n',
                            description: 'Department of',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const DS();
                                },
                              );
                            },
                          ),

                          // Network & Security Button
                          DepartmentButton(
                            imageAsset: 'assets/images/dnsdepartment.png',
                            title: 'Network & Security\n',
                            description: 'Department of',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const NS();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: displayWidth * .025),
                  ],
                ),
              ),
            ),

            // 2 Long Buttons --------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildLongButton(
                        imageAsset: 'assets/images/documentation.png',
                        description: 'Find Documentations\nfor Your Courses',
                        title: 'Documentations',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildLongButton2(
                        imageAsset: 'assets/images/clubs_societies.png',
                        description: 'Explore\nClubs & Societies',
                        title: 'Clubs & Societies',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _showImagePopup(
    String imageUrl,
    String title,
    String description,
    String buttonLabel, {
    VoidCallback? onButtonPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupPage(
          imageUrl: imageUrl,
          title: title,
          description: description,
          buttonLabel: buttonLabel,
          onButtonPressed: () {
            onButtonPressed?.call();
          },
        );
      },
    );
  }

  Widget _buildDotIndicator(bool isActive) {
    const activeColor = Color.fromARGB(255, 7, 57, 97);
    const inactiveColor = Colors.grey;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildLongButton({
    required String imageAsset,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 7, 57, 97),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                          bottom: 40, left: 8, right: 8, top: 40),
                      children: [
                        _buildButton1(context, 'UGC Approved'),
                        _buildButton2(context, 'Plymouth University'),
                        _buildButton3(context, 'Victoria University'),
                      ],
                    ),
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(16),
            splashColor: const Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FittedBox(
                child: Row(
                  children: [
                    Image.asset(
                      imageAsset,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLongButton2({
    required String imageAsset,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 7, 57, 97),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                //enableDrag: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                          bottom: 40, left: 8, right: 8, top: 40),
                      children: [
                        _buildButton6(context, 'FOSS Community'),
                        _buildButton5(context, 'CSSL GenZ NSBM'),
                        _buildButton4(context, 'CSSE Circle'),
                      ],
                    ),
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(16),
            splashColor: const Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FittedBox(
                child: Row(
                  children: [
                    Image.asset(
                      imageAsset,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Bottom Sheet method for longButtons
  void _showBottomSheet(BuildContext context, Widget contentWidget) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableActuator(child: contentWidget);
      },
    );
  }

  Widget _buildButton1(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 50, 128, 246),
          ),
        ),
        onPressed: () {
          _showBottomSheet(context, const UGCDocPage());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UGCDocPage()),
          // );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  //Button for plymouth Approved
  Widget _buildButton2(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 50, 128, 246),
          ),
        ),
        onPressed: () {
          _showBottomSheet(context, const PlyDocPage());

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UGCDocPage()),
          // );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

//Button for Victoria Approved
  Widget _buildButton3(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 50, 128, 246),
          ),
        ),
        onPressed: () {
          _showBottomSheet(context, const VicDocPage());

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UGCDocPage()),
          // );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  //Button for CSSE Circle
  Widget _buildButton4(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 50, 128, 246),
          ),
        ),
        onPressed: () {
          _showBottomSheet(context, CSSEDoc());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UGCDocPage()),
          // );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

//Button for CCSL Circle
  Widget _buildButton5(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 50, 128, 246),
          ),
        ),
        onPressed: () {
          _showBottomSheet(context, const CSSLDoc());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UGCDocPage()),
          // );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

//Button for FOSS Community
  Widget _buildButton6(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 50, 128, 246),
          ),
        ),
        onPressed: () {
          _showBottomSheet(context, const FOSSDoc());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UGCDocPage()),
          // );
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class DepartmentButton extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  final VoidCallback onTap;

  const DepartmentButton({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDepartmentButtons(
      imageAsset: imageAsset,
      title: title,
      description: description,
      onTap: onTap,
    );
  }

  Widget _buildDepartmentButtons({
    required String imageAsset,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 7, 57, 97),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5),

                // Description and Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Image
                Column(
                  children: [
                    Image.asset(imageAsset, width: 200, height: 200),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemedDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  const ThemedDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: themeProvider.currentTheme.textTheme.bodyText1?.color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButton<String>(
                value: value,
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<String>>((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: themeProvider
                            .currentTheme.textTheme.bodyText1?.color,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
