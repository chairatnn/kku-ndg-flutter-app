import 'package:flutter/material.dart';

// 1. สร้าง Model สำหรับเก็บข้อมูล Comment
class CommentData {
  final String userName;
  final String content;
  int likeCount;
  int loveCount;

  CommentData({
    required this.userName,
    required this.content,
    this.likeCount = 0,
    this.loveCount = 0,
  });
}

class CommentListScreen extends StatelessWidget {
  const CommentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. สร้างรายการข้อมูล (Mock Data)
    final List<CommentData> comments = [
      CommentData(userName: "ผู้ใช้งาน Flutter", content: "ชอบกด Like ใช่กด Love"),
      CommentData(userName: "ผู้ใช้งาน Frontend", content: "ชอบ Like ใช่ Love"),
      CommentData(userName: "ผู้ใช้งาน Backend", content: "มี Like มี Love"),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          // 3. ส่งข้อมูลแต่ละก้อนไปแสดงผลที่ Item Widget
          return IndividualCommentWidget(data: comments[index]);
        },
      ),
    );
  }
}

// 4. แยก Widget สำหรับแต่ละ Comment เพื่อแยก State
class IndividualCommentWidget extends StatefulWidget {
  final CommentData data;
  const IndividualCommentWidget({super.key, required this.data});

  @override
  State<IndividualCommentWidget> createState() => _IndividualCommentWidgetState();
}

class _IndividualCommentWidgetState extends State<IndividualCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.data.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.data.content,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(
                  icon: Icons.thumb_up,
                  color: Colors.blue,
                  count: widget.data.likeCount,
                  onTap: () => setState(() => widget.data.likeCount++),
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  icon: Icons.favorite,
                  color: Colors.red,
                  count: widget.data.loveCount,
                  onTap: () => setState(() => widget.data.loveCount++),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method สำหรับสร้างปุ่ม จะได้ไม่ต้องเขียน Code ซ้ำซ้อน
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(onPressed: onTap, icon: Icon(icon, color: color)),
        Text("$count", style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}