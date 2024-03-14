import 'package:contact_app_final/ThemeProvider.dart';
import 'package:contact_app_final/android_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splace_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Splace_ScreenState();
  }

}
class Splace_ScreenState extends State<Splace_Screen> with SingleTickerProviderStateMixin{
   late AnimationController _controller;
   late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    Future.delayed(Duration(seconds: 4),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => android_contact(),));
    },);
  }
  Widget build(BuildContext context) {


    return Consumer(
      builder: (context,ThemeProvider themeProvider,child) {
        return Scaffold(
          backgroundColor: themeProvider.isLight?Colors.white:Colors.black,
          body: Center(
            child: FadeTransition(
              opacity: _animation,
              child:Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.contacts,color: Color(0xff6A53A7),size: 60,),
                  SizedBox(height: 30,),
                  FadeTransition(
                    opacity: _animation,
                    child: Center(
                      child: Text("Contact App",style: TextStyle(color: themeProvider.isLight?Colors.black:Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              )
            ),
          ),
        );
      }
    );
  }

   @override
   void dispose() {
     _controller.dispose();
     super.dispose();
   }

}