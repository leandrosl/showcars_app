import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Desenvolvido por:",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Text(
                "Leandro Souza",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 48.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/images/social-logos/github-64.png"),
                          height: 48.0,
                        ),
                        Text('GitHub'),
                      ],
                    ),
                    onTap: () => null,
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        FlutterLogo(size: 48.0),
                        Text('Blog'),
                      ],
                    ),
                    onTap: () => null,
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/images/social-logos/linkedin-64.png"),
                          height: 48.0,
                        ),
                        Text('Linkedin'),
                      ],
                    ),
                    onTap: () => null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}