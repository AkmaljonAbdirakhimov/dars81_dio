import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadVideoScreen extends StatefulWidget {
  const DownloadVideoScreen({super.key});

  @override
  State<DownloadVideoScreen> createState() => _DownloadVideoScreenState();
}

class _DownloadVideoScreenState extends State<DownloadVideoScreen> {
  final videoUrlController = TextEditingController();

  double downloadPercentage = 0;

  void downloadVideo() async {
    final dio = Dio();

    final videoFolder = await getApplicationDocumentsDirectory();

    await dio.download(
      videoUrlController.text,
      "${videoFolder.path}/quyoncha.jpg",
      onReceiveProgress: (count, total) {
        setState(() {
          downloadPercentage = count / total;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Downloader"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: videoUrlController,
            ),
            const SizedBox(height: 20),
            Text("${(downloadPercentage * 100).toStringAsFixed(2)}%"),
            LinearProgressIndicator(
              value: downloadPercentage,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: downloadVideo,
              child: const Text("Download"),
            ),
          ],
        ),
      ),
    );
  }
}
