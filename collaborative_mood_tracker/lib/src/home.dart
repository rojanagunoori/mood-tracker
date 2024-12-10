import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _moodController = TextEditingController();

  Future<void> _submitMood() async {
    if (_moodController.text.isNotEmpty) {
      await _firestore.collection('moods').add({
        'mood': _moodController.text,
        'timestamp': Timestamp.now(),
        'user': _auth.currentUser!.email,
      });
      _moodController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _moodController,
              decoration: InputDecoration(labelText: 'Enter your mood'),
            ),
          ),
          ElevatedButton(onPressed: _submitMood, child: Text('Submit Mood')),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('moods').orderBy('timestamp').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['mood']),
                      subtitle: Text('by ${doc['user']}'),
                      trailing: Text(doc['timestamp'].toDate().toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
