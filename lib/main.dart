import 'package:flutter/material.dart';
import 'package:job_aggregator/screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}

class JobListScreen extends StatelessWidget {
  final List<Job> jobs = [
    Job(
      image: 'assets/download.jfif',
      title: 'Software Engineer',
      salary: '\$80,000 - \$120,000',
      applyLink: 'https://example.com/apply',
    ),
    Job(
      image: 'assets/pic1.jpeg',
      title: 'Data Scientist',
      salary: '\$90,000 - \$130,000',
      applyLink: 'https://example.com/apply',
    ),
    Job(
      image: 'assets/pic1.jpeg',
      title: 'Software Engineer',
      salary: '\$80,000 - \$120,000',
      applyLink: 'https://example.com/apply',
    ),
    Job(
      image: 'assets/pic2.png',
      title: 'Data Scientist',
      salary: '\$90,000 - \$130,000',
      applyLink: 'https://example.com/apply',
    ),Job(
      image: 'assets/pic1.jpeg',
      title: 'Software Engineer',
      salary: '\$80,000 - \$120,000',
      applyLink: 'https://example.com/apply',
    ),
    Job(
      image: 'assets/pic2.png',
      title: 'Data Scientist',
      salary: '\$90,000 - \$130,000',
      applyLink: 'https://example.com/apply',
    ),Job(
      image: 'assets/pic1.jpeg',
      title: 'Software Engineer',
      salary: '\$80,000 - \$120,000',
      applyLink: 'https://example.com/apply',
    ),
    Job(
      image: 'assets/pic2.png',
      title: 'Data Scientist',
      salary: '\$90,000 - \$130,000',
      applyLink: 'https://example.com/apply',
    ),
    // Add more job data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            SizedBox(width: 10),
            Text('Job Finder'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for jobs...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: jobs.length,
              controller: PageController(viewportFraction: 0.75,initialPage: 1),
              itemBuilder: (context, index) {
                return Transform.translate(
                  offset: Offset(0, index == 0 ? -50 : 0), 
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: JobCard(job: jobs[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Job {
  final String image;
  final String title;
  final String salary;
  final String applyLink;

  Job({required this.image, required this.title, required this.salary, required this.applyLink});
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
              topRight: Radius.circular(10),),
            child: Image.asset(
              job.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,  // Adjust height if necessary
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  // Should match the height of the image
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(1),  // Darker color at the bottom
                      Colors.transparent,  // Fade to transparent
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Job information content
          Positioned(
            top: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,   
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,  // Text color should be white for contrast
                  ),
                ),
                Text(
                  job.salary,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent,  // Light color for better contrast
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _launchURL(job.applyLink);
                      },
                      child: Text('Apply'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle more details
                      },
                      child: Text('More details', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) {
    // Implement URL launch functionality
  }
}

