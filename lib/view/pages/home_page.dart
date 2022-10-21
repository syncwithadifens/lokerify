import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view/widgets/job_card.dart';
import 'package:lokerify/view/widgets/custom_navigation_bar.dart';
import 'package:lokerify/view_model/job_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<JobProvider>(context, listen: false).getjobs();
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: const CustomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Afiv',
                      style: titleStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Text('Siap cari kerja sekarang juga?',
                        style: subtitleStyle),
                  ],
                ),
                const Avatar()
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Semua loker tersedia',
                style: titleStyle.copyWith(fontSize: 18),
              ),
            ),
            Expanded(
              child: jobProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: jobProvider.result.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: JobCard(
                            jobData: jobProvider.result[index],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
