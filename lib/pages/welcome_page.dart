
import 'package:Youtube/Registration/login.dart';
import 'package:Youtube/Registration/register.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {

  AnimationController _controller1;
  Animation<Offset> animation1;
  AnimationController _controller2;
  Animation<Offset> animation2;

 

  @override
  void initState() {
   
    super.initState();

    //animation 1
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeOut),
    );

// animation 2
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut),
    );

    _controller1.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
   
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ Color(0xFFFF0000), Color(0xFFD10303),],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: animation1,
                  child: Image.asset('assets/logo.png',
                  height: 150, 
                  width:150,
                  ),
                  
                  
                    
                  
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 6,
                // ),
                SlideTransition(
                  position: animation1,
                  child: Text(
                    "YouTube",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                boxContainer("assets/google.png", "Sign up with Google", null),
              
                SizedBox(
                  height: 10,
                ),
                boxContainer(
                  "assets/email2.png",
                  "Sign up with Email",
                  onEmailClick,
                ),
                SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position: animation2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RegisterPage(),
    ));
  }

  Widget boxContainer(String path, String text, onClick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 100,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    path,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
