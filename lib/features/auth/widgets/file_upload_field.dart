import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';

class FileUploadField extends StatefulWidget {
  final String label;
  final void Function(XFile?) onFileSelected;
  final bool imageOnly;
  final String? initialFileName;
  final bool isRequired;

  const FileUploadField({
    super.key,
    required this.label,
    required this.onFileSelected,
    this.imageOnly = false,
    this.initialFileName,
    this.isRequired = false,
  });

  @override
  State<FileUploadField> createState() => _FileUploadFieldState();
}

class _FileUploadFieldState extends State<FileUploadField> {
  XFile? _selectedFile;

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    XFile? file;
    
    if (widget.imageOnly) {
      // Show dialog to choose between camera and gallery
      final source = await _showImageSourceDialog();
      if (source != null) {
        file = await picker.pickImage(source: source);
      }
    } else {
      // For documents, use gallery
      file = await picker.pickImage(source: ImageSource.gallery);
      // TODO: For actual documents, use file_picker package
    }
    
    if (file != null) {
      setState(() => _selectedFile = file);
      widget.onFileSelected(file);
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source', style: AppFonts.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primaryColor),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.primaryColor),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFile() {
    setState(() => _selectedFile = null);
    widget.onFileSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: AppFonts.labelText.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (widget.isRequired)
                Text(
                  ' *',
                  style: AppFonts.labelText.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
                color: AppColors.cardColor,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    _selectedFile != null ? Icons.check_circle : Icons.upload_file,
                    color: _selectedFile != null ? AppColors.successColor : AppColors.primaryColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedFile?.name ?? 
                      widget.initialFileName ?? 
                      'Tap to upload ${widget.label.toLowerCase()}',
                      style: AppFonts.bodyMedium.copyWith(
                        color: _selectedFile != null 
                          ? AppColors.textPrimary 
                          : AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (_selectedFile != null) ...[
                    if (widget.imageOnly)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            File(_selectedFile!.path),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    IconButton(
                      onPressed: _removeFile,
                      icon: const Icon(Icons.close, color: AppColors.errorColor),
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}