import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class PianoPage extends StatefulWidget {
  const PianoPage({super.key});

  @override
  State<PianoPage> createState() => _PianoPageState();
}

class _PianoPageState extends State<PianoPage> {
  String? _activeNote; 
  bool _isPlayingDemo = false;

  // ฟังก์ชันเล่นเสียงโน้ต (เช็คไฟล์ก่อนเล่นเพื่อป้องกัน Error)
  Future<void> _playNote(String fileName) async {
    try {
      if (mounted) {
        setState(() => _activeNote = fileName);
      }
      
      final player = AudioPlayer();
      
      await player.setAudioContext(AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
        ),
      ));

      // เล่นเฉพาะไฟล์ที่มีอยู่ใน assets/audio/ (c1 - c2)
      await player.play(AssetSource('audio/$fileName'));
      
      Timer(const Duration(milliseconds: 300), () {
        if (mounted && _activeNote == fileName) {
          setState(() => _activeNote = null);
        }
      });

      player.onPlayerComplete.listen((_) => player.dispose());
    } catch (e) {
      debugPrint('ไม่สามารถเล่นไฟล์ $fileName ได้: $e');
    }
  }

  // ปรับโน้ตใหม่ให้ใช้เฉพาะ c1.wav ถึง c2.wav เท่านั้น
  Future<void> _playYoursEverDemo() async {
    if (_isPlayingDemo) return;
    setState(() => _isPlayingDemo = true);

    // [โน้ต, ระยะเวลารอ] - ปรับ Transpose ลงมาให้อยู่ในระยะคีย์ที่มี
    final List<List<dynamic>> songData = [
      // "จะ-รัก-เธอ" (c1-d1-e1)
      ['c1.wav', 500], ['d1.wav', 500], ['e1.wav', 800], 
      // "ไป-ชั่ว-นิ-รันดร์" (e1-d1-c1-b1)
      ['e1.wav', 400], ['d1.wav', 400], ['c1.wav', 400], ['b1.wav', 1000],
      
      // "จะ-ขอ-ประ-ครอง" (a1-b1-c2)
      ['a1.wav', 500], ['b1.wav', 500], ['c2.wav', 800],
      // "เธอ-ไว้-ด้วย-รัก" (c2-b1-a1-g1)
      ['c2.wav', 400], ['b1.wav', 400], ['a1.wav', 400], ['g1.wav', 1000],

      // "แม้-วัน-ที่-ฟ้า" (c1-d1-e1)
      ['c1.wav', 500], ['d1.wav', 500], ['e1.wav', 800],
      // "มืด-มน-และ-หนาว-สั่น" (f1-e1-d1-c1)
      ['f1.wav', 400], ['e1.wav', 400], ['d1.wav', 400], ['c1.wav', 1000],

      // "จะ-ยัง-มี-ฉัน" (f1-g1-a1)
      ['f1.wav', 500], ['g1.wav', 500], ['a1.wav', 800],
      // "อยู่-ข้าง-กาย-เธอ-เสมอไป" (b1-c2-b1-a1-g1)
      ['b1.wav', 400], ['c2.wav', 400], ['b1.wav', 400], ['a1.wav', 400], ['g1.wav', 1200],
    ];

    for (var note in songData) {
      if (!mounted || !_isPlayingDemo) break;
      await _playNote(note[0]);
      await Future.delayed(Duration(milliseconds: note[1]));
    }

    if (mounted) setState(() => _isPlayingDemo = false);
  }

  Widget _buildKey({
    required String fileName,
    required Color color,
    required String label,
    bool isSharp = false,
  }) {
    bool isActive = _activeNote == fileName;
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _playNote(fileName),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: isSharp ? 140 : 250,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive 
                ? (isSharp ? Colors.blue[900] : Colors.blue[100]) 
                : color,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(label, style: TextStyle(color: color == Colors.white ? Colors.black54 : Colors.white70, fontSize: 10)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Piano - Yours Ever (Fixed)'),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _isPlayingDemo ? () => setState(() => _isPlayingDemo = false) : _playYoursEverDemo,
              icon: Icon(_isPlayingDemo ? Icons.stop : Icons.play_arrow),
              label: Text(_isPlayingDemo ? 'หยุด' : 'เล่น Demo'),
              style: ElevatedButton.styleFrom(backgroundColor: _isPlayingDemo ? Colors.red : Colors.blue),
            ),
          )
        ],
        // เพิ่มบรรทัดนี้เพื่อกำหนดสีปุ่มย้อนกลับและไอคอนอื่นๆ ใน AppBar
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Yours Ever - Cocktail", style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 50),
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Row(
                  children: [
                    _buildKey(fileName: 'c1.wav', color: Colors.white, label: 'C'),
                    _buildKey(fileName: 'd1.wav', color: Colors.white, label: 'D'),
                    _buildKey(fileName: 'e1.wav', color: Colors.white, label: 'E'),
                    _buildKey(fileName: 'f1.wav', color: Colors.white, label: 'F'),
                    _buildKey(fileName: 'g1.wav', color: Colors.white, label: 'G'),
                    _buildKey(fileName: 'a1.wav', color: Colors.white, label: 'A'),
                    _buildKey(fileName: 'b1.wav', color: Colors.white, label: 'B'),
                    _buildKey(fileName: 'c2.wav', color: Colors.white, label: 'C2'),
                  ],
                ),
                Positioned(
                  left: 35, top: 0, right: 35,
                  child: Row(
                    children: [
                      _buildKey(fileName: 'c1s.wav', color: Colors.black, label: 'C#', isSharp: true),
                      const Spacer(),
                      _buildKey(fileName: 'd1s.wav', color: Colors.black, label: 'D#', isSharp: true),
                      const SizedBox(width: 80),
                      _buildKey(fileName: 'f1s.wav', color: Colors.black, label: 'F#', isSharp: true),
                      const Spacer(),
                      _buildKey(fileName: 'g1s.wav', color: Colors.black, label: 'G#', isSharp: true),
                      const Spacer(),
                      _buildKey(fileName: 'a1s.wav', color: Colors.black, label: 'A#', isSharp: true),
                    ],
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