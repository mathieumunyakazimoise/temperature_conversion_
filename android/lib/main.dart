import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  const TemperatureConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConversionPage(),
    );
  }
}

class TemperatureConversionPage extends StatefulWidget {
  const TemperatureConversionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConversionPageState createState() =>
      _TemperatureConversionPageState();
}

class _TemperatureConversionPageState extends State<TemperatureConversionPage> {
  String _conversionType = 'F to C';
  double _initialTemperature = 0.0;
  double _convertedTemperature = 0.0;
  final List<String> _conversionHistory = [];

  void _convertTemperature() {
    setState(() {
      if (_conversionType == 'F to C') {
        _convertedTemperature = (_initialTemperature - 32) * 5 / 9;
        _conversionHistory.add(
            'F to C: $_initialTemperature => ${_convertedTemperature.toStringAsFixed(2)}');
      } else {
        _convertedTemperature = (_initialTemperature * 9 / 5) + 32;
        _conversionHistory.add(
            'C to F: $_initialTemperature => ${_convertedTemperature.toStringAsFixed(2)}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Conversion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'F to C',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                const Text('Fahrenheit to Celsius'),
                Radio(
                  value: 'C to F',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                const Text('Celsius to Fahrenheit'),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _initialTemperature = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Converted Temperature: ${_convertedTemperature.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
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