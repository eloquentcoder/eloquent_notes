import 'package:elo_notes_app/screens/home_screen.dart';
import 'package:elo_notes_app/utils/size_config.dart';
import 'package:elo_notes_app/utils/theme_data.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(
              flex: 4,
            ),
            Text(
              'Create And \nRecord Your Notes Easily',
              style: headingText(),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 0.6,
            ),
            Text('Notes taking has never been more fun'),
            Spacer(
              flex: 2,
            ),
            Image.asset('assets/images/notes.jpg'),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: buttonColor,
                  ),
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 15,
                  child: IconButton(
                      color: whiteColor,
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()))),
                )
              ],
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
