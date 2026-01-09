import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../issue/issue_model.dart';
import 'admin_issue_detail_page.dart';

class AdminIssueListPage extends StatefulWidget {
  const AdminIssueListPage({super.key});

  @override
  State<AdminIssueListPage> createState() => _AdminIssueListPageState();
}

class _AdminIssueListPageState extends State<AdminIssueListPage> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final issuesBox = Hive.box<IssueModel>('issues');

    return Scaffold(
      appBar: AppBar(title: const Text('Yönetici Paneli'), centerTitle: true),
      body: SafeArea(
        child: ValueListenableBuilder<Box<IssueModel>>(
          valueListenable: issuesBox.listenable(),
          builder: (_, box, __) {
            final issues = box.values.toList();

            final total = issues.length;
            final inProgress = issues
                .where((i) => i.status == 'inProgress')
                .length;
            final resolved = issues.where((i) => i.status == 'resolved').length;

            final filteredIssues = issues.where((i) {
              if (_filter == 'all') return true;
              return i.status == _filter;
            }).toList();

            return Column(
              children: [
                /// 🔥 ÜST ÖZET PANELİ
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _StatCard('Toplam', total, Colors.blueGrey),
                      _StatCard('İnceleniyor', inProgress, Colors.blue),
                      _StatCard('Çözüldü', resolved, Colors.green),
                    ],
                  ),
                ),

                /// 🔍 FİLTRE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      _FilterChip('Tümü', 'all'),
                      _FilterChip('Alındı', 'received'),
                      _FilterChip('İnceleniyor', 'inProgress'),
                      _FilterChip('Çözüldü', 'resolved'),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// 📄 LİSTE
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredIssues.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final issue = filteredIssues[index];
                      final realIndex = issues.indexWhere(
                        (i) => i.id == issue.id,
                      );

                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminIssueDetailPage(
                                issue: issue,
                                index: realIndex,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  issue.description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  issue.address,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _StatusChip(issue.status),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _FilterChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _filter == value,
      onSelected: (_) {
        setState(() {
          _filter = value;
        });
      },
    );
  }
}

/* ===================== */
/* STAT CARD             */
/* ===================== */

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatCard(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== */
/* STATUS CHIP           */
/* ===================== */

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    late Color color;
    late String label;

    switch (status) {
      case 'inProgress':
        color = Colors.blue;
        label = 'İnceleniyor';
        break;
      case 'resolved':
        color = Colors.green;
        label = 'Çözüldü';
        break;
      default:
        color = Colors.orange;
        label = 'Alındı';
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.15),
      labelStyle: TextStyle(color: color),
    );
  }
}
