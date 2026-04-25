import 'package:flutter/material.dart';

class LoveClick extends StatefulWidget {
  const LoveClick({super.key});

  @override
  State<LoveClick> createState() => _LoveClickState();
}

class _LoveClickState extends State<LoveClick> {
  int _loveCount = 0;
  bool _isActive = false; // สถานะเริ่มต้นเป็น OFF (false)

  // ฟังก์ชันสลับสถานะ ON/OFF
  void _toggleStatus() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  void _incrementLove() {
    if (_isActive) { // เช็คก่อนว่าสถานะเป็น ON หรือไม่
      setState(() {
        _loveCount++;
      });
    }
  }

  void _resetLove() {
    if (_isActive) { // เช็คก่อนว่าสถานะเป็น ON หรือไม่
      setState(() {
        _loveCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Love Clicker Pro'),
        backgroundColor: _isActive ? Colors.pink[100] : Colors.grey[300],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ปุ่มสลับสถานะ ON / OFF
            ElevatedButton(
              onPressed: _toggleStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isActive ? Colors.green : Colors.red,
                foregroundColor: Colors.white,
                fixedSize: const Size(120, 50),
              ),
              child: Text(
                _isActive ? "ON" : "OFF",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 40),

            Icon(
              Icons.favorite,
              size: 120,
              color: _isActive 
                ? (_loveCount > 0 ? Colors.red : Colors.grey[400])
                : Colors.grey[200], // ถ้า OFF ให้สีจางลงมาก
            ),
            
            Text(
              '$_loveCount',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: _isActive ? Colors.pink : Colors.grey[300],
              ),
            ),
            
            const SizedBox(height: 40),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ปุ่มให้หัวใจ (จะกดได้ต่อเมื่อ _isActive เป็น true)
                ElevatedButton.icon(
                  onPressed: _isActive ? _incrementLove : null, // ถ้า OFF ส่งค่า null เพื่อ Disable ปุ่ม
                  icon: const Icon(Icons.favorite),
                  label: const Text('ให้หัวใจ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // ปุ่ม Reset (จะกดได้ต่อเมื่อ _isActive เป็น true)
                OutlinedButton.icon(
                  onPressed: _isActive ? _resetLove : null, // ถ้า OFF ส่งค่า null เพื่อ Disable ปุ่ม
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
            
            if (!_isActive) 
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("โปรดเปลี่ยนเป็น ON เพื่อใช้งาน", style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}