import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final TextEditingController _moodController = TextEditingController();

  // Add a mood to Firestore
  Future<void> _addMood() async {
    if (_moodController.text.isEmpty) return;
    await FirebaseFirestore.instance.collection('moods').add({
      'mood': _moodController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    _moodController.clear();
  }

  // Edit a mood in Firestore
  Future<void> _editMood(String documentId) async {
    final String? editedMood = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editController = TextEditingController();
        return AlertDialog(
          title: Text('Edit Mood'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(labelText: 'What\'s your mood?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // Cancel editing
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, editController.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    // If a mood was edited, update Firestore
    if (editedMood != null && editedMood.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('moods')
          .doc(documentId)
          .update({
        'mood': editedMood,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  // Delete a mood from Firestore
  Future<void> _deleteMood(String documentId) async {
    await FirebaseFirestore.instance
        .collection('moods')
        .doc(documentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalized Mood Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField to add a new mood
            TextField(
              controller: _moodController,
              decoration: InputDecoration(
                labelText: 'What\'s your mood?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mood),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMood,
              child: Text('Add Mood'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Display moods in a list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('moods')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No moods recorded yet.'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text(doc['mood']),
                        subtitle: Text(
                          doc['timestamp'] != null
                              ? (doc['timestamp'] as Timestamp)
                                  .toDate()
                                  .toString()
                              : 'Unknown time',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Icon(Icons.mood),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit button
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editMood(doc.id),
                            ),
                            // Delete button
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteMood(doc.id),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final TextEditingController _moodController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add a mood to Firestore
  Future<void> _addMood() async {
    if (_moodController.text.isEmpty) return;

    // Get the current user's UID
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      // If no user is logged in, return early
      return;
    }

    await FirebaseFirestore.instance.collection('moods').add({
      'userId': userId, // Add userId to the document
      'mood': _moodController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _moodController.clear();
  }

  // Edit a mood in Firestore
  Future<void> _editMood(String documentId) async {
    final String? editedMood = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editController = TextEditingController();
        return AlertDialog(
          title: Text('Edit Mood'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(labelText: 'What\'s your mood?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // Cancel editing
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, editController.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    // If a mood was edited, update Firestore
    if (editedMood != null && editedMood.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('moods')
          .doc(documentId)
          .update({
        'mood': editedMood,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  // Delete a mood from Firestore
  Future<void> _deleteMood(String documentId) async {
    await FirebaseFirestore.instance.collection('moods').doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalized Mood Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField to add a new mood
            TextField(
              controller: _moodController,
              decoration: InputDecoration(
                labelText: 'What\'s your mood?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mood),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMood,
              child: Text('Add Mood'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Display moods in a list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('moods')
                    .where('userId', isEqualTo: _auth.currentUser?.uid)  // Filter by userId
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No moods recorded yet.'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text(doc['mood']),
                        subtitle: Text(
                          doc['timestamp'] != null
                              ? (doc['timestamp'] as Timestamp)
                                  .toDate()
                                  .toString()
                              : 'Unknown time',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Icon(Icons.mood),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit button
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editMood(doc.id),
                            ),
                            // Delete button
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteMood(doc.id),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/






/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final TextEditingController _moodController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add a mood to Firestore
 Future<void> _addMood() async {
  if (_moodController.text.isEmpty) return;

  // Get the current user's UID
  String? userId = _auth.currentUser?.uid;
  if (userId == null) {
    // If no user is logged in, return early
    print("No user logged in!");
    return;
  }

  try {
    await FirebaseFirestore.instance.collection('moods').add({
      'userId': userId, // Add userId to the document
      'mood': _moodController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    print("Mood added successfully!");
  } catch (e) {
    print("Error adding mood: $e");
  }

  _moodController.clear();
}

  // Edit a mood in Firestore
  Future<void> _editMood(String documentId) async {
    final String? editedMood = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editController = TextEditingController();
        return AlertDialog(
          title: Text('Edit Mood'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(labelText: 'What\'s your mood?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // Cancel editing
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, editController.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    // If a mood was edited, update Firestore
    if (editedMood != null && editedMood.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('moods')
          .doc(documentId)
          .update({
        'mood': editedMood,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  // Delete a mood from Firestore
  Future<void> _deleteMood(String documentId) async {
    await FirebaseFirestore.instance.collection('moods').doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalized Mood Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField to add a new mood
            TextField(
              controller: _moodController,
              decoration: InputDecoration(
                labelText: 'What\'s your mood?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mood),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMood,
              child: Text('Add Mood'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Display moods in a list
           Expanded(
  child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('moods')
        .where('userId', isEqualTo: _auth.currentUser?.uid)  // Filter by userId
        .orderBy('timestamp', descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text('No moods recorded yet.'));
      }

      return ListView(
        children: snapshot.data!.docs.map((doc) {
          return ListTile(
            title: Text(doc['mood']),
            subtitle: Text(
              doc['timestamp'] != null
                  ? (doc['timestamp'] as Timestamp)
                      .toDate()
                      .toString()
                  : 'Unknown time',
              style: TextStyle(fontSize: 12),
            ),
            leading: Icon(Icons.mood),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editMood(doc.id),
                ),
                // Delete button
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteMood(doc.id),
                ),
              ],
            ),
          );
        }).toList(),
      );
    },
  ),
),
 ],
        ),
      ),
    );
  }
}
*/




