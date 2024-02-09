import 'package:audioplayers/audioplayers.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:clean_architecture/features/form/presentation/bloc/form_bloc.dart';
import 'package:clean_architecture/features/form/presentation/pages/audio.dart';
import 'package:clean_architecture/features/form/presentation/pages/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/styles.dart';
import '../../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: Row(
        children: [
          _buildBtn(
            title: 'Form Page',
            subtitle: 'Fill the Form',
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BlocProvider(
                          create: (context) => FormBloc(),
                          child: MyForm(),
                        )),
              );
            },
          ),
          _buildBtn(
            title: 'Play Audio',
            subtitle: 'Play audio',
            color: Colors.red,
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PlayerPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticleError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticleDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Expanded _buildBtn({
    required Color color,
    required String subtitle,
    required String title,
    required VoidCallback onTap,
  }) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(18, 16, 16, 0.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 16.0,
                    spreadRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Colors.blue,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Styles.boldBlack18.copyWith(color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    style: Styles.white14.copyWith(fontSize: 13),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
