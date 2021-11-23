import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/model/user_model.dart';
import 'package:email_password_login/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //formKey
  final _formKey=GlobalKey<FormState>();

  final _auth =FirebaseAuth.instance;

  //Editing Controller
  final TextEditingController firstNameController=new TextEditingController();
  final TextEditingController lastNameController=new TextEditingController();
  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();
  final TextEditingController conformPasswordController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
   //First name
    final firstNameField=TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regExp=new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return "First Name Cannot be empty";
        }
        if(!regExp.hasMatch(value)){
          return "Enter a Name minimum 3 character";
        }
        return null;

      },
      onSaved: (value){
        firstNameController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          labelText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //Second Name
    final lastNameField=TextFormField(
      autofocus: false,
      controller:lastNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "last Name Cannot be empty";
        }
        return null;
      },
      onSaved: (value){
        lastNameController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          labelText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //Email
    final emailField=TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return "please enter your email";
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+").hasMatch(value)){
          return "please enter valid email";
        }
        return null;
      },
      onSaved: (value){
        emailController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    // Password
    final passwordField=TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value){
        RegExp regExp=new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return "Enter your password";
        }
        if(!regExp.hasMatch(value)){
          return "Enter a valid password minimum 6 character";
        }

      },
      onSaved: (value){
        passwordController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    //Conform Password
    final conformPasswordField=TextFormField(
      autofocus: false,
      controller: conformPasswordController,
      obscureText: true,
      validator: (value){
        if(conformPasswordController.text != passwordController.text)
          {
            return "password don't match";
          }
        return null;
      },
      onSaved: (value){
        conformPasswordController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Conform Password",
          labelText: "Conform Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    //signup button
    final signupButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailController.text, passwordController.text);
        },
        child: Text("SignUp"),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.red,
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            },
        ),

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                    SizedBox(
                      height: 200,
                      child: Image.asset("images/face.png",
                        fit: BoxFit.contain,),

                    ),
                    SizedBox(height: 20.0,),
                    firstNameField,
                    SizedBox(height: 20.0,),
                    lastNameField,
                    SizedBox(height: 20.0,),
                    emailField,
                    SizedBox(height: 20.0,),
                    passwordField,
                    SizedBox(height: 20.0,),
                    conformPasswordField,
                    SizedBox(height: 20.0,),
                    signupButton,
                    SizedBox(height: 20.0,)


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp(String email,String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value)=>{
            postDetailToFirestore()
      }).catchError((e){
         Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailToFirestore()async{
    //calling Firestore
    //calling UserModel
    //sending data to Firestore

    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User? user=_auth.currentUser;
    UserModel userModel=UserModel();
    //Writing all the values
     userModel.email=user!.email;
     userModel.uid=user.uid;
     userModel.firstName=firstNameController.text;
     userModel.lastName=lastNameController.text;
     userModel.password=passwordController.text;

     await firebaseFirestore
         .collection("user")
         .doc(user.uid).set(userModel.toMap());

     Fluttertoast.showToast(msg: "Account Created Sussesfully");

     Navigator.pushAndRemoveUntil(context,
         MaterialPageRoute(builder: (context)=>HomeScreen()),
             (route) => false);

  }


}
