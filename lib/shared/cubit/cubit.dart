
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '../../modules/archived_tasks.dart';
import '../../modules/done_tasks.dart';
import '../../modules/new_tasks.dart';
import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> newTasks =[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  int currentIndex= 0;

  List<Widget> screens=const[
    NewTasksScreen(),
    DoneTaskScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }


  void createDatabase()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value)
        {
          print('the table is created');
        }).catchError((error)
        {
          print('error when created${error.toString()}');
        });
      },
      onOpen:(database)
      {
        getDataFromDatabase(database);
        print('database opened');
      } ,
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });

  }

  insertIntoDatabase(
      {
        required String title,
        required String date,
        required String time,
      })async
  {
    await database?.transaction((txn)async{
      await txn.rawInsert('INSERT INTO tasks ( title, date, time, status) Values ("$title","$date","$time","new")').then((value)
      {
        print('successfully record inserted');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error){
        print('error when row inserted ${error.toString()}');
      });
    })  ;
  }

  void getDataFromDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    database!.rawQuery('SELECT * FROM tasks').then((value) {


      for (var element in value) {

        if(element['status']== 'new')
        {
          newTasks.add(element);
        }else if(element['status']== 'done')
        {
          doneTasks.add(element);
        }else
        {
          archivedTasks.add(element);
        }

      }


      emit(AppGetDatabaseState());
    });

  }

  void updateDatabase(
      {
        required String status,
        required int id,
      }
      )
  {
    database!.rawUpdate('UPDATE tasks SET status=? WHERE id=?',[status,'$id']).
    then((value)
    {
      emit(AppUpdateDatabaseState());
      getDataFromDatabase(database);
    });
  }
  void deleteDatabase({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id=?',[id]).
    then((value)
    {
      emit(AppDeleteDatabaseState());
      getDataFromDatabase(database);
    });
  }

  bool isButtonSheetShow = false;
  IconData fabIcon = Icons.edit;

  void changeButtonNavBar(
      {
        required bool isShow,
        required IconData icon,
      })
  {
    isButtonSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeNavButtonState());
  }

  bool isDark = false ;

  void changeTheme({bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared ;
      emit(AppChangeThemeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeThemeState());
      });
    }


  }

}