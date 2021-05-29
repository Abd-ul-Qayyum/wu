import 'package:dating/constants.dart';
import 'package:dating/model/User.dart';
import 'package:dating/services/FirebaseHelper.dart';
import 'package:dating/services/helper.dart';
import 'package:dating/ui/SwipeScreen/SwipeScreen.dart';
import 'package:dating/ui/conversationsScreen/ConversationsScreen.dart';
import 'package:dating/ui/profile/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DrawerSelection { Conversations, Contacts, Search, Profile }

class HomeScreen extends StatefulWidget {
  final User user;
  static bool onGoingCall = false;

  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  late User user;
  String _appBarTitle = 'Swipe';

  late Widget _currentWidget;

  @override
  void initState() {
    user = widget.user;
    super.initState();
    _currentWidget = SwipeScreen(
      user: user,
    );
    FireStoreUtils.firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: user,
      child: Consumer<User>(
        builder: (context, user, _) {
          return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _appBarTitle = 'Swipe';
                    _currentWidget = SwipeScreen(
                      user: user,
                    );
                  });
                },
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: _appBarTitle == 'Swipe' ? 40 : 24,
                  height: _appBarTitle == 'Swipe' ? 40 : 24,
                  color: _appBarTitle == 'Swipe'
                      ? Color(COLOR_PRIMARY)
                      : Colors.grey,
                ),
              ),
              leading: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _appBarTitle == 'Profile'
                        ? Color(COLOR_PRIMARY)
                        : Colors.grey,
                  ),
                  iconSize: _appBarTitle == 'Profile' ? 35 : 24,
                  onPressed: () {
                    setState(() {
                      _appBarTitle = 'Profile';
                      _currentWidget = ProfileScreen(user: user);
                    });
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    setState(() {
                      _appBarTitle = 'Conversations';
                      _currentWidget = ConversationsScreen(user: user);
                    });
                  },
                  color: _appBarTitle == 'Conversations'
                      ? Color(COLOR_PRIMARY)
                      : Colors.grey,
                  iconSize: _appBarTitle == 'Conversations' ? 35 : 24,
                )
              ],
              backgroundColor: Colors.transparent,
              brightness:
                  isDarkMode(context) ? Brightness.dark : Brightness.light,
              centerTitle: true,
              elevation: 0,
            ),
            body: _currentWidget,
          );
        },
      ),
    );
  }
}
