
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';

import 'package:student_app/widgets/stateless/icon_button_back.dart';



enum Gender {nam, nu }  
class InfoUser extends StatefulWidget {
 const InfoUser({Key? key}) : super(key: key);


   
  @override
  State<InfoUser> createState() => _InfoUserState();

}


class _InfoUserState extends State<InfoUser> {
DateTime selectedDate = DateTime.now();

  String getText(){
    // ignore: unnecessary_null_comparison
    if(selectedDate == null) {return 'Chọn';}
    else {return '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';}
  }
  Future<void> selectDate(BuildContext context) async {
  
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1777, 8),
        lastDate: DateTime(2101)
       
    );

    if (picked != null && picked != selectedDate) {
      
      setState(() {
        selectedDate = picked;
      });
      
    }
  }
     Gender? gender = Gender.nam;

  @override
  Widget build(BuildContext context) {


    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
       
        title: const Text('Thông tin cá nhân', style: AppTextStyles.h2),
        leading: GestureDetector(
          child: IconButtonBack(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Họ và tên', style: AppTextStyles.h4)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                    
                      ),
                    ),
                  )
                ],
              ),
               Column(
                children: [
                  Padding(
                     padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Ngày/tháng/năm sinh', style: AppTextStyles.h4)),
                  ),
                 Container(
                 color: Colors.transparent,
                   width: double.infinity,
                   height: deviceHeight*0.05,
                  
                   child: ElevatedButton(
                    
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                    
                ),
                
                child: Text(getText(), style: AppTextStyles.h4.copyWith(
                    color: Colors.black
                )),
                onPressed: () {
                    selectDate(context);
                }
              ),
                 ),
                 Column(
                   // ignore: prefer_const_literals_to_create_immutables
                   children:[
                     Padding(
                     padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Giới tính', style: AppTextStyles.h4)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Container(
                        decoration: BoxDecoration(
                           border: Border.all(width: 1, color: Color.fromARGB(255, 167, 167, 167)) ,
                           borderRadius: BorderRadius.circular(10)
                        ),
                        width: deviceWidth*0.4,
                        child: ListTile(
            title: const Text('Nam'),
            leading: Radio<Gender>(
              activeColor: AppColors.mainColor,
              value: Gender.nam,
              groupValue: gender,
              onChanged: (Gender? value) {
                setState(() {
                  gender = value;
                });
              },
            ),
          ),
                      ),
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                           border: Border.all(width: 1, color: Color.fromARGB(255, 167, 167, 167)) ,
                           borderRadius: BorderRadius.circular(10)
                        ),
            width: deviceWidth*0.4,
            child: ListTile(
              
              title: const Text('Nữ'),
              leading: Radio<Gender>(
                activeColor: AppColors.mainColor,
                value: Gender.nu,
                groupValue: gender,
                onChanged: (Gender? value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ),
          ),
                    ]
                  ),  
          
                   ],),
        
                   
                 
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Địa chỉ', style: AppTextStyles.h4)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                    
                      ),
                    ),
                  )
                ],),
                 Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  )
            ],

          ),
        ),
      ),

    );
  }
}