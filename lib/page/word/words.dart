import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_en/constant/card_widget.dart';
import 'package:learn_en/database/class_id.dart';
import 'package:learn_en/database/word_add_serv.dart';
import 'package:learn_en/model/word_model.dart';
import 'package:learn_en/router/router.dart';
import 'package:lottie/lottie.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({
    super.key,
  });

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  late String classID;

  @override
  void initState() {
    super.initState();
    classID = context.read<ClasIDCubit>().state;

    getWords();
  }

  Future<void> getWords() async {
    await context.read<WordCubbit>().wordGet(classID);
  }

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                  onTap: () {
                    context.go(AppRoters.PLAY,
                        extra: context.read<WordCubbit>().state);
                  },
                  child: LottieBuilder.asset('assets/lottie/animation.json')),
            ],
            leading: IconButton(
                onPressed: () {
                  context.go(AppRoters.HOME);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            automaticallyImplyLeading: false,
            title: const Text('Words'),
          ),
          body: Center(
            child: BlocBuilder<WordCubbit, List<WordModel>>(
              builder: (context, state) {
                if (state.isEmpty) {
                  return const Center(child: Text('No words found.'));
                }

                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    var item = state[index];

                    return InkWell(
                      onTap: () {
                        context.go(
                          AppRoters.WORD_SETTING,
                          extra: item,
                        );
                      },
                      child: SbtCarWidget(item: item),
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go(AppRoters.WORD_ADD);
            },
            child: const Icon(
              Icons.add_task,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
