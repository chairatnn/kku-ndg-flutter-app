import 'package:flutter/material.dart';
import 'weather_page.dart';
import 'icon_text_con_img.dart';
import 'thai_flag.dart';
import 'button.dart';
import 'safe_area.dart';
import 'expand_pic.dart';
import 'profile.dart';
import 'activity1.dart';
import 'love_click.dart';
import 'cat_dog.dart';
import 'dice.dart';
import 'random_lunch.dart';
import 'piano.dart';
import 'product.dart';
import 'order.dart';
import 'movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // สลับไปมาระหว่างหน้า Main กับหน้า Test อื่นๆได้ที่นี่
      // home: const MyHomePage(title: 'Flutter KKU Test Page'),
      // home: const WeatherPage(),
      // home: const IconTextConImg(),
      // home: const ThaiFlag(),
      // home: const MyButton(),
      // home: const SafeAreaPage(),
      // home: const ExpandPic(),
      // home: const ProfilePage(),
      // home: const MyApp1(),
      // home: const LoveClick(),
      // home: const CatDogPage(),
      // home: const DicePage(),
      // home: RandomLunchPage(),
      // home: const PianoPage(),
      // home: const ProductWidget(),
      // home: const OrderWidget(),
       home: const MovieWidget(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // 1. แทรก Icon
              const Icon(Icons.bolt, size: 50, color: Colors.orange),
              const Text('Icon สายฟ้า'),

              const Divider(height: 40),

              // 2. แทรก Image จาก URL
              const Text('รูปภาพจาก URL:'),
              Image.network(
                'https://picsum.photos/200/100',
                height: 100,
              ),

              const SizedBox(height: 20),

              // 3. แทรก Image จาก Local File (Asset)
              const Text('รูปภาพจากในเครื่อง :'),
              Image.asset(
                'assets/54150.jpg',
                height: 150,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.image_not_supported, size: 50, color: Colors.red),
              ),

              const Divider(height: 40),

              // 4. แทรกปุ่ม ElevatedButton
              ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('กดปุ่มนี้เพื่อเพิ่มตัวเลข'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),

              const SizedBox(height: 20),
              
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}