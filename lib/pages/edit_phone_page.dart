import 'package:flutter/material.dart';
import 'package:responsi/pages/phone_page.dart';
import '../models/phone_model.dart';
import '../services/phone_service.dart';

class EditPhonePage extends StatefulWidget {
  final Data data;

  const EditPhonePage({super.key, required this.data});

  @override
  State<EditPhonePage> createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late final TextEditingController _modelController;
  late final TextEditingController _brandController;
  late final TextEditingController _ramController;
  late final TextEditingController _priceController;
  late final TextEditingController _storageController;

  @override
  void initState() {
    super.initState();
    final d = widget.data;
    _modelController = TextEditingController(text: d.model ?? '');
    _brandController = TextEditingController(text: d.brand ?? '');
    _ramController = TextEditingController(text: d.ram?.toString() ?? '');
    _priceController = TextEditingController(text: d.price?.toString() ?? '');
    _storageController = TextEditingController(text: d.storage?.toString() ?? '');
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final ram = int.tryParse(_ramController.text.trim());
      final price = double.tryParse(_priceController.text.trim());
      final storage = int.tryParse(_storageController.text.trim());

      if (ram == null || price == null || storage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("RAM, Price, dan Storage harus berupa angka"),
            backgroundColor: Colors.red.shade600,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      final updated = Data(
        id: widget.data.id,
        model: _modelController.text.trim(),
        brand: _brandController.text.trim(),
        ram: ram,
        price: price,
        storage: storage,
      );

      try {
        print("Mengirim data update: ${updated.toJson()}");
        final response = await PhoneService.updatePhone(updated);

        if (response.status == "Success") {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Berhasil memperbarui smartphone"),
              backgroundColor: Colors.green.shade600,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PhonePage()),
          );
        } else {
          throw Exception(response.message ?? "Gagal memperbarui smartphone");
        }
      } catch (e) {
        print("Error saat update: $e");
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
        title: const Text("Edit Smartphone", style: TextStyle(fontWeight: FontWeight.w600)),
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
                  keyboardType: TextInputType.text,
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
                  keyboardType: TextInputType.number,
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
                            "Simpan",
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