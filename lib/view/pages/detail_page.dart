import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokerify/model/job_model/job_model.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view_model/job_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final JobModel id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark)),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Avatar(
                    h: 80,
                    w: 80,
                    img: id.companyLogo,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      id.name,
                      style: titleStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        id.companyName,
                        style: subtitleStyle.copyWith(fontSize: 14),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        id.location,
                        style: subtitleStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 8),
              child: Text(
                'About the job',
                style: titleStyle.copyWith(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: id.about.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset('assets/ic_dot.png'),
                      ),
                      Text(
                        id.about[index],
                        style: subtitleStyle.copyWith(fontSize: 12),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: Text(
                'Qualification',
                style: titleStyle.copyWith(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: id.qualifications.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset('assets/ic_dot.png'),
                      ),
                      Expanded(
                        child: Text(
                          id.qualifications[index],
                          style: subtitleStyle.copyWith(fontSize: 12),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: Text(
                'Responsibilities',
                style: titleStyle.copyWith(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: id.responsibilities.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset('assets/ic_dot.png'),
                      ),
                      Expanded(
                        child: Text(
                          id.responsibilities[index],
                          style: subtitleStyle.copyWith(fontSize: 12),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => jobProvider.appliedJob(),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: jobProvider.isApplied
                        ? const Color.fromARGB(255, 136, 24, 16)
                        : primaryColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      jobProvider.message,
                      style: subtitleStyle.copyWith(color: whiteColor),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
