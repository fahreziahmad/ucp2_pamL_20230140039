import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../blocs/catalog/catalog_bloc.dart';
import '../../blocs/catalog/catalog_event.dart';
import '../../blocs/category/category_bloc.dart';
import '../../data/models/motor_model.dart';

class MotorFormScreen extends StatefulWidget {
  final MotorModel? motor;
  const MotorFormScreen({super.key, this.motor});

  @override
  State<MotorFormScreen> createState() => _MotorFormScreenState();
}

class _MotorFormScreenState extends State<MotorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  late TextEditingController _priceController;
  int? _selectedCategoryId;
  File? _imageFile;
  String? _existingImageUrl;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.motor?.name ?? '');
    _modelController = TextEditingController(text: widget.motor?.model ?? '');
    _yearController = TextEditingController(text: widget.motor?.year.toString() ?? '');
    _priceController = TextEditingController(text: widget.motor?.pricePerDay.toString() ?? '');
    _selectedCategoryId = widget.motor?.categoryId;
    _existingImageUrl = widget.motor?.imageUrl;
    context.read<CategoryBloc>().add(FetchCategories());
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _existingImageUrl = null; // Hapus pratinjau lama jika ada foto baru
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.motor != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Motor' : 'Tambah Motor Baru'),
        backgroundColor: const Color(0xFF1e3c72),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Motor', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Model/Tipe', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tahun Produksi', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty || int.tryParse(v) == null ? 'Masukkan tahun yang valid' : null,
              ),
              const SizedBox(height: 16),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  List<DropdownMenuItem<int>> items = [];
                  if (state is CategoryLoaded) {
                    items = state.categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList();
                  }
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedCategoryId,
                    decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                    items: items,
                    onChanged: (val) => setState(() => _selectedCategoryId = val),
                    validator: (v) => v == null ? 'Pilih kategori' : null,
                    hint: Text(state is CategoryLoading ? 'Memuat...' : 'Pilih Kategori'),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harga Sewa Per Hari', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty || double.tryParse(v) == null ? 'Masukkan harga yang valid' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1e3c72)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final motor = MotorModel(
                        id: widget.motor?.id ?? 0,
                        name: _nameController.text,
                        model: _modelController.text,
                        year: int.parse(_yearController.text),
                        categoryId: _selectedCategoryId,
                        pricePerDay: double.parse(_priceController.text),
                        status: 'available',
                        imageUrl: _imageFile?.path ?? _existingImageUrl,
                      );

                      if (isEditing) {
                        context.read<CatalogBloc>().add(UpdateMotor(motor));
                      } else {
                        context.read<CatalogBloc>().add(AddMotor(motor));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? 'SIMPAN PERUBAHAN' : 'TAMBAH MOTOR', style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    Widget? imagePreview;

    if (_imageFile != null) {
      imagePreview = Image.file(_imageFile!, fit: BoxFit.cover);
    } else if (_existingImageUrl != null && _existingImageUrl!.isNotEmpty) {
      if (_existingImageUrl!.startsWith('http')) {
        imagePreview = Image.network(_existingImageUrl!, fit: BoxFit.cover);
      } else {
        final cleanPath = _existingImageUrl!.replaceFirst('file://', '');
        imagePreview = Image.file(File(cleanPath), fit: BoxFit.cover);
      }
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(leading: const Icon(Icons.photo_library), title: const Text('Galeri'), onTap: () { _pickImage(ImageSource.gallery); Navigator.pop(context); }),
                ListTile(leading: const Icon(Icons.camera_alt), title: const Text('Kamera'), onTap: () { _pickImage(ImageSource.camera); Navigator.pop(context); }),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: imagePreview != null
            ? ClipRRect(borderRadius: BorderRadius.circular(15), child: imagePreview)
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Upload Foto Motor', style: TextStyle(color: Colors.grey)),
                ],
              ),
      ),
    );
  }
}
