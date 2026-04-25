import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // กำหนดสีหลักเพื่อให้ดูเป็นธีมเดียวกัน
    final primaryColor = Colors.blueGrey[900];

    return Scaffold(
      backgroundColor: Colors.grey[100], // พื้นหลังสีเทาอ่อนช่วยให้ Card เด่นขึ้น
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // --- ส่วนรูปโปรไฟล์พร้อมเงาและขอบขาว ---
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: const NetworkImage('https://picsum.photos/id/10/200/200'),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- ชื่อและตำแหน่ง ---
              Text(
                'Chairat N.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Software Developer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 32),

              // --- ข้อมูลติดต่อในรูปแบบ Card เพื่อความชัดเจน ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.phone_android_rounded,
                        label: 'Phone',
                        value: '099-190-1900',
                        iconColor: Colors.orange,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1),
                      ),
                      _buildInfoTile(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: 'chairat@example.com',
                        iconColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // --- ปุ่ม Social Media หรือปุ่ม Action ---
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18),
                label: const Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันช่วยสร้างบรรทัดข้อมูล (Helper Widget)
  Widget _buildInfoTile({
    required IconData icon, 
    required String label, 
    required String value, 
    required Color iconColor
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}