import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_en/database/class_add.dart';
import 'package:learn_en/database/class_id.dart';
import 'package:learn_en/model/clas_model.dart';
import 'package:learn_en/router/router.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// Controller
  var clasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllClass();
  }

  void getAllClass() {
    context.read<ClasAddCubit>().classGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.class_),
        title: const Text('Claasses'),
      ),
      body: Center(child: BlocBuilder<ClasAddCubit, List<ClassModel>>(
        builder: (context, state) {
          if (state.isNotEmpty) {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                ClassModel item = state[index];

                return Card(
                  child: ListTile(
                    onTap: () {
                      context.read<ClasIDCubit>().settingClassID(item.clasID);
                      context.go(AppRoters.WORD);
                    },
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    title: Text(item.className),
                  ),
                );
              },
            );
          } else {
            return const Text('No Class Added');
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return alertDiyalogAaddClass(context);
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  AlertDialog alertDiyalogAaddClass(BuildContext context) {
    return AlertDialog(
      title: alertTitle(),
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.all(20),
      content: alertTextFild(),
      actions: [
        cancelButton(context),
        const SizedBox(width: 20),
        addButton(context),
      ],
    );
  }

  ElevatedButton addButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 20,
      ),
      onPressed: () {
        if (clasController.text.isNotEmpty) {
          var clasID = const Uuid().v1();
          var newClass = ClassModel(
            clasID: clasID,
            className: clasController.text,
          );

          context.read<ClasAddCubit>().clasADD(newClass);

          clasController.clear();
          context.pop();
        } else {
          // Snackbar gösterimi
          final snackBar = SnackBar(
            content: const Text('Class name not empty !'),
            action: SnackBarAction(
              label: 'Geri Al',
              onPressed: () {
                clasController.clear();
              },
            ),
          );
          // ScaffoldMessenger kullanarak Snackbar'ı göster
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text(
        '  Add  ',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  ElevatedButton cancelButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () {
        context.pop();
        clasController.clear();
      },
      child: const Text('Cancel'),
    );
  }

  Column alertTextFild() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: clasController,
          decoration: const InputDecoration(
            hintText: 'Class Name',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Text alertTitle() {
    return const Text(
      'Class Add',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
