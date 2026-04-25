import 'package:flutter/material.dart';

class ThaiFlag extends StatelessWidget {
  const ThaiFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                onPressed: () => Navigator.pop(context), // คำสั่งย้อนกลับ
              ),
              const SizedBox(height: 10), // ระยะห่างจากขอบบน

              // --- ธงชาติอันที่ 1: แนวนอนปกติ ---
              const SizedBox(height: 10),
              buildFlag(),

              const SizedBox(height: 40), // เว้นระยะห่างระหว่างธงเล็กน้อย (40 pixel)

              // --- ธงชาติอันที่ 2: หมุน 90 องศา (แนวตั้ง) ---
              const SizedBox(height: 10),
              RotatedBox(
                quarterTurns: 1, // หมุน 1 ครั้ง = 90 องศา
                child: buildFlag(),
              ),

              const SizedBox(height: 50), // ระยะห่างจากขอบล่าง
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างธงชาติ (ต้นฉบับ)
  Widget buildFlag() {
    return Container(
      width: 300, 
      height: 200, 
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Expanded(flex: 1, child: Container(color: const Color(0xFFED1C24))),
          Expanded(flex: 1, child: Container(color: Colors.white)),
          Expanded(flex: 2, child: Container(color: const Color(0xFF242A56))),
          Expanded(flex: 1, child: Container(color: Colors.white)),
          Expanded(flex: 1, child: Container(color: const Color(0xFFED1C24))),
        ],
      ),
    );
  }
}