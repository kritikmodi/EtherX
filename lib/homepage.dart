import 'package:etherx/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;
  bool data = false;
  double sliderValue=50;
  int myAmt=0;
  var myData;

  late Client httpClient;
  late Web3Client ethClient;
  final myAddress = "0x527ebC7Cc0eB1c8581f0AdDc0681DD1917EC709D";

  checkAuthentification() async {
    auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User? firebaseUser = auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => start()));
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    httpClient = Client();
    Web3Client("https://rinkeby.infura.io/v3/bfe0387e65a147efb46dd0e18c16414d", httpClient);
    // print("------------------------------------------------------");
    getBalance(myAddress);
  }

  Future<void> getBalance(String targetAddress)async{
    EthereumAddress adr = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);
    // print("------------------------------------------------------");
    myData = result[0];
    data = true;
    setState((){});
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract: contract , function: ethFunction, params: args);
    // print("------------------------------------------------------");
    return result;
  }

  Future<DeployedContract> loadContract()async{
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0x24EF1ce8B90AE78eB9CA395591a24F9c7a3bD157";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "PKCoin"),EthereumAddress.fromHex(contractAddress));
    // print("------------------------------------------------------");
    return contract;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray200,
        body: ZStack([
          VxBox().orange400.size(context.screenWidth, context.percentHeight*30).make(),

          VStack([
            (context.percentHeight*10).heightBox,
            "\$XCoin".text.xl4.white.bold.center.makeCentered().py16(),
              (context.percentHeight*5).heightBox,
            VxBox(
              child: VStack([
                "Balance".text.gray700.xl2.semiBold.italic.makeCentered(),
                30.heightBox,
                data?"\$$myData".text.bold.xl6.makeCentered():
                CircularProgressIndicator().centered()
              ])
            ).p20.white.size(context.screenWidth, context.percentHeight*20).rounded.shadowXl.make().p16(),
            30.heightBox,

            Slider(
              min: 0,
              max: 100,
              divisions: 100,
              value: sliderValue,
              label: sliderValue.round().toString(),
              onChanged:(newValue)=>
                setState(()=>
                  sliderValue=newValue
              )
            ),
            20.heightBox,
            HStack([

              FlatButton.icon(onPressed: (){}, color : Colors.blue,shape : Vx.withRounded(50.0),icon: Icon(Icons.refresh, color: Colors.white), label: "Refresh".text.white.make()).h(50),
              FlatButton.icon(onPressed: (){}, color : Colors.green,shape : Vx.withRounded(50.0),icon: Icon(Icons.call_received_outlined, color: Colors.white), label: "Deposit".text.white.make()).h(50),
              FlatButton.icon(onPressed: (){}, color : Colors.red,shape : Vx.withRounded(50.0),icon: Icon(Icons.call_made_outlined, color: Colors.white), label: "Withdraw".text.white.make()).h(50),

            ],alignment: MainAxisAlignment.spaceAround,
                axisSize: MainAxisSize.max
            ).p16(),


            100.heightBox,
            HStack([
              RaisedButton(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                onPressed: signOut,
                child: const Text('LOG OUT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              )
            ],
                alignment: MainAxisAlignment.spaceAround,
                axisSize: MainAxisSize.max
            )

          ])
        ])

    );
  }
}
