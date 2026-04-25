import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class MovieWidget extends StatefulWidget {
  const MovieWidget({super.key});

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> with WidgetsBindingObserver {
  bool _isWatching = false;
  
  // ตั้งค่าเวลาเช่าเริ่มต้น (24 ชั่วโมง)
  final int rentalDurationHours = 24;

  final List<Map<String, dynamic>> _movies = [
    {
      'id': 'm1',
      'name': 'Shutterstock',
      'price': 29,
      'imageUrl': 'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=500',
      'videoUrl': 'https://www.shutterstock.com/video/search/technology',
      'platform': 'Shutterstock',
      'isPurchased': false,
      'purchasedAt': null,
    },
    {
      'id': 'm2',
      'name': 'YouTube',
      'price': 39,
      'imageUrl': 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=500',
      'videoUrl': 'https://www.youtube.com/shorts/36U4Y_A9O-8',
      'platform': 'YouTube',
      'isPurchased': false,
      'purchasedAt': null,
    },
    {
      'id': 'm3',
      'name': 'TikTok',
      'price': 49,
      'imageUrl': 'https://images.unsplash.com/photo-1611605698335-8b1569810432?q=80&w=500',
      'videoUrl': 'https://www.tiktok.com/explore',
      'platform': 'TikTok',
      'isPurchased': false,
      'purchasedAt': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkRentalExpiry();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkRentalExpiry();
      if (_isWatching) {
        setState(() {
          _isWatching = false;
        });
        _showBackMessage();
      }
    }
  }

  void _checkRentalExpiry() {
    final now = DateTime.now();
    bool stateChanged = false;

    setState(() {
      for (var movie in _movies) {
        if (movie['isPurchased'] && movie['purchasedAt'] != null) {
          final expiryTime = movie['purchasedAt'].add(Duration(hours: rentalDurationHours));
          if (now.isAfter(expiryTime)) {
            movie['isPurchased'] = false;
            movie['purchasedAt'] = null;
            stateChanged = true;
          }
        }
      }
    });

    if (stateChanged && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('รายการที่เช่าไว้หมดอายุแล้ว'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _showBackMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('กลับมาแล้ว! เลือกดูคลิปอื่นต่อได้เลย'),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showConfirmPurchase(int index) {
    final movie = _movies[index];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("ยืนยันการเช่า", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(movie['imageUrl'], width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(movie['name']),
              subtitle: Text("ราคา ฿${movie['price']} (ดูได้นาน $rentalDurationHours ชม.)"),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _movies[index]['isPurchased'] = true;
                    _movies[index]['purchasedAt'] = DateTime.now();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('เช่าสำเร็จ! กดเปิดดูคลิปได้เลย'), backgroundColor: Colors.green),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // แก้ไขจาก primary
                  foregroundColor: Colors.white, // แก้ไขจาก onPrimary
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("ยืนยันชำระเงิน", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Future<void> _launchVideo(String url) async {
    final Uri uri = Uri.parse(url);
    setState(() {
      _isWatching = true; 
    });
    
    if (!await launchUrl(
      uri, 
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    )) {
      setState(() {
        _isWatching = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่สามารถเปิดลิงก์ได้')),
        );
      }
    }
  }

  String _getTimeLeft(DateTime? purchasedAt) {
    if (purchasedAt == null) return "";
    final expiry = purchasedAt.add(Duration(hours: rentalDurationHours));
    final diff = expiry.difference(DateTime.now());
    if (diff.isNegative) return "หมดอายุ";
    return "${diff.inHours}ชม. ${diff.inMinutes % 60}นาที";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Short Video Store", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _movies.length,
        itemBuilder: (context, index) => _buildVideoItem(index),
      ),
    );
  }

  Widget _buildVideoItem(int index) {
    final movie = _movies[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(movie['imageUrl'], height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie['name'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      if (movie['isPurchased'])
                        Text("เวลาที่เหลือ: ${_getTimeLeft(movie['purchasedAt'])}", 
                             style: const TextStyle(color: Colors.green, fontSize: 13))
                      else
                        Text("฿${movie['price']} / $rentalDurationHours ชม.", 
                             style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                movie['isPurchased']
                    ? ElevatedButton.icon(
                        onPressed: () => _launchVideo(movie['videoUrl']),
                        icon: const Icon(Icons.open_in_new, size: 18),
                        label: const Text("เปิดดูคลิป (Link)"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700, // แก้ไขจาก primary
                          foregroundColor: Colors.white, // แก้ไขจาก onPrimary
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () => _showConfirmPurchase(index),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("เช่าดู"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo, // แก้ไขจาก primary
                          foregroundColor: Colors.white, // แก้ไขจาก onPrimary
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}