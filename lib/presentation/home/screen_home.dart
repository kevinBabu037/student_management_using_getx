
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management_app/controller/getx.dart';
import 'package:getx_student_management_app/presentation/all_students/screen_all_students.dart';

import '../../constants/constants.dart';
import '../../models/student_model.dart';
import '../../sample/sample.dart';
import 'widgets/text_formfild.dart';


// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
    ScreenHome({super.key}); 

 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final namecontroller=TextEditingController();
  final departmentcontroller=TextEditingController();
  final phNocontroller=TextEditingController();
  final rollNocontroller=TextEditingController();

   StudetsController controller=Get.put(StudetsController());

  @override
  Widget build(BuildContext context) {
     
        return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(10, 62, 60, 55),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenAllStudents()),
                );
              },
              icon: const Icon(Icons.list),
            ),
          ],
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              Get.to( Sample());
            },
            child: const Text('Add Student')
            ),
        ),
        body: SingleChildScrollView(
          child: Padding(  
            padding: const EdgeInsets.all(10), 
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  kHeight30,
                   
                    GetBuilder<StudetsController>(  
                      init:StudetsController() ,
                      builder: (controller) {
                      return GestureDetector(
                      onTap: () {
                        controller.selectImageFromGallery();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.6),
                        radius: 60,
                        backgroundImage: controller.imageFile.value.isNotEmpty?
                        FileImage(File(controller.imageFile.value)):
                          Image.network('https://i.pinimg.com/236x/4e/22/be/4e22beef6d94640c45a1b15f4a158b23.jpg').image
                      ),
                    );
                    },),
                     

                  kHeight40, 
                  BuildTextformFild(
                    controller: namecontroller, 
                    hintText: 'Name',
               
                  ),
                  kHeight20,
                  BuildTextformFild(
                    keyboardType: TextInputType.number,
                    controller:rollNocontroller ,
                    hintText: 'Roll No',
                
                  ), 
                  kHeight20, 
                  BuildTextformFild(
                    controller: departmentcontroller,
                    hintText: 'Department',
                  
                  ),
                  kHeight20,
                  BuildTextformFild(
                    keyboardType: TextInputType.number,
                    controller: phNocontroller,
                    hintText: 'Ph No',
                   
                  ),
                  kHeight40,
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: ()async { 
                       if(_formKey.currentState!.validate()&& controller.imageFile.value.isNotEmpty){
                          controller.addStudent(
                           StudentModel(
                             image: controller.imageFile.value , 
                            department: departmentcontroller.text, name: namecontroller.text, phNo: phNocontroller.text, rollNo: rollNocontroller.text),
                          context, namecontroller, departmentcontroller, phNocontroller, rollNocontroller,
                          ); 
                          
                       }
                       
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.6),  
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      

  }

 
}




