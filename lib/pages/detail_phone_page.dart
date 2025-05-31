import 'package:flutter/material.dart';
import '../models/phone_model.dart';


class DetailPhonePage extends StatelessWidget {
  final Data data;
  const DetailPhonePage({super.key, required this.data});

  Widget infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 226, 242), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Phone Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (data.imgUrl != null && data.imgUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    data.imgUrl!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 183, 183, 183),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.phone_android,
                        size: 60, color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                data.model ?? '-',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              infoText("Brand", data.brand ?? '-'),
              infoText("Price", '${data.price ?? '-'} USD'),
              infoText("RAM", '${data.ram ?? ''}GB'),
              infoText("Storage", '${data.storage ?? ''}GB'),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Phone Website'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
