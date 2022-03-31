import 'package:flutter/material.dart';

class WhoAmI extends StatefulWidget {
  WhoAmI({Key? key}) : super(key: key);

  @override
  State<WhoAmI> createState() => _WhoAmIState();
}

class _WhoAmIState extends State<WhoAmI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("I am still developing"),
//           Text("""I am ambitious and hardworking student who wants to
// gain experience while studying at University. I'm
// learning Flutter for the past 2 years. I'm very passionate
// about app developing. I create my own flutter projects.
// You can see all of them in my github account. I like to
// learn new things so in my spare time I'm taking extra
// courses about Java Programming. I'm confident in
// frontend and interface design. I can use Mvvm, State
// Management, Firebase, GetX, MobX. I look forward for
// new challenges.
// In the future I see myself as a successful mobile
// developer"""),
        ),
      ),
      
    );
  }
}