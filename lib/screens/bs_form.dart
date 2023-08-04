import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gemboxapp/models/gem.dart';
import 'package:gemboxapp/services/database_gems.dart';
import 'package:gemboxapp/widgets/button_filled.dart';
import 'package:gemboxapp/widgets/image_network.dart';
import 'package:gemboxapp/widgets/spacers.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:uuid/uuid.dart';

import '../themes/theme_color.dart';

class FormGem extends StatefulWidget {
  final String? id;

  const FormGem(this.id, {super.key});

  @override
  State<FormGem> createState() => _FormGemState();
}

class _FormGemState extends State<FormGem> {
  // CONTROLLERS TEXTFIELD
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController identifier_ctrl = TextEditingController();
  TextEditingController secret_ctrl = TextEditingController();
  TextEditingController imageurl_ctrl = TextEditingController();

  // STATES
  String _name = '';
  String _identifier = '';
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
        _identifier.isNotEmpty &&
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
      newGem.id = const Uuid().v4();
      newGem.name = _name;
      newGem.identifier = _identifier;
      newGem.secret = _secret;
      newGem.imageurl = _imageurl;
      newGem.type = _type_selected;
      newGem.created_at = DateTime.now().toString();
      newGem.updated_at = DateTime.now().toString();

      final res = await DatabaseGems.create(newGem);

      Fluttertoast.showToast(
          msg: res ? 'SHHH, new Gem added' : 'Something wrong :(');

      // update gem
    } else {
      gem!.name = _name;
      gem!.identifier = _identifier;
      gem!.secret = _secret;
      gem!.imageurl = _imageurl;
      gem!.type = _type_selected;
      gem!.updated_at = DateTime.now().toString();

      final res = await DatabaseGems.update(gem!);

      Fluttertoast.showToast(
          msg: res ? 'SHHH, Gem updated' : 'Something wrong :(');
    }

    Navigator.pop(context);
  }

  void getGem() async {
    Gem? dat = await DatabaseGems.get(widget.id!);

    if (dat == null) {
      Fluttertoast.showToast(msg: 'Gem not found');
      return;
    }

    name_ctrl.text = dat.name!;
    identifier_ctrl.text = dat.identifier!;
    secret_ctrl.text = dat.secret!;
    imageurl_ctrl.text = dat.imageurl!;

    setState(() {
      gem = dat;
      _name = dat.name!;
      _identifier = dat.identifier!;
      _secret = dat.secret!;
      _imageurl = dat.imageurl!;
      _type_selected = dat.type!;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.id != null) getGem();
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
    final ThemeColor clr = Theme.of(context).extension<ThemeColor>()!;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: clr.SURFACE,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /////// IMAGE VIEW  ///////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ImageNetwork(_imageurl, 140, 140)),
                  ),

                  /////// DATE  ///////
                  if (gem != null)
                    Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                          Text('Created At',
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(
                              DateFormat('dd MMMM yyyy, hh:mm')
                                  .format(DateTime.parse(gem!.created_at!)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: clr.BLACK)),
                          Vertspacing(8),
                          Text('Updated At',
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(
                              DateFormat('dd MMMM yyyy, hh:mm')
                                  .format(DateTime.parse(gem!.updated_at!)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: clr.BLACK))
                        ])),
                ],
              ), /////// end: IMAGE VIEW ///////

              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: clr.WHITE,
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /////// INPUT NAME ///////
                    FormGemInput(
                        context,
                        'Name',
                        TextField(
                          maxLength: 32,
                          controller: name_ctrl,
                          onChanged: (val) => validateInput(() {
                            _name = val;
                          }),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              counterText: '',
                              hintText: '...',
                              border: InputBorder.none),
                        )),
                    SeparatorNoMargin(clr),

                    /////// INPUT IDENTIFIER ///////
                    FormGemInput(
                        context,
                        'Identifier',
                        TextField(
                          maxLength: 32,
                          controller: identifier_ctrl,
                          onChanged: (val) => validateInput(() {
                            _identifier = val;
                          }),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              counterText: '',
                              hintText: '...',
                              border: InputBorder.none),
                        )),
                    SeparatorNoMargin(clr),

                    /////// INPUT SECRET ///////
                    FormGemInput(
                        context,
                        'Secret',
                        TextField(
                          controller: secret_ctrl,
                          maxLength: 16,
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
                                  color: clr.PRIMARY,
                                ),
                              ),
                              counterText: '',
                              hintText: '...',
                              border: InputBorder.none),
                        )),
                    SeparatorNoMargin(clr),

                    /////// INPUT TYPE ///////
                    FormGemInput(
                        context,
                        'Type',
                        DropdownButtonHideUnderline(
                            child: DropdownButton(
                          style: Theme.of(context).textTheme.bodyMedium,
                          icon: Icon(
                            Remix.arrow_down_s_line,
                            color: clr.BLACK,
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
                                        .copyWith(color: clr.PRIMARY)
                                    : Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }).toList(),
                          value: _type_selected,
                          onChanged: (val) => validateInput(() {
                            _type_selected = val!;
                          }),
                        ))),
                    SeparatorNoMargin(clr),

                    /////// INPUT IMAGE URL ///////
                    FormGemInput(
                        context,
                        'Image URL',
                        TextField(
                          controller: imageurl_ctrl,
                          maxLength: 500,
                          onChanged: (val) => validateInput(() {
                            _imageurl = val;
                          }),
                          style: Theme.of(context).textTheme.bodyMedium,
                          minLines: 1,
                          maxLines: 5,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              counterText: '',
                              hintText: '...',
                              border: InputBorder.none),
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
                  }, widget.id == null || gem == null ? 'Add' : 'Update',
                          clr.PRIMARY!, clr.WHITE!,
                          disabled: positive_button_disabled)),
                  Horzspacing(16),

                  /////// NEGATIVE BUTTON ///////
                  ButtonFilled(context, () {
                    Navigator.pop(context);
                  }, 'Back', clr.SILVER!, clr.GRAY!)
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
  final ThemeColor clr = Theme.of(ctx).extension<ThemeColor>()!;

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            fieldName,
            style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(color: clr.GRAY),
          ),
        ),
        Expanded(child: inputField)
      ],
    ),
  );
}
