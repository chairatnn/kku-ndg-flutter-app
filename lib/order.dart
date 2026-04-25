import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  // ข้อมูลเมนูอาหารและจำนวนที่สั่ง
  final Map<String, int> _orderCounts = {
    'ข้าวกะเพราหมูสับ': 0,
    'ข้าวผัดคะน้าหมูกรอบ': 0,
    'ข้าวไข่เจียวหมูสับ': 0,
    'ผัดไทยกุ้งสด': 0,
  };

  final Map<String, int> _prices = {
    'ข้าวกะเพราหมูสับ': 50,
    'ข้าวผัดคะน้าหมูกรอบ': 60,
    'ข้าวไข่เจียวหมูสับ': 40,
    'ผัดไทยกุ้งสด': 70,
  };

  // เพิ่มจำนวนรายการอาหาร
  void _addItem(String menuName) {
    setState(() {
      _orderCounts[menuName] = (_orderCounts[menuName] ?? 0) + 1;
    });
  }

  // ลดจำนวนรายการอาหาร (ไม่ให้ติดลบ)
  void _removeItem(String menuName) {
    setState(() {
      if ((_orderCounts[menuName] ?? 0) > 0) {
        _orderCounts[menuName] = _orderCounts[menuName]! - 1;
      }
    });
  }

  // คำนวณราคารวมทั้งหมด
  int _calculateTotal() {
    int total = 0;
    _orderCounts.forEach((menu, count) {
      total += count * (_prices[menu] ?? 0);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // กรองเฉพาะรายการที่สั่งมากกว่า 0 เพื่อนำไปแสดงในส่วนสรุป
    final orderedItems = _orderCounts.entries
        .where((entry) => entry.value > 0)
        .toList();

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
              onPressed: () => Navigator.pop(context),
            ),
            const Row(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.deepOrange),
                SizedBox(width: 8),
                Text(
                  "เมนูอาหาร",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 20),

            // ส่วนที่ 1: รายการเลือกอาหาร
            ..._orderCounts.keys.map((menuName) {
              final count = _orderCounts[menuName]!;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                title: Text(
                  menuName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("${_prices[menuName]} บาท"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: count > 0 ? () => _removeItem(menuName) : null,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: count > 0 ? Colors.red : Colors.grey[300],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Text(
                        "$count",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _addItem(menuName),
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            // ส่วนที่ 2: สรุปรายการที่เลือก (แสดงเฉพาะเมื่อมีการสั่ง)
            if (orderedItems.isNotEmpty) ...[
              const Text(
                "สรุปรายการสั่งซื้อ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: orderedItems.map((entry) {
                    final menu = entry.key;
                    final count = entry.value;
                    final price = _prices[menu]!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$menu x $count",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            "${count * price} บาท",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // ส่วนที่ 3: ส่วนสรุปยอดเงินรวม
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.deepOrange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepOrange[100]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ยอดชำระทั้งสิ้น:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${_calculateTotal()} บาท",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _calculateTotal() > 0
                    ? () {
                        // Logic สำหรับขั้นตอนถัดไป
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "ยืนยันการสั่งอาหาร",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
