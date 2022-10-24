import 'package:flutter/material.dart';
import 'package:lokerify/model/job_model/job_model.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/detail_page.dart';
import 'package:lokerify/view/widgets/avatar.dart';

class JobCard extends StatelessWidget {
  final JobModel jobData;
  const JobCard({
    Key? key,
    required this.jobData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 25,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: jobData.about.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          jobData.about[index],
                          style: subtitleStyle.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Avatar(
                    img: jobData.companyLogo,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobData.name,
                          style: titleStyle.copyWith(
                            fontSize: 14,
                            color: whiteColor,
                          ),
                        ),
                        Text(
                          jobData.companyName,
                          style: subtitleStyle.copyWith(
                            fontSize: 12,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailPage(
                  id: jobData,
                ),
              )),
              child: Container(
                alignment: Alignment.bottomRight,
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: blackColor,
                ),
                child: Center(
                    child: Text(
                  'Detail',
                  style: TextStyle(color: whiteColor),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
