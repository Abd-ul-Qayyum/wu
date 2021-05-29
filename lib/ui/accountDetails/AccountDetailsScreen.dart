import 'package:dating/constants.dart';
import 'package:dating/main.dart';
import 'package:dating/model/User.dart';
import 'package:dating/services/FirebaseHelper.dart';
import 'package:dating/services/helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountDetailsScreen extends StatefulWidget {
  final User user;

  AccountDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _AccountDetailsScreenState createState() {
    return _AccountDetailsScreenState();
  }
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  late User user;
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? firstName, lastName, age, bio, school, email, mobile;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
          brightness: isDarkMode(context) ? Brightness.dark : Brightness.light,
          centerTitle: true,
          iconTheme: IconThemeData(
              color: isDarkMode(context) ? Colors.white : Colors.black),
          title: Text(
            'Account Details',
            style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black),
          ),
        ),
        body: Builder(
            builder: (buildContext) => SingleChildScrollView(
              child: Form(
                key: _key,
                    autovalidateMode: _validate,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, bottom: 8, top: 24),
                            child: Text(
                              'PUBLIC INFO',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          Material(
                              elevation: 2,
                              color: isDarkMode(context)
                                  ? Colors.black12
                                  : Colors.white,
                              child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: ListTile.divideTiles(
                                      context: buildContext,
                                      tiles: [
                                        ListTile(
                                          title: Text(
                                            'First Name',
                                            style: TextStyle(
                                              color: isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          trailing: ConstrainedBox(
                                            constraints:
                                                BoxConstraints(maxWidth: 100),
                                            child: TextFormField(
                                              onSaved: (String? val) {
                                                firstName = val;
                                              },
                                              validator: validateName,
                                              textInputAction:
                                                  TextInputAction.next,
                                              textAlign: TextAlign.end,
                                              initialValue: user.firstName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isDarkMode(context)
                                                      ? Colors.white
                                                      : Colors.black),
                                              cursorColor: Color(COLOR_ACCENT),
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'First name',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5)),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Last Name',
                                            style: TextStyle(
                                                color: isDarkMode(context)
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          trailing: ConstrainedBox(
                                            constraints:
                                                BoxConstraints(maxWidth: 100),
                                            child: TextFormField(
                                              onSaved: (String? val) {
                                                lastName = val;
                                              },
                                              validator: validateName,
                                              textInputAction:
                                                  TextInputAction.next,
                                              textAlign: TextAlign.end,
                                              initialValue: user.lastName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isDarkMode(context)
                                                      ? Colors.white
                                                      : Colors.black),
                                              cursorColor: Color(COLOR_ACCENT),
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Last name',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5)),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Age',
                                            style: TextStyle(
                                                color: isDarkMode(context)
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          trailing: ConstrainedBox(
                                            constraints:
                                                BoxConstraints(maxWidth: 100),
                                            child: TextFormField(
                                              onSaved: (String? val) {
                                                age = val;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              textAlign: TextAlign.end,
                                              initialValue: user.age,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isDarkMode(context)
                                                      ? Colors.white
                                                      : Colors.black),
                                              cursorColor: Color(COLOR_ACCENT),
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Age',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5)),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Bio',
                                            style: TextStyle(
                                                color: isDarkMode(context)
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          trailing: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .5),
                                            child: TextFormField(
                                              onSaved: (String? val) {
                                                bio = val;
                                              },
                                              initialValue: user.bio,
                                              minLines: 1,
                                              maxLines: 3,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isDarkMode(context)
                                                      ? Colors.white
                                                      : Colors.black),
                                              cursorColor: Color(COLOR_ACCENT),
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Bio',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5)),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'School',
                                            style: TextStyle(
                                                color: isDarkMode(context)
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          trailing: ConstrainedBox(
                                            constraints:
                                                BoxConstraints(maxWidth: 100),
                                            child: TextFormField(
                                              onSaved: (String? val) {
                                                school = val;
                                              },
                                              textAlign: TextAlign.end,
                                              textInputAction:
                                                  TextInputAction.next,
                                              initialValue: user.school,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isDarkMode(context)
                                                      ? Colors.white
                                                      : Colors.black),
                                              cursorColor: Color(COLOR_ACCENT),
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'School',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5)),
                                            ),
                                          ),
                                        ),
                                      ]).toList())),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, bottom: 8, top: 24),
                            child: Text(
                              'PRIVATE DETAILS',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          Material(
                            elevation: 2,
                            color: isDarkMode(context)
                                ? Colors.black12
                                : Colors.white,
                            child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: ListTile.divideTiles(
                                  context: buildContext,
                                  tiles: [
                                    ListTile(
                                      title: Text(
                                        'Email Address',
                                        style: TextStyle(
                                            color: isDarkMode(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      trailing: ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 200),
                                        child: TextFormField(
                                          onSaved: (String? val) {
                                            email = val;
                                          },
                                          validator: validateEmail,
                                          textInputAction: TextInputAction.next,
                                          initialValue: user.email,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                          cursorColor: Color(COLOR_ACCENT),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Email Address',
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5)),
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Phone Number',
                                        style: TextStyle(
                                            color: isDarkMode(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      trailing: ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 150),
                                        child: TextFormField(
                                          onSaved: (String? val) {
                                            mobile = val;
                                          },
                                          validator: validateMobile,
                                          textInputAction: TextInputAction.done,
                                          initialValue: user.phoneNumber,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                          cursorColor: Color(COLOR_ACCENT),
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Phone Number',
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 2)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).toList()),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 32.0, bottom: 16),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: double.infinity),
                                child: Material(
                                  elevation: 2,
                                  color: isDarkMode(context)
                                      ? Colors.black12
                                      : Colors.white,
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(12.0),
                                    onPressed: () async {
                                      _validateAndSave(buildContext);
                                    },
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(COLOR_PRIMARY)),
                                    ),
                                  ),
                                ),
                              )),
                        ]),
                  ),
                )));
  }

  _validateAndSave(BuildContext buildContext) async {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState!.save();
      if (user.email != email) {
        TextEditingController _passwordController = new TextEditingController();
        showDialog(
          context: context,
          builder: (context) => Dialog(
            elevation: 16,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Inorder to change your email, you must type your password first',
                    style: TextStyle(color: Colors.red, fontSize: 17),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(COLOR_ACCENT),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_passwordController.text.isEmpty) {
                          showAlertDialog(context, "Empty Password",
                              "Password is required to update email");
                        } else {
                          Navigator.pop(context);
                          await showProgress(context, 'Verifying...', false);
                          auth.UserCredential? result =
                              await FireStoreUtils.reAuthUser(
                                  user.email, _passwordController.text);
                          if (result == null) {
                            hideProgress();
                            showAlertDialog(context, 'Couldn\'t verify',
                                'Please double check the password and try again.');
                          } else {
                            _passwordController.dispose();
                            if (result.user != null) {
                              await result.user!.updateEmail(email!);
                              updateProgress('Saving details...');
                              await _updateUser(buildContext);
                              hideProgress();
                            } else {
                              hideProgress();
                              ScaffoldMessenger.of(buildContext).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Couldn\'t verify, Please try again.',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text(
                        'Verify',
                        style: TextStyle(
                            color: isDarkMode(context)
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        showProgress(context, "Saving details...", false);
        await _updateUser(buildContext);
        hideProgress();
      }
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  _updateUser(BuildContext buildContext) async {
    user.firstName = firstName!;
    user.lastName = lastName!;
    user.age = age!;
    user.bio = bio!;
    user.school = school!;
    user.email = email!;
    user.phoneNumber = mobile!;
    User? updatedUser = await FireStoreUtils.updateCurrentUser(user);
    if (updatedUser != null) {
      MyAppState.currentUser = user;
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          content: Text(
            'Details saved successfully',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          content: Text(
            'Couldn\'t save details, Please try again.',
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }
}
