import 'package:flutter/material.dart';

class FormsValidationPage extends StatefulWidget {
  const FormsValidationPage({super.key});

  @override
  State<FormsValidationPage> createState() => _FormsValidationPageState();
}

class _FormsValidationPageState extends State<FormsValidationPage> {
  // --- Controllers สำหรับ Form Validation ---
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  // --- Controller สำหรับ Unit Converter ---
  final _cmController = TextEditingController();
  double _mResult = 0;

  // --- Controllers สำหรับ BMI ---
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _bmiResult = "";
  String _bmiStatus = "";

  // --- Controller สำหรับ Thai ID ---
  final _idController = TextEditingController();
  String _idMessage = "";

  @override
  void dispose() {
    // ล้าง Memory ทุกครั้งเมื่อออกจากหน้า (ตามโจทย์สั่ง)
    _userController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _cmController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _idController.dispose();
    super.dispose();
  }

  // ฟังก์ชันคำนวณ Check Digit บัตรประชาชนไทย
  bool _verifyThaiID(String id) {
    if (id.length != 13) return false;
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(id[i]) * (13 - i);
    }
    int checkDigit = (11 - (sum % 11)) % 10;
    return checkDigit == int.parse(id[12]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form & Validation Lab")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- ส่วนที่ 1: User Registration ---
            _buildSection(
              title: "1. Login / Register Validation",
              child: Column(
                children: [
                  TextField(
                    controller: _userController,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password (6+ chars)",
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text;
                      String pass = _passController.text;
                      if (email.isEmpty || pass.isEmpty) {
                        _showMsg("กรุณากรอกข้อมูลให้ครบ");
                      } else if (!email.contains('@')) {
                        _showMsg("Email ต้องมีสัญลักษณ์ @");
                      } else if (pass.length < 6) {
                        _showMsg("Password ต้องมีอย่างน้อย 6 ตัว");
                      } else {
                        _showDialogResult(
                          "Login Success",
                          "Email: $email\nPassword: $pass",
                        );
                      }
                    },
                    child: const Text("Submit & Show Dialog"),
                  ),
                ],
              ),
            ),

            // --- ส่วนที่ 2: CM to M Converter ---
            _buildSection(
              title: "2. CM to Meter Converter",
              child: Column(
                children: [
                  TextField(
                    controller: _cmController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Centimeters (cm)",
                      hintText: "กรอกเฉพาะตัวเลข",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Result: ${_mResult.toStringAsFixed(2)} m",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double? cm = double.tryParse(_cmController.text);
                      if (cm == null) {
                        _showMsg("กรุณากรอกเฉพาะตัวเลข");
                      } else {
                        setState(() => _mResult = cm / 100);
                      }
                    },
                    child: const Text("Convert"),
                  ),
                ],
              ),
            ),

            // --- ส่วนที่ 3: BMI Calculator ---
            _buildSection(
              title: "3. BMI Calculator",
              child: Column(
                children: [
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Weight (kg)",
                      hintText: "เช่น 45",
                    ),
                  ),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Height (cm)",
                      hintText: "เช่น 170",
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_bmiResult.isNotEmpty)
                    Text(
                      "BMI: $_bmiResult ($_bmiStatus)",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      double? w = double.tryParse(_weightController.text);
                      double? h = double.tryParse(_heightController.text);
                      if (w == null || h == null) {
                        _showMsg("กรุณากรอกตัวเลขทั้งน้ำหนักและส่วนสูง");
                      } else {
                        // double bmi = w / (h * h);
                        double heightInMeters = h / 100; // แปลง cm เป็น m
                        double bmi = w / (heightInMeters * heightInMeters);
                        String status = "";
                        if (bmi < 18.5)
                          status = "Underweight";
                        else if (bmi < 25)
                          status = "Normal weight";
                        else if (bmi < 30)
                          status = "Overweight";
                        else
                          status = "Obesity";
                        setState(() {
                          _bmiResult = bmi.toStringAsFixed(2);
                          _bmiStatus = status;
                        });
                      }
                    },
                    child: const Text("Calculate BMI"),
                  ),
                ],
              ),
            ),

            // --- ส่วนที่ 4: Thai ID Validation ---
            _buildSection(
              title: "4. Thai ID Check",
              child: Column(
                children: [
                  TextField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    decoration: const InputDecoration(
                      labelText: "เลขบัตรประชาชน 13 หลัก",
                    ),
                  ),
                  Text(
                    _idMessage,
                    style: TextStyle(
                      color: _idMessage.contains("ถูกต้อง")
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String id = _idController.text;
                      if (RegExp(r'^[0-9]{13}$').hasMatch(id)) {
                        if (_verifyThaiID(id)) {
                          setState(() => _idMessage = "หมายเลขบัตรถูกต้อง ✅");
                        } else {
                          setState(
                            () => _idMessage =
                                "หมายเลขบัตรไม่ถูกต้อง (Check Digit ผิด) ❌",
                          );
                        }
                      } else {
                        setState(
                          () => _idMessage = "กรุณากรอกตัวเลขให้ครบ 13 หลัก",
                        );
                      }
                    },
                    child: const Text("Validate ID"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Helper Methods ---
  Widget _buildSection({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }

  // void _showMsg(String msg) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ), // เปลี่ยนสีตัวอักษรเป็นสีขาว
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior
            .floating, // แนะนำให้ใช้ floating เพื่อความสวยงาม (ไม่ติดขอบจอเกินไป)
        duration: const Duration(seconds: 2), // แสดงผล 2 วินาที
      ),
    );
  }

  void _showDialogResult(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
