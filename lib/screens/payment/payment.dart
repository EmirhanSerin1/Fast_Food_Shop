import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/order_model.dart';
import 'package:fast_food_shop/models/user.dart';
import 'package:fast_food_shop/providers/auth_provider.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({
    Key? key,
    required this.total,
    required this.country,
    required this.city,
    required this.district,
    required this.street,
    required this.buildingNumber,
    required this.flatNumber,
    required this.other,
  }) : super(key: key);

  final total;

  final String country,
      city,
      district,
      street,
      buildingNumber,
      flatNumber,
      other;

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = true;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<Auth>(context, listen: false).user;
    AsyncSnapshot snapshotGeneral = AsyncSnapshot.waiting();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 247, 247),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Color(0xFFFD6750),
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: CachedNetworkImage(
                      imageUrl:
                          "https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_credit_card/master/example/assets/mastercard.png",
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.red,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: Color(0xFFFD6750),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(user.uid)
                                .collection("singleProducts")
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              snapshotGeneral = snapshot;
                              return Container(
                                margin: const EdgeInsets.all(12),
                                child: const Text(
                                  'Validate',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'halter',
                                    fontSize: 14,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                              );
                            }),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            showAlertdialog(user, snapshotGeneral);
                            // print(name);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter valid cart number");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertdialog(UserModel user, AsyncSnapshot snapshot) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Order Check'),
        content: const Text(
            'Your order in our page now. We are sending as soon as possible'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _sendOrderToFirebase(user, snapshot);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  _sendOrderToFirebase(UserModel user, AsyncSnapshot snapshot) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Order order = Order();
    DateTime now = DateTime.now();
    String time = now.hour.toString() +
        "." +
        now.minute.toString() +
        " " +
        now.day.toString() +
        "/" +
        now.month.toString() +
        "/" +
        now.year.toString();

    Map orderSik = {};

    for (var i = 0; i < snapshot.data.docs.length; i++) {
      DocumentSnapshot ds = snapshot.data.docs[i];
      orderSik[(i + 1).toString()] = {
        "name": ds["productName"],
        "numberOfproduct": ds["numberOfProduct"],
        "extras": ds["extras"],
      };
    }
    String address = "Country: " +
        widget.country +
        ", City: " +
        widget.city +
        ", District: " +
        widget.district +
        ", Street: " +
        widget.street +
        ", BuildingNumber: " +
        widget.buildingNumber +
        ", FlatNumber: " +
        widget.flatNumber +
        ", Other: " +
        widget.other;

    order.orderDate = time;
    order.totalPrice = widget.total;
    order.orders = orderSik;
    order.address = address;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .add(order.toMap())
        .then((value) => _clearProducts(user))
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage())));
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  _clearProducts(UserModel user) async {
    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("singleProducts");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
