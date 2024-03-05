
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_management_app/sample/controller.dart';

// ignore: must_be_immutable
class Sample extends StatelessWidget {
   Sample({super.key});
   
    var count=0.obs;
    
   
  //  MyController controller=Get.put(MyController());
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<MyController>(
            init: MyController(),
          builder: (controller) {
            return Column(crossAxisAlignment:CrossAxisAlignment.center, 
             children: [
             const SizedBox(height: 40,),
             Text('count $count'),
             Text('count ${controller.countt}'),
             
               ElevatedButton(onPressed: (){  
               controller.addFun(count);  
                 
               },
                child:const Text('+')),
                   Expanded( 
                   child: 
                      ListView.builder( 
                          itemCount:controller. arr.length,
                          itemBuilder: (context, index) {
                         return ListTile(title: Text('${controller. arr[index]}'),);
                                         },),
                      
                   
                 )
            ],
          );
          },
           
        ),
      ),
    );
  }
}