import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor:  Colors.red,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 190.0,
                  width: 190.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Colors.white,
                  ),
                  child: Icon(Icons.directions_bus, size: 100.0,),
                ),
                SizedBox(height: 10),
                Text("Bienvenue Tunis Transport", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 150),
                InkWell(
                    child: Text("Itinéraires", style: TextStyle(color: Colors.white, fontSize: 22)),
                    onTap: () {
                      setState(() {
                        if (isCollapsed)
                          _controller.forward();
                        else
                          _controller.reverse();

                        isCollapsed = !isCollapsed;
                      });
                    },
                ),
                SizedBox(height: 10),
                Text("Messages", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Methodes de payments", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Partager avec un ami...", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Infos", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color:  Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      color: Colors.red,
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.white),
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        Text("Tunis Transport", style: TextStyle(fontSize: 24, color: Colors.white)),
                      ],
                  )),
                  Container(
                    height: 190.0,
                    width: 190.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.0),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.directions_bus, size: 100.0,),
                  ),
                  Container(
                    height: 190.0,
                    width: 190.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.0),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.train, size: 100.0,),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("My position"),
                      Text("Destination"),
                      Text("Results ...")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}