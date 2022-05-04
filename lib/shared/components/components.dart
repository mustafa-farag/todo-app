import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  IconData? prefix,
  IconData? suffix,
  bool isSecure = false,
  Function()? suffixPressed,
  Function(String)? onSubmit,
  String? Function(String? val)? validate,
  Function()? onTap,
  Function(String)? onChange,

}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isSecure,
    validator: validate,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
    onChanged:onChange ,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 0,
          )
      ),
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
          onPressed:suffixPressed ,
          icon: Icon(suffix)
      ),
    ),
  );
}

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildTasksItem(Map model,context)
{
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction)
    {
      AppCubit.get(context).deleteDatabase(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
              style:const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style:Theme.of(context).textTheme.caption ,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase(status:'done', id: model['id']);
            },
            icon:const Icon(
              Icons.check_box_outlined,
              color: Colors.green,),
          ),
          IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase(status: 'archived', id: model['id']);
            },
            icon:const Icon(
              Icons.archive_outlined,
              color: Colors.black45,),
          ),
        ],
      ),
    ),
  );
}

Widget buildTasksList(
    {
      required List<Map> tasks,
    })
{
  return ListView.separated(

      itemBuilder: (context,index)=>buildTasksItem(tasks[index] , context),
      separatorBuilder: (context,index)=> myDivider(),
      itemCount: tasks.length);
}
