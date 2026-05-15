import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import 'add_lead_view.dart';

class MyLeadsView extends StatelessWidget {
  const MyLeadsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= 700;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, isMobile ? 100 : 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) ...[
              Text(
                'My Leads',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
            ],
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 48),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.borderSide),
                    ),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(AppTheme.sidebarBg),
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Source')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Created At')),
                      ],
                      rows: [
                        _buildRow('Avinash Magar', 'Website', 'New', '10 May, 2024', Colors.blue),
                        _buildRow('Rahul Sharma', 'Google', 'Contacted', '11 May, 2024', Colors.orange),
                        _buildRow('Priya Singh', 'Referral', 'Qualified', '12 May, 2024', Colors.green),
                        _buildRow('Amit Patel', 'Facebook', 'New', '13 May, 2024', Colors.blue),
                        _buildRow('Sneha Reddy', 'Direct', 'Negotiation', '14 May, 2024', Colors.purple),
                        _buildRow('Vikram Rao', 'LinkedIn', 'Closed', '15 May, 2024', Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLeadView()),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Lead'),
      ),
    );
  }

  DataRow _buildRow(String name, String source, String status, String date, Color color) {
    return DataRow(cells: [
      DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
      DataCell(Text(source)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataCell(Text(date)),
    ]);
  }
}
