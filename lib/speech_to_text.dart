import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(SpeechToTextApp());

class SpeechToTextApp extends StatelessWidget {
  const SpeechToTextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeechToTextPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  _SpeechToTextPage createState() => _SpeechToTextPage();
}

class _SpeechToTextPage extends State<SpeechToTextPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Tap the mic to speak';
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
          onStatus: (val) => print('Status: $val'),
          onError: (val) => print('Error: $val'));
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                }));
      } else {
        setState(() {
          _isListening = false;
          _speech.stop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice to text App'),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        reverse: true,
        child: Text(
          _text,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _listen();
        },
        backgroundColor: _isListening ? Colors.yellow : Colors.blue,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}
