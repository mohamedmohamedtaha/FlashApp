import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(FlashLightApp());
}

class FlashLightApp extends StatefulWidget {
  const FlashLightApp({super.key});

  @override
  _FlashLightAppState createState() => _FlashLightAppState();
}

class _FlashLightAppState extends State<FlashLightApp> {
  bool isOn = false;
  Future<void> toggleFlashLight() async {
    try {
      if (isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isOn = !isOn;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: isOn ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text('Flash Light'),
          backgroundColor: isOn ? Colors.green : Colors.blue,
        ),
        body: Center(
          child: IconButton(
              iconSize: 120,
              onPressed: () async {
                await toggleFlashLight();
              },
              icon: Icon(isOn ? Icons.flashlight_on : Icons.flashlight_off)),
        ),
      ),
    );
  }
}
