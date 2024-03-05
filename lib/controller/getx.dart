import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management_app/constants/constants.dart';
import 'package:getx_student_management_app/models/student_model.dart';
import 'package:getx_student_management_app/presentation/all_students/screen_all_students.dart';
import 'package:image_picker/image_picker.dart';
const String studentCollectionRef="studentCollection";
class StudetsController extends GetxController {

    
  late var imageFile=''.obs; 

    String? searchTxt;
  

  final RxList studentsList=[].obs;
 

  Future<void> selectImageFromGallery()async{
    final pickedFile=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      imageFile.value=pickedFile.path;
       update();
    }
  }


  


///////////////CRUD//////////////////////



 final fireStore=FirebaseFirestore.instance;  
  late final CollectionReference studentRef;
  
  
  StudetsController(){
    studentRef=fireStore.collection(studentCollectionRef).withConverter<StudentModel>(
      fromFirestore:(snapshot, _) =>StudentModel.fromJson(snapshot.data()!) ,
       toFirestore: (value, options) =>value.toJson() );
  }
   
////////////


    Stream<QuerySnapshot>getAllStudents(){
      return studentRef.snapshots();
    }



//////////////



    void addStudent(
    StudentModel data,
    BuildContext context,
    TextEditingController namecontroller,
    TextEditingController departmentcontroller,
    TextEditingController phNocontroller,
    TextEditingController rollNocontroller
    )async{
      
      studentRef.add(data);
      update();
      Get.to(const ScreenAllStudents());
      kClearAllFields(namecontroller, departmentcontroller, phNocontroller, rollNocontroller);
      Get.snackbar('Student', 'Data Added Succesfully');
     imageFile.value='';
    }


/////////////

void updateStudent(
  String id,
  StudentModel student,
  BuildContext context,

  ){
    
    studentRef.doc(id).update(student.toJson());
    update();
      
      Navigator.pop(context);

}

/////////////

deleteStudent(
  String id,
  BuildContext context
){
  studentRef.doc(id).delete();
  Get.snackbar('Delete', 'Data Deleted Succesfully');
  update();

}

///////////


 Stream<QuerySnapshot> searchStudents(String searchTerm) {
    return studentRef.where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThan: searchTerm+ 'z')
        .snapshots();
        
  }

  // String? get search=>searchTxt;

  setSearch(String? searchVal){
  searchTxt=searchVal;
  update();
  }
 


}