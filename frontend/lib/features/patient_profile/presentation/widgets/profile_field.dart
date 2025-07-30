import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final TextEditingController? controller;
  final bool isEditable;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isDateField;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final Function(String?)? onDropdownChanged;
  final VoidCallback? onTap;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    this.controller,
    required this.isEditable,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.isDateField = false,
    this.isDropdown = false,
    this.dropdownItems,
    this.onDropdownChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          if (isDropdown && isEditable)
            _buildDropdownField()
          else if (isDateField && isEditable)
            _buildDateField(context)
          else if (isEditable)
            _buildTextFormField()
          else
            _buildReadOnlyField(),
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: 'Enter $label',
        prefixIcon: Icon(icon, color: Colors.teal[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal[600]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Select $label',
            prefixIcon: Icon(icon, color: Colors.teal[600]),
            suffixIcon: Icon(Icons.calendar_today, color: Colors.teal[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.teal[600]!, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: dropdownItems?.contains(value) == true ? value : null,
      items: dropdownItems?.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onDropdownChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal[600]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildReadOnlyField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not specified' : value,
              style: TextStyle(
                fontSize: 16,
                color: value.isEmpty ? Colors.grey[500] : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}