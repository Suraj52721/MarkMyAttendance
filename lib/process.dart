import 'package:attendance_manager/provider.dart';
import 'package:flutter/material.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: ProviderPage().finalValidation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == 'true') {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.green, size: 100),
                      Text('Attendance Marked', style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (snapshot.data == 'Time Over') {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                        size: 100,
                      ),
                      Text('Time Over', style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (snapshot.data == 'Out of Range') {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                        size: 100,
                      ),
                      Text('Out of Range', style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (snapshot.data == 'Wrong Device') {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                        size: 100,
                      ),
                      Text('Wrong Device', style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                        size: 100,
                      ),
                      Text('Error', style: TextStyle(fontSize: 20)),
                    ],
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
