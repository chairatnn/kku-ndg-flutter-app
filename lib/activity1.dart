import 'package:flutter/material.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Hello Flutter"),
          foregroundColor: Colors.white,
          actions: [
            IconButton(onPressed: () => {}, icon: Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to ABC Shop"),
              SizedBox(height: 50),
              Image.asset("assets/54150.jpg"),
              IconButton(
                onPressed: () => debugPrint('Login'), 
                icon: Icon(Icons.login)
              ),
            ],
          ),
        ),    
    );
  }
}