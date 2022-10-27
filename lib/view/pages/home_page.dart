import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/profile_page.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view/widgets/custom_fab.dart';
import 'package:lokerify/view/widgets/job_card.dart';
import 'package:lokerify/view/widgets/custom_navigation_bar.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:lokerify/view_model/job_provider.dart';
import 'package:lottie/lottie.dart';
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
    Provider.of<AuthProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: blackColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        floatingActionButton: const CustomFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavigationBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authProvider.isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, ${authProvider.name}',
                                style: titleStyle.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text('Ready to find a job right now?',
                                  style: subtitleStyle.copyWith(fontSize: 14)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            ),
                            child: const Avatar(
                              h: 60,
                              w: 60,
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
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
                      : jobProvider.success
                          ? ListView.builder(
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
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/remote-job.json'),
                                Text(
                                  'Server is under maintenance...',
                                  style: subtitleStyle,
                                )
                              ],
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
