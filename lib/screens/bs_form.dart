import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gemboxapp/models/gem.dart';
import 'package:gemboxapp/themes/color.dart';
import 'package:gemboxapp/widgets/button_filled.dart';
import 'package:gemboxapp/widgets/image_network.dart';
import 'package:gemboxapp/widgets/spacers.dart';
import 'package:remixicon/remixicon.dart';
import 'package:uuid/uuid.dart';

class FormGem extends StatefulWidget {
  final String? id;

  const FormGem({super.key, this.id});

  @override
  State<FormGem> createState() => _FormGemState();
}

class _FormGemState extends State<FormGem> {
  // CONTROLLERS TEXTFIELD
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController secret_ctrl = TextEditingController();
  TextEditingController imageurl_ctrl = TextEditingController();

  // STATES
  String _name = '';
  String _secret = '';
  String _imageurl = '';
  String _type_selected = 'Pin';
  bool secret_visible = false;
  bool positive_button_disabled = true;
  Gem? gem;

  // STATIC
  List<String> types = ['Pin', 'Password', 'Token', 'Coupon', 'Code'];

  // HANDLE INPUT ONCHANGE
  void validateInput(void Function() payload) {
    setState(payload);

    // all inputs are filled
    bool is_validate = (_name.isNotEmpty &&
        _secret.isNotEmpty &&
        _imageurl.isNotEmpty &&
        _type_selected.isNotEmpty);

    setState(() {
      positive_button_disabled = !is_validate;
    });
  }

  // HANDLE SUBMIT
  void submitGem() async {
    // create gem
    if (widget.id == null) {
      Gem newGem = Gem();
      newGem.id = Uuid().v4();
      newGem.name = _name;
      newGem.secret = _secret;
      newGem.imageurl = _imageurl;
      newGem.type = _type_selected;
      newGem.created_at = DateTime.now();
      newGem.created_at = DateTime.now();

      final res = true;

      print(newGem.toJson());

      Fluttertoast.showToast(
          msg: res ? 'SHHH, new Gem added' : 'Something wrong :(');

      // update gem
    } else {
      gem!.name = _name;
      gem!.secret = _secret;
      gem!.imageurl = _imageurl;
      gem!.type = _type_selected;
      gem!.updated_at = DateTime.now();

      final res = true;

      print(gem!.toJson());

      Fluttertoast.showToast(
          msg: res ? 'SHHH, new Gem added' : 'Something wrong :(');
    }
  }

  @override
  void dispose() {
    name_ctrl.dispose();
    secret_ctrl.dispose();
    imageurl_ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
              color: MyColors.SURFACE,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /////// IMAGE VIEW  ///////
              SizedBox(
                width: 140,
                height: 140,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ImageNetwork(_imageurl, 140, 140)),
              ),
              /////// end: IMAGE VIEW ///////

              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                    color: MyColors.WHITE,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /////// INPUT NAME ///////
                    FormGemInput(
                        context,
                        'Name',
                        TextField(
                          controller: name_ctrl,
                          onChanged: (val) => validateInput(() {
                            _name = val;
                          }),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: '...', border: InputBorder.none),
                        )),
                    SeparatorNoMargin(),

                    /////// INPUT SECRET ///////
                    FormGemInput(
                        context,
                        'Secret',
                        TextField(
                          controller: secret_ctrl,
                          onChanged: (val) => validateInput(() {
                            _secret = val;
                          }),
                          style: Theme.of(context).textTheme.bodyMedium,
                          obscureText: !secret_visible,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secret_visible = !secret_visible;
                                  });
                                },
                                child: Icon(
                                  secret_visible
                                      ? Remix.eye_close_fill
                                      : Remix.eye_fill,
                                  color: MyColors.PRIMARY,
                                ),
                              ),
                              hintText: '...',
                              border: InputBorder.none),
                        )),
                    SeparatorNoMargin(),

                    /////// INPUT TYPE ///////
                    FormGemInput(
                        context,
                        'Type',
                        DropdownButtonHideUnderline(
                            child: DropdownButton(
                          style: Theme.of(context).textTheme.bodyMedium,
                          icon: const Icon(
                            Remix.arrow_down_s_line,
                            color: MyColors.BLACK,
                          ),
                          items: types.map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: type == _type_selected
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: MyColors.PRIMARY)
                                    : Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                          value: _type_selected,
                          onChanged: (val) => validateInput(() {
                            _type_selected = val!;
                          }),
                        ))),
                    SeparatorNoMargin(),

                    /////// INPUT IMAGE URL ///////
                    FormGemInput(
                        context,
                        'Image URL',
                        TextField(
                          controller: imageurl_ctrl,
                          onChanged: (val) => validateInput(() {
                            _imageurl = val;
                          }),
                          style: Theme.of(context).textTheme.bodyMedium,
                          minLines: 1,
                          maxLines: 5,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              hintText: '...', border: InputBorder.none),
                        )),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /////// POSITIVE BUTTON ///////
                  Expanded(
                      child: ButtonFilled(context, () {
                    if (!positive_button_disabled) submitGem();
                  }, widget.id == null ? 'Add' : 'Update', MyColors.PRIMARY,
                          MyColors.WHITE,
                          disabled: positive_button_disabled)),
                  Horzspacing(16),

                  /////// NEGATIVE BUTTON ///////
                  ButtonFilled(context, () {
                    Navigator.pop(context);
                  }, 'Back', MyColors.SILVER, MyColors.GRAY)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget FormGemInput(BuildContext ctx, String fieldName, Widget inputField) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            fieldName,
            style: Theme.of(ctx)
                .textTheme
                .bodyLarge
                ?.copyWith(color: MyColors.GRAY),
          ),
        ),
        Expanded(child: inputField)
      ],
    ),
  );
}
