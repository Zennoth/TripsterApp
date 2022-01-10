part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(24),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      Image.asset("assets/images/tripsterlogo.png",
                          height: 150),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlName,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: ctrlPhone,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            if (value.length < 7 || value.length > 14) {
                              return "Phone number isn't valid";
                            } else {
                              return null;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: ctrlEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill this field";
                          } else {
                            if (!EmailValidator.validate(value)) {
                              return "Email isn't valid";
                            } else {
                              return null;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: ctrlPassword,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            suffixIcon: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value.length < 6
                              ? "Password must have at least 6 characters"
                              : null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Users u = new Users(
                                "",
                                ctrlName.text,
                                ctrlPhone.text,
                                ctrlEmail.text,
                                ctrlPassword.text,
                                "",
                                "");
                            await AuthServices.signUp(u).then((value) {
                              if (value == "success") {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    "Register Success", Colors.green);
                                Navigator.pushReplacementNamed(
                                    context, Login.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(value, Colors.blue);
                              }
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please check the fields",
                                backgroundColor: Colors.red);
                          }
                        },
                        icon: Icon(Icons.login_rounded),
                        label: Text("Register"),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF8D2CEE),
                            onPrimary: Colors.white,
                            elevation: 0),
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Login.routeName);
                        },
                        child: Text(
                          '"Already have an account? Login here!"',
                          style:
                              TextStyle(color: Color(0xFF8D2CEE), fontSize: 16),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
