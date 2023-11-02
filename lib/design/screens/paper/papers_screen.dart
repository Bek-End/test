import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_test/core/constants/app_colors.dart';
import 'package:local_test/core/constants/app_text_styles.dart';
import 'package:local_test/data/models/paper_model.dart';
import 'package:local_test/design/screens/paper/bloc/paper_bloc.dart';
import 'package:local_test/design/screens/paper/paper_detail_screen.dart';
import 'package:local_test/design/widgets/loading.dart';

class PapersScreen extends StatefulWidget {
  const PapersScreen({super.key});

  @override
  State<PapersScreen> createState() => _PapersScreenState();
}

class _PapersScreenState extends State<PapersScreen> {
  void _refresh() {
    context.read<PaperBloc>().add(PaperRefreshEvent());
  }

  void _detailPaper(PaperModel paper) {
    context.read<PaperBloc>().add(PaperDetailEvent(paper: paper));
  }

  void _navigateToDetailScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => PaperDetailScreen(
        paper: (context.read<PaperBloc>().state as PaperDetailState).paper,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PaperBloc, PaperState>(
          listenWhen: (p, c) => p != c && c is PaperDetailState,
          listener: (context, state) => _navigateToDetailScreen(),
          builder: (context, state) {
            if (state is! PaperCompleteState) return const Loading();

            final papers = state.papers;

            return RefreshIndicator(
              onRefresh: () async => _refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: papers.length,
                itemBuilder: (context, index) {
                  final paper = papers[index];
                  return _PaperItem(
                    paper: paper,
                    onTap: () => _detailPaper(paper),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PaperItem extends StatelessWidget {
  const _PaperItem({
    required this.paper,
    required this.onTap,
  });

  final PaperModel paper;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.violetDark,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(width: 2.0, color: AppColors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(paper.title, style: AppTextStyles.s20w600White),
            Text(
              paper.descr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s16Grey,
            ),
          ],
        ),
      ),
    );
  }
}
