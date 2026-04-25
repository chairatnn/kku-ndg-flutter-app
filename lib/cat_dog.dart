import 'package:flutter/material.dart';

class CatDogPage extends StatefulWidget {
  const CatDogPage({super.key});

  @override
  State<CatDogPage> createState() => _CatDogPageState();
}

class _CatDogPageState extends State<CatDogPage> {
  // กำหนด URL ของรูปภาพ
  final String _dogUrl =
      'https://images.dog.ceo/breeds/retriever-golden/n02099601_3004.jpg';
  final String _catUrl =
      'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=500';
  // ตัวแปรเก็บ URL ปัจจุบันที่ต้องการแสดง (เริ่มต้นเป็นรูปสุนัข)
  String? _currentImageUrl;
  String _currentType = "เลือกสัตว์อะไรดี";

  void _showDog() {
    setState(() {
      _currentImageUrl = _dogUrl;
      _currentType = "Dog";
    });
  }

  void _showCat() {
    setState(() {
      _currentImageUrl = _catUrl;
      _currentType = "Cat";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat & Dog'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentType,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // ส่วนแสดงรูปภาพ
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orangeAccent, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: _currentImageUrl != null
                    ? Image.network(
                        _currentImageUrl!,
                        key: ValueKey(
                          _currentImageUrl,
                        ), // <--- เพิ่มบรรทัดนี้ เพื่อบังคับให้โหลดใหม่
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint(
                            "❌ Log Error: $error",
                          ); // ดูใน Debug Console ของ Android Studio
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.red,
                              ),
                              Text(
                                "Error: ${error.toString().split(':').first}",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          );
                        },
                      )
                    : const Icon(Icons.pets, size: 80, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 40),

            // ปุ่มกด
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _showDog,
                  icon: const Icon(Icons.pets), // ไอคอนสุนัข
                  label: const Text('Hong'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _showCat,
                  icon: const Icon(Icons.cruelty_free), // ไอคอนแมว
                  label: const Text('Meow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
