import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';



  String typingText ="";
  String typedText ="";
  bool equalsPressed = true;
  int leftBracketCount = 0;
  int rightBracketCount = 0;
  bool success = true;
  //  bool showAdditionalContent = false;
  //   bool showItself = true;
  num? result(){
  try {
    print(typingText);

    
    
    String duplicateTest = typingText;
   try {
    if (duplicateTest.contains("%"))
      { 
  List<String> arr = duplicateTest.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));
  List<String> modifiedArr = [];
  int i = 0;

  while (i < arr.length) {
    modifiedArr.add(arr[i]);

    if (arr[i] == "%") {
      modifiedArr[i] = "/100";
      modifiedArr.insert(i-1, "(");
      modifiedArr.add(")");
      
      i +=2; // Skip the newly inserted "(" and ")"
    } else {
      i++;
    }
  }

  duplicateTest = modifiedArr.join();}
  print("duplicate:$duplicateTest");
  duplicateTest=duplicateTest.replaceAll('x', '*').replaceAll('÷', "/");
} catch (e) {
  print(e);
}



    
    String lastElement =duplicateTest[duplicateTest.length-1];
  //checking if last element is a digit and removing if not
   try {
          if (lastElement!=")")
         { int number = int.parse(lastElement);
          print(number); }// This will print 42 as an integer
        } catch (e) {
           // Handle errors if the string is not a valid integer
            var list = duplicateTest.split('');
            list[list.length - 1] = "";
            duplicateTest = list.join();
        }
    // Create a parser
    Parser p = Parser();
    Expression exp = p.parse(duplicateTest);

    // Evaluate the expression
    //ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL,ContextModel());
  if (result == result.toInt()){return result.toInt();}
    
    print(result);
    var ans= result.toStringAsFixed(5);
    result = double.parse(ans);
    success = true;
    return result;
  } catch (e) {
    success = false;
    typedText = "Exp Error";
    print("Error: $e");
    return -0.0;
  }
  }


 // int count = 0;
void main() {
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff2E2F30),
        appBar: AppBar(title: Text("Calculator",style: TextStyle(color: Colors.yellow.shade600),),backgroundColor: Color(0xff2E2F30),elevation: 0,),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: calcDisplay(),
            

            ),
            SizedBox(height: 20,),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                
                decoration: BoxDecoration(
                  color: Color(0xff818181),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(onPressed: (){
                            setState(() {
                              typingText = "";
                              typedText = "";
                              equalsPressed=false;
                            });
                          }, child: Text("AC",style: TextStyle(color: Color(0xff2E2F30),fontSize: 25),),backgroundColor:Colors.yellow.shade600 ,),
                          
                          
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              if (typingText.isNotEmpty && typingText[typingText.length-1]!="%"){
                               //aim encompass number in parenteshis and add % before closing it as % has higher priority than divide
                                //store last element in temporary var 
                                // String t = typingText[typingText.length-1];
                                //  typingText = typingText.substring(0,typingText.length-2);
                                 
                                //  typingText+="(${t}/100)";
                                 typingText += "%";
                              
                              equalsPressed=false;
                              typedText = result().toString();
                              }

                            });
                          }, child: Text("%",style: TextStyle(color: Colors.yellow.shade600,fontSize: 19),),backgroundColor: Color(0xff2E2F30),),
                          
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              if (typingText.isEmpty || typingText[typingText.length-1]=="÷"){}
                              
                              else if( typingText[typingText.length-1]=="x" || typingText[typingText.length-1] =="-"|| typingText[typingText.length-1] == "+"){
                                typingText = "${typingText.substring(0,typingText.length-1)}";
                                if (typingText.isEmpty || typingText[typingText.length-1]=="÷"){}
                                else
                               { typingText+="÷";}
                                }
                                else
                                {
                                  if(equalsPressed){
                                    typingText=typedText+"÷";
                                    typedText = "";
                                  //typingText+="÷";
                                
                                equalsPressed=false;}
                                else
                                {typingText+="÷";}
                                }
                              
                            });
                          }, child: Text("÷",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),
                          
                          FloatingActionButton(onPressed: (){
                            setState(() {
                              if (typingText !="")
                              {typingText = typingText.substring(0,typingText.length-1);
                              equalsPressed=false;
                              if(typingText.isNotEmpty && typingText[typingText.length-1]!="(")
                              {typedText = result().toString();
                              }
                              else
                              {typedText = "";}
                              }
                            });
                          }, child: Text("⌫",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),)//style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.yellow.shade600),shape: MaterialStatePropertyAll(CircleBorder()),padding: MaterialStatePropertyAll(EdgeInsets.all(20))),),
                          
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(onPressed: (){
                            
                            setState(() {
                              
                              typingText += "7";
                              equalsPressed=false;
                              List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));



                              print(parts);
                              //need at least 3 elements for an operation
                              if (parts.length>=3){

                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();
                                  print(typedText);
                                }
                              }
                            });
                            }, child: Text("7",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "8";
                              equalsPressed=false;
                              
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("8",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "9";
                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("9",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          FloatingActionButton(onPressed: (){
                             setState(() {
                             
                              if (typingText.isEmpty || typingText[typingText.length-1]=="x"){}
                              
                              else if( typingText[typingText.length-1]=="÷" || typingText[typingText.length-1] =="-"|| typingText[typingText.length-1] == "+"){
                                typingText = "${typingText.substring(0,typingText.length-1)}";
                                
                                if (typingText.isEmpty || typingText[typingText.length-1]=="x"){}
                                else
                               { typingText+="x";}
                                }
                                else
                                {
                                  if(equalsPressed){
                                    typingText=typedText+"x";
                                    typedText = "";
                                  //typingText+="÷";
                                
                                equalsPressed=false;}
                                else
                                {typingText+="x";}
                                }
                            });
                          }, child: Text("X",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),
                          
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "4";
                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("4",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          
                          
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "5";
                              equalsPressed=false;
                            });
                          }, child: Text("5",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                         
                         
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "6";
                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("6",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                         
                         
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              //
                              if(typingText.isNotEmpty ){
                              if(typingText[typingText.length-1]=="+"){
                                typingText = "${typingText.substring(0,typingText.length-1)}";}}
                                
                                if (typingText.isEmpty || typingText[typingText.length-1]!="-"){
                                typingText+="-";}
                                
                                if (equalsPressed)
                                {typingText = typedText + "-";
                                typedText = "";

                                equalsPressed=false;}
                              
                            });
                          }, child: Text("-",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),
                          
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "1";
                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("1",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          
                          
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "2";
                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("2",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "3";
                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("3",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              if (typingText.isEmpty || typingText[typingText.length-1]=="+"){}
                              else if(typingText.length ==1 && typingText[typingText.length-1]=="-"){ typingText = "";}
                              else 
                              {
                              if( typingText[typingText.length-1]=="-"){
                                typingText = "${typingText.substring(0,typingText.length-1)}";}
                                
                                if (equalsPressed){
                                typingText="${typedText}+";
                                typedText = "";
                                
                                equalsPressed=false;}
                                else
                                {typingText+="+";}
                                }
                            });
                          }, child: Text("+",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),
                          
                        ],
                      ),
                      
                      // Padding(
                      //   padding: const EdgeInsets.only(left:97.0),
                      //   child: Visibility(
                      //     visible: showAdditionalContent,
                      //     child: ButtonBar(
                      //       alignment: MainAxisAlignment.center,
                      //       children: [
                      //         TextButton(onPressed: (){
                      //           setState(() {
                      //             typingText+="(";
                      //             showAdditionalContent = !showAdditionalContent;
                      //             showItself = !showItself;
                      //           });
                      //       }, child: Text("("),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color(0xff2E2F30)),shape: MaterialStatePropertyAll(CircleBorder()),padding: MaterialStatePropertyAll(EdgeInsets.all(20))),),
                      //       TextButton(onPressed: (){
                      //           setState(() {
                      //             typingText+=")";
                      //             showAdditionalContent = !showAdditionalContent;
                      //             showItself = !showItself;
                      //           });
                      //       }, child: Text(")"),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color(0xff2E2F30)),shape: MaterialStatePropertyAll(CircleBorder()),padding: MaterialStatePropertyAll(EdgeInsets.all(20))),),
                      //       ]
                      //     ),
                      //   ),
                      // ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += ".";
                              equalsPressed=false;
                            });
                          }, child: Text(".",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),
                         
                          FloatingActionButton(onPressed: (){
                             setState(() {
                              typingText += "0";

                              equalsPressed=false;
                             List<String> parts = typingText.split(RegExp(r'(?=[+\-x÷%])|(?<=[+\-x÷%])'));

                              print(parts);
                              if (parts.length>=3){
                                String previous_Element =parts[parts.length -2];
                                if ({'+','-','x','÷','%',}.contains(previous_Element)){
                                  typedText = result().toString();}}
                            });
                          }, child: Text("0",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Color(0xff595959),),
                          
                          FloatingActionButton(onPressed: (){
                              setState(() {
                                  if(equalsPressed && {"1","2","3","4","5","6","7","8","9","0",")"}.contains( typingText[typingText.length-1] ))
                                  {typingText = typedText="";}
                                if(typingText.isEmpty || {'+',"-","x","÷","("}.contains(typingText[typingText.length-1]))
                                { typingText += "(";
                                leftBracketCount+=1;}
                                if ( {"1","2","3","4","5","6","7","8","9","0",")"}.contains( typingText[typingText.length-1]) && leftBracketCount!=rightBracketCount)
                                {typingText +=")";}
                               
                                equalsPressed=false;
                                typedText = result().toString();
                              });
                          }, child: Text("()",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),

                          
                          
                          
                          FloatingActionButton(onPressed: (){
                               setState(() {
                                
                                typedText= result().toString();
                                  
                                //if (temp.contains(other))
                             equalsPressed = true ;
                             result();
                             
                            });
                          }, child: Text("=",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25),),backgroundColor: Color(0xff2E2F30),),
                          
                        ],
                        
                      ),
                      
                    ],
                  ),
                ),
              ),
            ))

          ],
        ),
      ),

    );
  }
}

class calcDisplay extends StatefulWidget {
  const calcDisplay({
    super.key,
  });

  @override
  State<calcDisplay> createState() => _calcDisplayState();
}

class _calcDisplayState extends State<calcDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff595959),
       borderRadius: BorderRadius.circular(10) ),
       
        constraints: BoxConstraints(minHeight: 200,minWidth: 400) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Text("$typingText",style: TextStyle(color:(!equalsPressed)? Colors.white:Colors.grey,fontSize:(!equalsPressed)? 40:25,fontWeight: FontWeight.bold,fontFamily:GoogleFonts.roboto().fontFamily) ),
            AnimatedContainer(
              //height: 40;
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              //color: (!equalsPressed) ? Colors.white : Colors.grey,
            ),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: (!equalsPressed) ? Colors.white : Colors.grey,
                fontSize: (!equalsPressed) ? 40 : 25,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.roboto().fontFamily,
              ),
              child: Text("$typingText"),
            ),
            ),
    
    
            SizedBox(height: 20,),
            ///Text("$typedText",style: TextStyle(fontWeight:(equalsPressed)? FontWeight.bold:FontWeight.normal,color:(equalsPressed)? Colors.yellow.shade600:const Color.fromARGB(255, 228, 217, 124),fontSize: (equalsPressed)? 50:25,fontFamily:GoogleFonts.roboto().fontFamily),)
            AnimatedContainer(
              //height: 40,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              //color: (!equalsPressed) ? Colors.white : Colors.grey,
            ),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: (equalsPressed) ? Colors.yellow.shade600 :Color.fromARGB(255, 203, 189, 61),
                fontSize: (equalsPressed) ? 50 : 25,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.roboto().fontFamily,
              ),
              child: Text((typedText!="-0.0")?"$typedText":""),
            ),
            ),
          ],
    
        ),
    
    
      
    );
  }
}

//TextButton calcButton({required String text ,required TextStyle Style,required Color color }) => TextButton(onPressed: (){}, child: Text(text,style: Style,),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(color)),shape: MaterialStatePropertyAll(CircleBorder()),padding: MaterialStatePropertyAll(EdgeInsets.all(20)));
  
