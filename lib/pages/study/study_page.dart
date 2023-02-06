import 'package:account_flutter/pages/study/inherited_test_route.dart';
import 'package:account_flutter/pages/study/provider_show.dart';
import 'package:flutter/material.dart';


class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("study"),
      ),
      body: Center(
        child: ProviderShow(),
      ),
    );
  }
}

