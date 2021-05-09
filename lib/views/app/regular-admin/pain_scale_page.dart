part of "../../view.dart";

class PainScalePage extends StatefulWidget {

  final String uid;

  const PainScalePage({Key? key, required this.uid}) : super(key: key);

  @override
  _PainScalePageState createState() => _PainScalePageState();
}

class _PainScalePageState extends State<PainScalePage> {

  double _value = 0;
  List<String> _emojis = ['😃','😃','😟','😟','😞','😞','🥺','🥺','😫','😫','🤕','🤕'];
  double _height = 17.5;
  bool overrideFirestoreValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        height: MQuery.height(0.95, context),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Header(
                content: Column(
                  children: [
                    AppBar(
                      leadingWidth: MQuery.width(0.025, context),
                      toolbarHeight: MQuery.height(0.065, context),
                      leading: IconButton(
                        icon: Icon(CupertinoIcons.chevron_left, size: 24),
                        onPressed: (){
                          Get.back();
                        },
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0
                    ),
                    Container(
                      height: MQuery.height(0.15, context),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Font.out(
                            "Pain Scale",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 32,
                            textAlign: TextAlign.start
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Consumer(
                builder: (context, watch, _){

                  final sliderValues = watch(userScaleProvider(widget.uid));

                  print(sliderValues);

                  return sliderValues.when(
                    data: (value){
                      return value.isEmpty
                      ? Center(
                          child: Font.out(
                            "The user haven't input the pain scale",
                            color: Palette.minorTextColor
                          )
                        )
                      : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MQuery.height(0.03, context),
                          vertical: MQuery.height(0.04, context)
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Font.out(
                                "How would you rate your pain right now?",
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              SizedBox(height: _height),
                              Container(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    valueIndicatorColor: Colors.transparent,
                                    valueIndicatorTextStyle: Font.style(
                                      fontSize: 24
                                    )
                                  ),
                                  child: Slider(
                                    label: _emojis[_value.toInt()],
                                    value: overrideFirestoreValue ? _value : value[0],
                                    min: 0.0,
                                    max: 10.0,
                                    onChanged: (value){},
                                    activeColor: Palette.primary,
                                    inactiveColor: Palette.tertiary,
                                    divisions: 10,
                                  ),
                                ),
                              ),
                              Font.out(
                                "Pain level: ${overrideFirestoreValue ? _value : value[0].toString()}",
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              SizedBox(height: MQuery.height(0.05, context)),
                              Font.out(
                                "How would you describe this pain feeling?",
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              SizedBox(height: MQuery.height(0.01, context)),
                              Container(
                                width: double.infinity,
                                child: Linkify(
                                  text: value[1],
                                  textAlign: TextAlign.start,
                                  style: Font.style(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator(backgroundColor: Palette.primary)),
                    error: (_,__) => SizedBox(),
                  );
                }
              ),
            ),
          ])
        )
      )
    );
  }
}