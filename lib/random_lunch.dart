import 'package:flutter/material.dart';
import 'dart:math';

class RandomLunchPage extends StatefulWidget {
  const RandomLunchPage({super.key});

  @override
  State<RandomLunchPage> createState() => _RandomLunchPageState();
}

class _RandomLunchPageState extends State<RandomLunchPage> {
  int foodIndex = 0;

  // รายการอาหารพร้อมชื่อไฟล์ asset แบบลำดับ food1 - food20
  final List<Map<String, String>> foodMenu = [
    {'name': 'ข้าวกะเพราไข่ดาว', 'url': 'https://images.unsplash.com/photo-1563379091339-03b21bc4a4f8?w=500', 'asset': 'assets/images/food1.png'},
    {'name': 'ผัดไทยกุ้งสด', 'url': 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=500', 'asset': 'assets/images/food2.jpeg'},
    {'name': 'ต้มยำกุ้ง', 'url': 'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=500', 'asset': 'assets/images/food3.jpeg'},
    {'name': 'แกงเขียวหวาน', 'url': 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=500', 'asset': 'assets/images/food4.jpeg'},
    {'name': 'ส้มตำไทย', 'url': 'https://images.unsplash.com/photo-1563833717765-00462801314e?w=500', 'asset': 'assets/images/food5.jpeg'},
    {'name': 'ข้าวมันไก่', 'url': 'https://images.unsplash.com/photo-1627993072227-2c902787834a?w=500', 'asset': 'assets/images/food6.jpeg'},
    {'name': 'ข้าวผัด', 'url': 'https://images.unsplash.com/photo-1600335895229-6e75511ee948?w=500', 'asset': 'assets/images/food7.jpeg'},
    {'name': 'ข้าวขาหมู', 'url': 'https://images.unsplash.com/photo-1644310860582-825164101e43?w=500', 'asset': 'assets/images/food8.jpeg'},
    {'name': 'ก๋วยเตี๋ยวเรือ', 'url': 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=500', 'asset': 'assets/images/food9.jpeg'},
    {'name': 'ข้าวหน้าเป็ด', 'url': 'https://images.unsplash.com/photo-1633504584403-999330691e84?w=500', 'asset': 'assets/images/food10.jpeg'},
    {'name': 'เย็นตาโฟ', 'url': 'https://images.unsplash.com/photo-1662544252542-a16298533c30?w=500', 'asset': 'assets/images/food11.jpeg'},
    {'name': 'ข้าวราดผัดพริกแกง', 'url': 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=500', 'asset': 'assets/images/food12.jpeg'},
    {'name': 'คั่วไก่', 'url': 'https://images.unsplash.com/photo-1626074353765-517a681e40be?w=500', 'asset': 'assets/images/food13.jpeg'},
    {'name': 'ข้าวคลุกกะปิ', 'url': 'https://images.unsplash.com/photo-1512058560366-cd2429597e70?w=500', 'asset': 'assets/images/food14.jpeg'},
    {'name': 'คะน้าหมูกรอบ', 'url': 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=500', 'asset': 'assets/images/food15.jpeg'},
    {'name': 'ไข่เจียวหมูสับ', 'url': 'https://images.unsplash.com/photo-1564671165093-206ee2d27a89?w=500', 'asset': 'assets/images/food16.jpeg'},
    {'name': 'ราดหน้าหมูนุ่ม', 'url': 'https://images.unsplash.com/photo-1618449840665-9ed506d73a34?w=500', 'asset': 'assets/images/food17.jpeg'},
    {'name': 'ผัดซีอิ๊ว', 'url': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500', 'asset': 'assets/images/food18.jpeg'},
    {'name': 'ลาบหมู', 'url': 'https://images.unsplash.com/photo-1563833718211-233636606a2e?w=500', 'asset': 'assets/images/food19.jpeg'},
    {'name': 'ข้าวหมูแดง', 'url': 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=500', 'asset': 'assets/images/food20.jpeg'},
  ];

  void shuffleFood() {
    setState(() {
      foodIndex = Random().nextInt(foodMenu.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> currentFood = foodMenu[foodIndex];
    final String foodName = currentFood['name'] ?? 'ไม่ทราบชื่อ';
    final String assetPath = currentFood['asset'] ?? '';
    final String networkUrl = currentFood['url'] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('สุ่มเมนูอาหาร'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                foodName,
                style: const TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: assetPath.isNotEmpty 
                    ? Image.asset(
                        assetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // หากหาไฟล์ในเครื่องไม่เจอ ให้โหลดจากอินเทอร์เน็ตแทน
                          return _buildNetworkImage(networkUrl);
                        },
                      )
                    : _buildNetworkImage(networkUrl),
                ),
              ),
              const SizedBox(height: 40),
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ปุ่มเดิม (เปลี่ยน Label นิดหน่อยให้สั้นลง)
                  ElevatedButton.icon(
                    onPressed: shuffleFood,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text('สุ่มใหม่', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // ปุ่มใหม่: สำหรับเลือกรายการนี้ส่งกลับไปหน้าสั่งอาหาร
                  ElevatedButton.icon(
                    onPressed: () {
                      // ส่งชื่ออาหารกลับไป (Navigator.pop พร้อมข้อมูล)
                      Navigator.pop(context, foodName);
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const Text('เลือกเมนูนี้', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // ใช้สีเขียวให้ดูเป็นปุ่มยืนยัน
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget สำหรับโหลดรูปภาพจากอินเทอร์เน็ต (Fallback)
  Widget _buildNetworkImage(String url) {
    if (url.isEmpty) {
      return const Center(child: Icon(Icons.restaurant, size: 80, color: Colors.grey));
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, size: 50, color: Colors.grey),
              Text('โหลดรูปไม่สำเร็จ', style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}