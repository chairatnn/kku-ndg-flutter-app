import 'package:flutter/material.dart';

class SafeAreaPage extends StatelessWidget {
  const SafeAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ดึงค่าขนาดของพื้นที่ที่ SafeArea ช่วยหลบให้ (เช่น ความสูงของรอยบาก)
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      // เราใช้ SafeArea ครอบเฉพาะส่วนเนื้อหา
      body: SafeArea(
        child: Column(
          children: [
            // ส่วนหัว: แสดงข้อมูลพื้นที่ที่ปลอดภัย
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "SafeArea Info: Top=${padding.top.toInt()}px",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Row(
                children: [
                  // 1. แถบสีแดง: อธิบายเรื่อง Notch (รอยบาก)
                  Expanded(
                    child: Container(
                      color: const Color(0xFFE55A4F),
                      child: const RotatedBox(
                        quarterTurns: 3,
                        child: Center(
                          child: Text("หลบรอยบากด้านบน", 
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ),
                  ),

                  // 2. ส่วนกลาง: อธิบายหน้าที่ของ SafeArea
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.security, size: 50, color: Colors.blue),
                          const SizedBox(height: 10),
                          const Text("Safe Area", 
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "ป้องกันเนื้อหาถูกกลืนไปกับขอบจอหรือกล้องหน้า",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(width: 80, height: 80, color: const Color(0xFFFFEB61)),
                          Container(width: 80, height: 80, color: const Color(0xFFF7A543)),
                        ],
                      ),
                    ),
                  ),

                  // 3. แถบสีเขียว: อธิบายเรื่องระบบ Navigation Bar ด้านล่าง
                  Expanded(
                    child: Container(
                      color: const Color(0xFF67B367),
                      child: const RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text("หลบแถบโฮมด้านล่าง", 
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}