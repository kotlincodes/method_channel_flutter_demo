import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NativeIntegrationDemo(),
    );
  }
}

class NativeIntegrationDemo extends StatefulWidget {
  const NativeIntegrationDemo({super.key});

  @override
   createState() => _NativeIntegrationDemoState();
}

class _NativeIntegrationDemoState extends State<NativeIntegrationDemo> {
  static const platform = MethodChannel('com.example.native_integration_demo/native');

  String _nativeMessage = 'Waiting for native response...';

  Future<void> _getNativeMessage() async {
    String message;
    try {
      message = await platform.invokeMethod('getNativeMessage');
    } on PlatformException catch (e) {
      message = "Failed to get native message: '${e.message}'";
    }

    setState(() {
      _nativeMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Integration Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_nativeMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getNativeMessage,
              child: const Text('Get Native Message'),
            ),
          ],
        ),
      ),
    );
  }
}