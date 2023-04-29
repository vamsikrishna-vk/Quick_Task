import 'package:flutter/material.dart';
import 'package:quick_task/service/authenticationService.dart';
import 'package:provider/provider.dart';

class LoginComponent extends StatefulWidget {
  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColor),
              controller: emailController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2.0),
                  ),
                  // errorText: emailerror,
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        width: 1.0),
                  ),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.7)),
                  labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.7)),
                  labelText: "Email")),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColor),
              controller: passwordController,
              obscureText: _toggleVisibility,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      width: 1.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _toggleVisibility = !_toggleVisibility;
                    });
                  },
                  icon: _toggleVisibility
                      ? Icon(
                          Icons.visibility_off,
                          color: Colors.deepOrangeAccent.withOpacity(0.5),
                        )
                      : Icon(Icons.visibility, color: Colors.deepOrangeAccent),
                ),
                hintText: '********',
                labelText: 'Password',
                errorText: null,
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              )),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => {
              context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  )
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 14,
              child: (Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Center(
                    child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              )),
            ),
          )
        ],
      ),
    );
  }
}
