import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  // ข้อมูลสินค้าพร้อมรูปภาพที่ตรวจสอบแล้วว่าใช้งานได้
  final List<Map<String, dynamic>> _products = [
    {
      'id': 'p1',
      'name': 'หูฟังบลูทูธไร้สาย',
      'price': 1290,
      'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=500',
      'count': 0,
    },
    {
      'id': 'p2',
      'name': 'นาฬิกาสมาร์ทวอทช์',
      'price': 3500,
      'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=500',
      'count': 0,
    },
    {
      'id': 'p3',
      'name': 'กล้องดิจิทัลคอมแพค',
      'price': 2400,
      'imageUrl': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=500',
      'count': 0,
    },
    {
      'id': 'p4',
      'name': 'กระบอกน้ำเก็บอุณหภูมิ',
      'price': 890,
      'imageUrl': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=500',
      'count': 0,
    },
  ];

  // คำนวณจำนวนสินค้าทั้งหมด
  int get _totalItems => _products.fold(0, (sum, item) => sum + (item['count'] as int));

  // คำนวณราคารวมทั้งหมด
  int get _totalPrice => _products.fold(0, (sum, item) {
    return sum + ((item['price'] as int) * (item['count'] as int));
  });

  void _addCart(int index) {
    setState(() {
      _products[index]['count']++;
    });
  }

  void _removeCart(int index) {
    setState(() {
      if (_products[index]['count'] > 0) {
        _products[index]['count']--;
      }
    });
  }

  // ฟังก์ชันแสดงหน้าต่างสรุปรายการสั่งซื้อ
  void _showOrderSummary() {
    final selectedItems = _products.where((p) => p['count'] > 0).toList();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "สรุปรายการสั่งซื้อ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              if (selectedItems.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text("ยังไม่มีสินค้าในรถเข็น")),
                )
              else
                ...selectedItems.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item['name']} x${item['count']}"),
                          Text("฿${item['price'] * item['count']}"),
                        ],
                      ),
                    )),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ยอดชำระทั้งสิ้น",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "฿$_totalPrice",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedItems.isEmpty ? null : () {
                    // จัดการการชำระเงินที่นี่
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("ยืนยันการสั่งซื้อ", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                onPressed: () => Navigator.pop(context), // คำสั่งย้อนกลับ
              ),
                const Text(
                  "รายการสินค้า",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: _showOrderSummary,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.shopping_cart, color: Colors.blue, size: 26),
                      ),
                      if (_totalItems > 0)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '$_totalItems',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),

            // Item List
            ...List.generate(_products.length, (index) {
              final product = _products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product['imageUrl'],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 70, height: 70, color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text("฿${product['price']}", style: TextStyle(color: Colors.blueGrey[600], fontSize: 14)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (product['count'] > 0) ...[
                          IconButton(
                            onPressed: () => _removeCart(index),
                            icon: const Icon(Icons.remove_circle_outline, size: 22),
                            color: Colors.grey,
                          ),
                          Text("${product['count']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        IconButton(
                          onPressed: () => _addCart(index),
                          icon: const Icon(Icons.add_circle, size: 28),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}