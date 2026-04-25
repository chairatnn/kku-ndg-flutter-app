import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    // กำหนดธีมสีหลัก (ตัวอย่างสี Slate เหมือนโปรเจกต์ก่อนหน้าของคุณ)
    final primaryColor = Colors.indigo[600];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20), // ไอคอนที่ดูทันสมัยขึ้น
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[800],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // หัวข้อเพื่อความชัดเจน
              Text(
                "Button Styles",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 40),

              // 1. Disabled Button (ปรับให้ดูจางแบบสะอาดตา)
              SizedBox(
                width: double.infinity, // ปรับปุ่มให้กว้างเต็มพื้นที่
                height: 55,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.grey[200],
                    disabledForegroundColor: Colors.grey[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text("Disabled Button"),
                ),
              ),

              const SizedBox(height: 20),

              // 2. Enabled Button (เพิ่ม Gradient หรือสีสันที่เด่นชัด)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // เพิ่ม Feedback เช่นการสั่นเล็กน้อยหรือเสียง (ถ้ามี)
                    print("Action Triggered!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: primaryColor?.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 20),
                      SizedBox(width: 10),
                      Text("Confirm Action", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}