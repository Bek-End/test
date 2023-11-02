import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_test/core/constants/app_text_styles.dart';
import 'package:local_test/core/extentions/date_time_extentions.dart';
import 'package:local_test/data/models/paper_model.dart';
import 'package:local_test/design/screens/paper/bloc/paper_bloc.dart';

class PaperDetailScreen extends StatelessWidget {
  const PaperDetailScreen({
    super.key,
    required this.paper,
  });

  final PaperModel paper;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PaperBloc>().add(PaperGetPapersEvent());
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(paper.title, style: AppTextStyles.s32w600White),
              const SizedBox(height: 25.0),
              Text(paper.descr, style: AppTextStyles.s20w600White),
              const SizedBox(height: 25.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text(paper.createdAt!.ddMMyyyyHHmmss),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
