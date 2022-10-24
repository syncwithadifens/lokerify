import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view/widgets/job_card.dart';
import 'package:lokerify/view/widgets/custom_navigation_bar.dart';
import 'package:lokerify/view_model/job_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';

  @override
  void initState() {
    super.initState();
    Provider.of<JobProvider>(context, listen: false).getjobs();
    getUser();
  }

  void getUser() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    setState(() {
      name = (snapshot.data() as Map<String, dynamic>)['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: const CustomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                        'Hi, $name',
                        style: titleStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text('Ready to find a job right now?',
                          style: subtitleStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  const Avatar()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Find your dream job',
                  style: titleStyle.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: jobProvider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : jobProvider.success == false
                        ? Center(
                            child: Lottie.asset('assets/remote-job.json'),
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
      ),
    );
  }
}
