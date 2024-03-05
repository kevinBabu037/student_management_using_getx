

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management_app/controller/getx.dart';
import '../../../constants/constants.dart';
import '../../../models/student_model.dart';
import '../../home/widgets/text_formfild.dart';


// ignore: must_be_immutable
class EditStudentWidget extends StatelessWidget {
   EditStudentWidget({super.key,
     required this.data,
     required this.id
  });
    final StudentModel data;
    final String id;
       final StudetsController controller = Get.put(StudetsController());

  @override 
  Widget build(BuildContext context) {
       final namecontroller=TextEditingController(text:data.name );
       final departmentcontroller=TextEditingController(text:data.department );
       final phNocontroller=TextEditingController(text:data.phNo );
       final rollNocontroller=TextEditingController(text:data.rollNo );
     controller.imageFile.value=data.image; 

    return Padding(padding:const EdgeInsets.only(top: 100  ,bottom: 50  ),
      child: SingleChildScrollView(
        child: AlertDialog(
            title:  const Text('Edit'),
            content: Column(
              children: [ 
                  
                  GetBuilder<StudetsController>(
                    init: StudetsController(),
                    builder: (controller) {
                      return GestureDetector(
                    onTap: () {
                      controller.selectImageFromGallery(); 

                    },
                    child: 
                     CircleAvatar(
                         backgroundColor: Colors.black.withOpacity(0.6),
                        radius: 50,  
                        backgroundImage: controller.imageFile.isNotEmpty
                            ? FileImage(File(controller.imageFile.value))
                            : null,
                        child: controller.imageFile.isEmpty
                            ? const Icon(
                                Icons.add_a_photo, 
                                
                              )
                            : null,
                      ),
                    
                  
                      );
                    },
                    ),

                   
                   kHeight20,
                BuildTextformFild(hintText: 'name',controller: namecontroller), 
                kHeight20,
               BuildTextformFild(hintText: 'Department',controller: departmentcontroller,), 
                kHeight20,
               BuildTextformFild(hintText: 'RollNo',controller: rollNocontroller,keyboardType: TextInputType.number),  
                kHeight20,
               BuildTextformFild(hintText: 'PhNo',controller: phNocontroller,keyboardType: TextInputType.number,), 
                kHeight20,
              ],
            ), 
          
           actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const Text('Cancel',
            style: TextStyle(color: Colors.white),)),
          
            TextButton(onPressed: (){
               StudentModel student=data.copyWith(
                image:controller.imageFile.value,
                department: departmentcontroller.text,
                name: namecontroller.text,
                phNo: phNocontroller.text,
                rollNo: rollNocontroller.text
               ); 
              controller.updateStudent(id, student,context);
              controller.imageFile.value='';  
            },
             child:const Text('Edit',style: TextStyle(color: Colors.white))),
           ],
        ),
      ),
    );
  }
}