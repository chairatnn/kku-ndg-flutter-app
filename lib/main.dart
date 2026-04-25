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
import 'comment.dart';
import 'order.dart';
import 'product.dart';
import 'movie.dart';
import 'forms_validation.dart';
import 'food_begin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter KKU Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เมนูหลัก (KKU Flutter App)', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo.shade100,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuSection("ผลงานยอดนิยม"),
          _buildMenuButton(context, '🎬 ดูหนังออนไลน์', const MovieWidget(), Colors.red),
          _buildMenuButton(context, '☁️ สภาพอากาศวันนี้', const WeatherPage(), Colors.blue),
          _buildMenuButton(context, '🍳 ร้านอาหารตามสั่ง', const FoodBeginPage(), Colors.orange),   

          _buildMenuSection("ระบบจัดการข้อมูล"),
          _buildMenuButton(context, '📝 Form & Validation', const FormsValidationPage(), Colors.purple),       
          _buildMenuButton(context, '🍛 Food random', RandomLunchPage(), Colors.orange),
          _buildMenuButton(context, '📦 Product List', const ProductWidget(), Colors.green),
          _buildMenuButton(context, '🛒 Order System', const OrderWidget(), Colors.teal),
          _buildMenuButton(context, '💬 Comment System', const CommentListScreen(), Colors.blueGrey),
          
          _buildMenuSection("มินิเกมและบันเทิง"),
          _buildMenuButton(context, '🎲 Dice Game', const DicePage(), Colors.deepPurple),
          _buildMenuButton(context, '🎹 Piano Play', const PianoPage(), Colors.black87),
          _buildMenuButton(context, '🐶 Cat vs Dog', const CatDogPage(), Colors.brown),
          _buildMenuButton(context, '❤️ Love Click', const LoveClick(), Colors.pink),
          
          _buildMenuSection("พื้นฐานและการตกแต่ง"),
          _buildMenuButton(context, '👤 User Profile', const ProfilePage(), Colors.cyan),
          _buildMenuButton(context, '🇹🇭 Thai Flag', const ThaiFlag(), Colors.redAccent),
          _buildMenuButton(context, '📱 SafeArea & Layout', const SafeAreaPage(), Colors.grey),
          _buildMenuButton(context, '🖼️ Expand Picture', const ExpandPic(), Colors.amber),
          _buildMenuButton(context, '🔘 My Buttons', const MyButton(), Colors.deepOrange),
          _buildMenuButton(context, '✨ Icon & Text Lab', const IconTextConImg(), Colors.indigoAccent),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo)),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget targetPage, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
        },
        leading: Icon(Icons.ads_click, color: color),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // เพิ่มปุ่มกลับหน้าหลักให้ชัดเจน
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( 
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(Icons.bolt, size: 80, color: Colors.orange),
              const Text('หน้านี้คือตัวอย่าง Widget พื้นฐาน', style: TextStyle(fontSize: 18)),
              const Divider(height: 50),
              
              // รูปภาพจาก URL
              const Text('รูปภาพจาก Network:'),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://picsum.photos/300/150',
                  height: 150,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const CircularProgressIndicator();
                  },
                ),
              ),

              const SizedBox(height: 30),

              // แก้ไขส่วน Asset เพื่อป้องกันอาการค้าง
              const Text('รูปภาพจาก Local Asset:'),
              Container(
                height: 150,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.asset(
                  'assets/54150.jpg',
                  errorBuilder: (context, error, stackTrace) => const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 50, color: Colors.red),
                      Text('ไม่พบไฟล์รูปภาพใน Assets', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              
              Text('จำนวนการกดปุ่ม: $_counter', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => setState(() => _counter++),
                icon: const Icon(Icons.add),
                label: const Text('กดเพื่อเพิ่มตัวเลข'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}






