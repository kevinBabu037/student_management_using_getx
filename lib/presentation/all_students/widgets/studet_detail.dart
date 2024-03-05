
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:getx_student_management_app/controller/getx.dart';
import 'package:getx_student_management_app/models/student_model.dart';
import 'package:getx_student_management_app/presentation/all_students/widgets/edit_student.dart';
import '../../../constants/constants.dart';



class StudetDetailsWidget extends StatelessWidget {
   StudetDetailsWidget({
    Key? key,
     required this.data,
    required this.id
  }) : super(key: key);

   final StudentModel data;
   final String id;
       final StudetsController controller = Get.put(StudetsController());
     
  @override
  Widget build(BuildContext context) {
 
    return Flexible( 
      child: Container(
        padding:const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color:  Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           Center(
             child:   CircleAvatar(
               backgroundColor: Colors.black.withOpacity(0.6),
                radius: 40,
                 backgroundImage: FileImage(File(data.image)),
              ),
           ), 
             Text('Name: ${data.name}',style:kTextStyle),
             Text('Roll No: ${data.rollNo}',style:kTextStyle),
             Text('Course: ${data.department}',style:kTextStyle),
             Text('Ph No: ${data.phNo}',style:kTextStyle), 
            Row(
              children: [
                IconButton( 
                  onPressed: () {
                    showDialog(
                      context: context,
                       builder:(context) {
                         return  EditStudentWidget(data: data,id: id, );
                       }, );
                  },
                  icon:const Icon(Icons.edit_document, color: Colors.grey),
                ),
               const Spacer(),
                IconButton(
                  onPressed: () {
                   showDialog(
                    context: context,
                     builder: (context) {
                       return AlertDialog(
                        title:const Text('Delete'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          },
                           child:const Text('Cancel',style: TextStyle(color: Colors.white),)),
                           TextButton(onPressed: (){
                            controller.deleteStudent(id,context); 
                            Navigator.pop(context);
                          },
                           child:const Text('Delete',style: TextStyle(color: Colors.white),)),
                        ],
                       );
                     },);
                  },
                  icon:const Icon(Icons.delete, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


