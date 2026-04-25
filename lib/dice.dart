import 'package:flutter/material.dart';
import 'dart:math';

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  List<int> diceNumbers = [1, 1];
  int diceCount = 2;
  bool _isRolling = false;

  // --- ส่วนที่เพิ่ม: รายการเก็บ Log ---
  List<String> rollLogs = [];

  Future<void> rollDice(int index) async {
    if (_isRolling) return;

    setState(() => _isRolling = true);

    // --- ส่วนที่ปรับปรุง: เงื่อนไขการระบุตำแหน่งตามจำนวนลูกเต๋า ---
    String position = "";
    if (diceCount == 1) {
      position = "Middle";
    } else if (diceCount == 2) {
      position = index == 0 ? "Left" : "Right";
    } else if (diceCount == 3) {
      // สำหรับกรณี 3 ลูก (แถมให้)
      position = index == 0
          ? "Left"
          : index == 1
          ? "Middle"
          : "Right";
    }

    // Animation การทอยสุ่ม
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 60));
      setState(() {
        diceNumbers[index] = Random().nextInt(6) + 1;
      });
    }

    // บันทึก Log เมื่อหยุดที่แต้มสุดท้าย
    setState(() {
      _isRolling = false;
      String timestamp =
          "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
      rollLogs.insert(
        0,
        "[$timestamp] $position: ได้แต้ม ${diceNumbers[index]}",
      );
    });
  }

  void updateDiceCount(int count) {
    setState(() {
      diceCount = count;
      diceNumbers = List.generate(count, (index) => 1);
      rollLogs.clear(); // ล้าง log เมื่อเปลี่ยนจำนวนลูกเต๋า
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      appBar: AppBar(
        title: const Text(
          'Dice Roller Pro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'แตะที่ลูกเต๋าเพื่อทอย',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),

          // --- ส่วนลูกเต๋า (ปรับขนาดให้เล็กลง) ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: List.generate(diceCount, (index) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 100,
                  ), // จำกัดขนาดความกว้าง
                  child: InkWell(
                    onTap: () => rollDice(index),
                    child: DiceWidget(number: diceNumbers[index]),
                  ),
                );
              }),
            ),
          ),

          // --- ส่วนแสดง Log ---
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.history, color: Colors.white70, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Rolling Log",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rollLogs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            rollLogs[index],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- ส่วนเลือกจำนวนลูกเต๋า ---
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3].map((num) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text('$num ลูก'),
                    selected: diceCount == num,
                    onSelected: (_) => updateDiceCount(num),
                    selectedColor: Colors.yellow[700],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DiceWidget extends StatelessWidget {
  final int number;
  const DiceWidget({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(9, (index) {
            bool hasDot = false;
            switch (number) {
              case 1:
                if (index == 4) hasDot = true;
                break;
              case 2:
                if (index == 2 || index == 6) hasDot = true;
                break;
              case 3:
                if (index == 2 || index == 4 || index == 6) hasDot = true;
                break;
              case 4:
                if ([0, 2, 6, 8].contains(index)) hasDot = true;
                break;
              case 5:
                if ([0, 2, 4, 6, 8].contains(index)) hasDot = true;
                break;
              case 6:
                if ([0, 2, 3, 5, 6, 8].contains(index)) hasDot = true;
                break;
            }
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasDot ? Colors.black87 : Colors.transparent,
              ),
            );
          }),
        ),
      ),
    );
  }
}
