
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_radio/home_screen.dart';
import 'package:online_radio/quran_home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_radio/quran_net_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Deviation extends StatefulWidget {
  @override
  _DeviationState createState() => _DeviationState();
}

class _DeviationState extends State<Deviation> {
  List<Widget> _page = [HomeScreen(), QuranNetScreen(), QuranScreen()];
  int _selectIndex = 0;

  void _select(int index) {
    setState(() {
      _selectIndex = index;
      print(_selectIndex);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          Container(
            margin: EdgeInsets.only(top: 10, right: 20),
            child: GestureDetector(
              onTap: () {
                exit(0);
              },
              child: Column(
                children: [
                  Text('إغلاق', style: TextStyle(fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.exit_to_app, size: 32,),
                ],
              ),
            ),
          ),

        ],

        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'إذاعَة فاستقِم كمَا أُمِرت',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            fontFamily: 'THARWATEMARARUQAALIGHT2',
          ),
        ),
      ),
      body: _page[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 17,
        unselectedFontSize: 12,
        onTap: _select,
        currentIndex: _selectIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              title: Text("دروس", style: TextStyle(fontFamily: 'Cairo'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.volume_up_outlined),
              title: Text(
                "القرآن الكريم",
                style: TextStyle(fontFamily: 'Cairo'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              title: Text(
                "تفسير القرآن",
                style: TextStyle(fontFamily: 'Cairo'),
              )),

        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 100,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/image.png'))),
                  ),
                  SizedBox(),
                  Container(
                    margin: EdgeInsets.only(left: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Container(
                          child: Text('إذاعة فاستقم كما أمرت',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold)),
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 20),

                        ),
                        Container(
                          child: Text('Estaqim Radio ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'إذاعـة الدروس',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectIndex = 0;
                  Navigator.of(context).pop();
                });
              },
              leading: Icon(
                Icons.mic_rounded,
                size: 30,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('إذاعة القرآن الكريم',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  _selectIndex = 1;
                  Navigator.of(context).pop();
                });
              },
              leading: Icon(
                Icons.volume_up_outlined,
                size: 30,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('إذاعة تفسير القرآن ',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  _selectIndex = 2;
                  Navigator.of(context).pop();
                });
              },
              leading: Icon(
                Icons.menu_book_rounded,
                size: 30,
              ),
            ),
            Divider(),
            SizedBox(height: 30,),
            Center(
              child: Text(': تابعونا عبر',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: RaisedButton.icon(
                color: Colors.blue[700],
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                label: Text('الفيسبوك',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  const fbProtocolUrl = "fb://page/1837030563201860";
                  const fbUrl = 'https://m.facebook.com/esteqim/';
                  try {
                    bool launched =
                    await launch(fbProtocolUrl, forceSafariVC: false);
                    if (!launched) {
                      await launch(fbUrl, forceSafariVC: false);
                    }
                  } catch (e) {
                    await launch(fbUrl, forceSafariVC: false);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: RaisedButton.icon(
                color: Color.fromRGBO(0, 136, 204, 1),
                icon: Icon(
                  FontAwesomeIcons.telegramPlane,
                  color: Colors.white,
                ),
                label: Text('التلغرام',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  const tlgramUrl = 'https://t.me/estaqim01';
                  if (await canLaunch(tlgramUrl)) {
                    await launch(tlgramUrl);
                  } else {
                    throw 'could not lanch $tlgramUrl';
                  }
                },
              ),
            ),
            SizedBox(height: 30,),
            // Divider(),
            // SizedBox(height: 50,),
            // Center(
            //   child: Row(
            //      mainAxisAlignment: MainAxisAlignment.center,
            //      crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //      Icon(
            //       FontAwesomeIcons.exclamationCircle,
            //       color: Colors.white,
            //     ),
            //     SizedBox(width: 10,),
            //       Text('حول التطبيق',
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontFamily: 'Cairo',
            //             fontWeight: FontWeight.bold,
            //           )),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
