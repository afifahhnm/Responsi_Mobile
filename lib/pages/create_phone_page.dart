import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import '../services/phone_service.dart';

class CreatePhonePage extends StatefulWidget {
  final Data? data;
  const CreatePhonePage({super.key, this.data});

  @override
  State<CreatePhonePage> createState() => _CreatePhonePageState();
}

class _CreatePhonePageState extends State<CreatePhonePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _ramController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _storageController = TextEditingController();

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final newPhone = Data(
        model: _modelController.text.trim(),
        brand: _brandController.text.trim(),
        ram: int.tryParse(_ramController.text.trim()),
        price: double.tryParse(_priceController.text.trim()),
        storage: int.tryParse(_storageController.text.trim()),
      );

      try {
        final response = await PhoneService.createPhone(newPhone);

        if (response.status == "Success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Berhasil menambah smartphone"),
              backgroundColor: Colors.green.shade600,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
          if (!mounted) return;
          Navigator.pop(context, true);
        } else {
          throw Exception(response.message ?? "Gagal menambah smartphone");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal: $e"),
            backgroundColor: Colors.red.shade600,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6F0),
      appBar: AppBar(
        title: const Text("Add New Phone", style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFE8C4D8),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE8C4D8).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _modelController,
                  decoration: InputDecoration(
                    labelText: "Model",
                    labelStyle: const TextStyle(color: Color(0xFF8B5A6B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD1A3B8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFB7839A), width: 2),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFDF8FB),
                  ),
                  validator: _required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _brandController,
                  decoration: InputDecoration(
                    labelText: "Brand",
                    labelStyle: const TextStyle(color: Color(0xFF8B5A6B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD1A3B8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFB7839A), width: 2),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFDF8FB),
                  ),
                  validator: _required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: const TextStyle(color: Color(0xFF8B5A6B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD1A3B8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFB7839A), width: 2),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFDF8FB),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ramController,
                  decoration: InputDecoration(
                    labelText: "RAM (GB)",
                    labelStyle: const TextStyle(color: Color(0xFF8B5A6B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD1A3B8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFB7839A), width: 2),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFDF8FB),
                  ),
                  keyboardType: TextInputType.number,
                  validator: _required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _storageController,
                  decoration: InputDecoration(
                    labelText: "Storage (GB)",
                    labelStyle: const TextStyle(color: Color(0xFF8B5A6B)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD1A3B8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFB7839A), width: 2),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFDF8FB),
                  ),
                  keyboardType: TextInputType.number,
                  validator: _required,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB7839A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Tambah",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}