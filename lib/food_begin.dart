import 'package:flutter/material.dart';
import 'random_lunch.dart'; // Import เพื่อเรียกใช้หน้าสุ่มอาหาร

class FoodBeginPage extends StatefulWidget {
  const FoodBeginPage({super.key});

  @override
  State<FoodBeginPage> createState() => _FoodBeginPageState();
}

class _FoodBeginPageState extends State<FoodBeginPage> {
  // อัปเดตรายการอาหารให้ครบ 20 รายการตาม random_lunch.dart
  final List<Map<String, dynamic>> _menuItems = [
    {
      "name": "ข้าวกะเพราไข่ดาว",
      "price": 50,
      "controller": TextEditingController(),
    },
    {
      "name": "ผัดไทยกุ้งสด",
      "price": 60,
      "controller": TextEditingController(),
    },
    {"name": "ต้มยำกุ้ง", "price": 150, "controller": TextEditingController()},
    {
      "name": "แกงเขียวหวาน",
      "price": 80,
      "controller": TextEditingController(),
    },
    {"name": "ส้มตำไทย", "price": 45, "controller": TextEditingController()},
    {"name": "ข้าวมันไก่", "price": 45, "controller": TextEditingController()},
    {"name": "ข้าวผัด", "price": 45, "controller": TextEditingController()},
    {"name": "ข้าวขาหมู", "price": 50, "controller": TextEditingController()},
    {
      "name": "ก๋วยเตี๋ยวเรือ",
      "price": 40,
      "controller": TextEditingController(),
    },
    {
      "name": "ข้าวหน้าเป็ด",
      "price": 60,
      "controller": TextEditingController(),
    },
    {"name": "เย็นตาโฟ", "price": 50, "controller": TextEditingController()},
    {
      "name": "ข้าวราดผัดพริกแกง",
      "price": 50,
      "controller": TextEditingController(),
    },
    {"name": "คั่วไก่", "price": 50, "controller": TextEditingController()},
    {
      "name": "ข้าวคลุกกะปิ",
      "price": 55,
      "controller": TextEditingController(),
    },
    {
      "name": "คะน้าหมูกรอบ",
      "price": 60,
      "controller": TextEditingController(),
    },
    {
      "name": "ไข่เจียวหมูสับ",
      "price": 40,
      "controller": TextEditingController(),
    },
    {
      "name": "ราดหน้าหมูนุ่ม",
      "price": 50,
      "controller": TextEditingController(),
    },
    {"name": "ผัดซีอิ๊ว", "price": 50, "controller": TextEditingController()},
    {"name": "ลาบหมู", "price": 70, "controller": TextEditingController()},
    {"name": "ข้าวหมูแดง", "price": 50, "controller": TextEditingController()},
  ];

  @override
  void dispose() {
    for (var item in _menuItems) {
      item["controller"].dispose();
    }
    super.dispose();
  }

  void _calculateOrder() {
    String summary = "";
    int grandTotal = 0;

    for (var item in _menuItems) {
      int quantity = int.tryParse(item["controller"].text) ?? 0;
      if (quantity > 0) {
        int totalPerItem = quantity * (item["price"] as int);
        grandTotal += totalPerItem;
        summary += "${item["name"]} x $quantity = $totalPerItem บาท\n";
      }
    }

    if (summary.isEmpty) {
      _showMsg("กรุณากรอกจำนวนอาหารอย่างน้อย 1 รายการ");
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "📝 สรุปรายการสั่งอาหาร",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          // เพิ่มส่วนนี้เพื่อให้ Scroll ได้กรณีสั่งเยอะ
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(summary),
              const Divider(),
              Text(
                "ยอดรวมทั้งสิ้น: $grandTotal บาท",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("แก้ไข"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showMsg("สั่งอาหารสำเร็จ! กรุณารอสักครู่");
            },
            child: const Text("ยืนยันการสั่ง"),
          ),
        ],
      ),
    );
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ฟังก์ชันใหม่สำหรับเปิดหน้าสุ่มและรับค่ากลับมา
  void _goToRandomPage() async {
    // 1. รอรับชื่ออาหารที่ส่งกลับมา (ใช้ await)
    final selectedFoodName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RandomLunchPage()),
    );

    // 2. ถ้ามีการเลือกอาหารกลับมา (ไม่ใช่ออกจากหน้าเฉยๆ)
    if (selectedFoodName != null && selectedFoodName is String) {
      setState(() {
        // วนลูปหาว่าอาหารชื่อนี้อยู่ Index ไหน
        for (var item in _menuItems) {
          if (item["name"] == selectedFoodName) {
            // ดึงค่าปัจจุบันมา ถ้าเป็นว่างให้เป็น 0 แล้วบวกไป 1
            int currentQty = int.tryParse(item["controller"].text) ?? 0;
            item["controller"].text = (currentQty + 1).toString();

            _showMsg("เพิ่ม ${item['name']} 1 จานแล้ว");
            break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ร้านอาหารตามสั่ง (KKU Food)"),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            tooltip: 'สุ่มเมนูอาหาร',
            onPressed: _goToRandomPage, // เรียกใช้ฟังก์ชันที่สร้างใหม่
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      item["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("ราคาจานละ ${item["price"]} บาท"),
                    trailing: SizedBox(
                      width: 80,
                      child: TextFormField(
                        controller: item["controller"],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "0",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _calculateOrder,
              icon: const Icon(Icons.check_circle),
              label: const Text(
                "ยืนยันการสั่งซื้อ",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
