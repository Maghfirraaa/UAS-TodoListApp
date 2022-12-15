import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// import 'Service/Service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.setTheme}) : super(key: key);
  Function setTheme;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  // int count = 0;

  void register(String nama, email, password, BuildContext context) async {
    try {
      var response = await Dio().post('http://10.0.2.2:3000/user',
          data: {"nama": nama, "email": email, "password": password});
      if (response.statusCode == 201) {
        print("Account created successfully");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(setTheme: widget.setTheme)));
      }
    } catch (e) {
      print(e);
    }
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Image.asset(
              'image/image.png',
              width: 156,
              height: 85,
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              'ToDoListApp',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Register to your account',
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controllerName,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid name",
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter your Name ',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerPass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {}

                      // register(controllerName.text, controllerEmail.text,
                      //     controllerPass.text, context);
                      setState(() {
                        try {
                          if (controllerName.text.isNotEmpty &&
                              controllerEmail.text.isNotEmpty &&
                              controllerPass.text.isNotEmpty) {
                            print("proses");
                            register(controllerName.text, controllerEmail.text,
                                controllerPass.text, context);
                          } else {
                            print('fail');
                            final snackBar = SnackBar(
                              backgroundColor: Color.fromARGB(255, 255, 0, 0),
                              content: Text(
                                'Harap lengkapi data',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  color: Colors.white,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } catch (e) {
                          print(e);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already registered?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(setTheme: widget.setTheme)),
                          );
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
