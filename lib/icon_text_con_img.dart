import 'package:flutter/material.dart';
import 'dart:math'; // ต้องมีอันนี้เพื่อใช้ Random()

class IconTextConImg extends StatelessWidget {
  const IconTextConImg({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () => Navigator.pop(context), // คำสั่งย้อนกลับ
          ),
          const SizedBox(height: 20),

          // 1 & 2. Icon และ "สวัสดี" (Row 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 50, color: Colors.blue),
              const SizedBox(width: 10),
              const Text(
                "สวัสดี",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 3 & 4. กล่องสุ่มสี (Row 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                // สุ่มสีโดยเลือกจากค่าความเข้มสี (ARGB)
                color: Color(
                  (Random().nextDouble() * 0xFFFFFF).toInt(),
                ).withValues(alpha: 1.0),
              ),
              const SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                color: Color(
                  (Random().nextDouble() * 0xFFFFFF).toInt(),
                ).withValues(alpha: 1.0),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 5 & 6. รูปภาพ 2 รูป (Row 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://picsum.photos/id/17/150/300',
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20), // ระยะห่างระหว่างรูป
              Image.network(
                'https://picsum.photos/id/19/150/300',
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
