import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class AddLeadView extends StatefulWidget {
  const AddLeadView({super.key});

  @override
  State<AddLeadView> createState() => _AddLeadViewState();
}

class _AddLeadViewState extends State<AddLeadView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dashboardBg,
      appBar: AppBar(
        title: Text('Add New Lead', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Contact Information'),
              const SizedBox(height: 16),
              _buildTextField('Full Name', Icons.person_outline_rounded),
              const SizedBox(height: 16),
              _buildTextField('Email Address', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField('Phone Number', Icons.phone_android_rounded, keyboardType: TextInputType.phone),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Lead Details'),
              const SizedBox(height: 16),
              _buildDropdownField('Lead Source', ['Website', 'Google', 'Facebook', 'LinkedIn', 'Referral', 'Direct'], Icons.source_outlined),
              const SizedBox(height: 16),
              _buildDropdownField('Status', ['New', 'Contacted', 'Qualified', 'Negotiation', 'Closed'], Icons.flag_outlined),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Additional Notes'),
              const SizedBox(height: 16),
              _buildTextField('Remarks', Icons.note_alt_outlined, maxLines: 4),
              
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lead added successfully!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('Create Lead', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {TextInputType? keyboardType, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.outfit(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Enter $label',
            prefixIcon: Icon(icon, size: 20, color: AppTheme.textSecondary),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.borderSide)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.borderSide)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: items.first,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: GoogleFonts.outfit(fontSize: 15)),
            );
          }).toList(),
          onChanged: (_) {},
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: AppTheme.textSecondary),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.borderSide)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.borderSide)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)),
          ),
        ),
      ],
    );
  }
}
