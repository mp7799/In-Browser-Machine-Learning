import 'package:flutter/material.dart';

class LandingPageNavigationBar extends StatefulWidget {
  @override
  _LandingPageNavigationBarState createState() =>
      _LandingPageNavigationBarState();
}

class _LandingPageNavigationBarState extends State<LandingPageNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1250)
        return DesktopNavBar();
      else
        return MobileNavBar();
    });
  }
}

class DesktopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0, 30.0, 35.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              NavbarIconButton(icon: Icons.menu),
              SpaceBetweenButtons(),
              NavbarIconButton(icon: Icons.search),
            ],
          ),
          Row(
            children: [
              Text(
                'L',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'inear',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Century Goth",
                ),
              ),
              Text(
                '  R',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'egression',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Century Goth",
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Train your machine learning model right in the browser',style: TextStyle(
                fontFamily: "Century Goth",
                fontSize: 25.0,
              ),),
            ],
          ),
          Row(
            children: [
              NavbarIconButton(icon: Icons.person),
              SpaceBetweenButtons(),
              NavbarIconButton(icon: Icons.bookmark_border),
              SpaceBetweenButtons(),
              InkWell(
                child: Text(
                  'EN',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Century Goth",
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[100],
                  ),
                ),
                focusColor: Colors.pink[100],
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SpaceBetweenButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35.0,
    );
  }
}

class NavbarIconButton extends StatelessWidget {
  final IconData icon;

  NavbarIconButton({this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        icon,
        size: 25,
        color: Color(0xff4B4B49),
      ),
      onTap: () {},
    );
  }
}

class MobileNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
