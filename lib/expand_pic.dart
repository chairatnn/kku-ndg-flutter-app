import 'package:flutter/material.dart';

class ExpandPic extends StatelessWidget {
  const ExpandPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expanded Images"),
      ),
      // ใช้ Column เพื่อเรียงรูปในแนวตั้ง
      body: Row(
        children: [
          // รูปที่ 1: ใช้ Expanded เพื่อให้กินพื้นที่ครึ่งบน
          Expanded(
            child: Container(
              width: double.infinity, // ขยายเต็มความกว้างหน้าจอ
              margin: const EdgeInsets.all(8.0), // เว้นขอบรอบรูปเล็กน้อย
              child: Image.network(
                'https://picsum.photos/id/237/200/300',
                fit: BoxFit.cover, // ให้รูปขยายเต็มพื้นที่ Container
              ),
            ),
          ),

          // รูปที่ 2: ใช้ Expanded เพื่อให้กินพื้นที่ครึ่งล่าง
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://picsum.photos/id/1/200/300',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}