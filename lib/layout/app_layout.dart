
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class TodoMain extends StatelessWidget {
  const TodoMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var scaffoldKey =GlobalKey<ScaffoldState>();
    var formKey =GlobalKey<FormState>();
    var titleController= TextEditingController();
    var dateController= TextEditingController();
    var timeController= TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context , AppStates state){
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context , AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body:cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if(cubit.isButtonSheetShow)
                {
                  if(formKey.currentState!.validate()){
                    cubit.insertIntoDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );}
                } else {
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    return Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              label: 'Task Title',
                              prefix: Icons.title,
                              validate: (value){
                                if(value!.isEmpty){
                                  return'title can not be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                              controller: timeController,
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now() ).then((value)
                                {
                                  timeController.text= value!.format(context).toString();
                                });
                              },
                              type: TextInputType.datetime,
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                              validate: (value){
                                if(value!.isEmpty){
                                  return'Time can not be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                              controller: dateController,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-06-03'),
                                ).then((value)
                                {
                                  dateController.text = DateFormat.yMMMd().format(value!);
                                });
                              },
                              type: TextInputType.datetime,
                              label: 'Task Time',
                              prefix: Icons.calendar_today,
                              validate: (value){
                                if(value!.isEmpty){
                                  return 'Time can not be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).closed.then((value) {
                    cubit.changeButtonNavBar(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeButtonNavBar(isShow: true, icon: Icons.add); }
              },
            ) ,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              items:const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}






