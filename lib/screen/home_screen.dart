
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/model/user_model.dart';
import 'package:email_password_login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user=FirebaseAuth.instance.currentUser;
  UserModel userModel=UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get().then((value){
      this.userModel=UserModel.formMap(value.data());
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(20),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget> [
              SizedBox(
                height: 180,
               child:Image.asset("images/face.png",fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20,),
              Text("Welcome Back",
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text("${userModel.firstName} ${userModel.lastName}",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
              Text("${userModel.email}",
                style: TextStyle(
                    color:Colors.black38,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    ),),
              SizedBox(height: 15,),
              ActionChip(
                backgroundColor: Colors.redAccent,
                  label: Text("LogOut"),
                  onPressed:(){
                  loggOut(context);
                  },
              )

          ],
        ),
        ),
      ),
    );
  }
  Future<void> loggOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement
      (MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
}
