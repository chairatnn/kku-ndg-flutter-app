import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // เพิ่มตัวนี้
import 'dart:convert'; // เพิ่มตัวนี้เพื่อถอดรหัส JSON

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  String _cityName = "โปรดระบุเมือง";
  String _temp = "--";
  String _condition = "รอการค้นหา";
  IconData _weatherIcon = Icons.cloud_outlined;
  bool _isLoading = false; // สำหรับแสดงสถานะการโหลด

  // ฟังก์ชันดึงข้อมูลจริงจาก API
  Future<void> _fetchWeather(String city) async {
    setState(() => _isLoading = true);
    
    // 💡 แทนที่ 'YOUR_API_KEY_HERE' ด้วย Key ของคุณ
    const apiKey = 'c133131c5c78ab9ae9f7c1f5543d2884'; 
    final url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
    'q': city,
    'appid': apiKey,
    'units': 'metric',
    'lang': 'th',
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _cityName = data['name'];
          _temp = data['main']['temp'].toStringAsFixed(0);
          _condition = data['weather'][0]['description'];
          
          // เปลี่ยนไอคอนตามสภาพอากาศจริง
          String mainCondition = data['weather'][0]['main'];
          if (mainCondition == 'Clouds') _weatherIcon = Icons.cloud;
          else if (mainCondition == 'Clear') _weatherIcon = Icons.wb_sunny;
          else if (mainCondition == 'Rain') _weatherIcon = Icons.beach_access;
          else _weatherIcon = Icons.cloud_queue;
        });
      } else {
        _showSnackBar("ไม่พบข้อมูลเมืองนี้");
      }
    } catch (e) {
      _showSnackBar("การเชื่อมต่อผิดพลาด");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _searchWeather() {
    String inputCity = _cityController.text.trim();
    if (inputCity.isEmpty) {
      _showSnackBar("โปรดระบุชื่อเมือง");
      return;
    }
    _fetchWeather(inputCity); // เรียกฟังก์ชันดึงข้อมูลจริง
  }

  @override
  Widget build(BuildContext context) {
    const slatePrimary = Color(0xFF1E293B);
    const skyBlue = Color(0xFF38BDF8);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("KKU-NDG Real-time Weather", style: TextStyle(color: Colors.white)),
        backgroundColor: slatePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: "ระบุชื่อเมือง (เช่น London, Pattaya)",
                          prefixIcon: const Icon(Icons.location_city_rounded, color: skyBlue),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _searchWeather,
                        style: ElevatedButton.styleFrom(backgroundColor: slatePrimary, minimumSize: const Size(double.infinity, 50)),
                        child: _isLoading 
                          ? const CircularProgressIndicator(color: Colors.white) 
                          : const Text("ค้นหาเรียลไทม์", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // ส่วนแสดงผล
              Card(
                color: slatePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(_cityName, style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_weatherIcon, size: 80, color: skyBlue),
                          const SizedBox(width: 20),
                          Text("$_temp°C", style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(_condition, style: const TextStyle(fontSize: 22, color: Colors.white70)),
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