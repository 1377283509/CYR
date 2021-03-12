import 'package:cyr/utils/dialog/show_dialog.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/buttons/normal_button.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:flutter/material.dart';

List<String> medicineList = ["阿替普酶", "尿激酶", "尿激酶原", "替奈普酶", "其它"];

class InputMedicinePage extends StatefulWidget {
  @override
  _InputMedicinePageState createState() => _InputMedicinePageState();
}

class _InputMedicinePageState extends State<InputMedicinePage> {
  TextEditingController _medicineController;
  TextEditingController _dosageController;
  TextEditingController _unitController;

  String _curMedicine;
  @override
  void initState() {
    super.initState();
    _medicineController = TextEditingController();
    _dosageController = TextEditingController();
    _unitController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("用药信息"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMedicineList(),
              Visibility(
                  visible: _curMedicine == "其它", child: _buildInputMedicine()),
              _buildInputDosage(),
              _buildInputUnit(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // 展示药品
  Widget _buildMedicineList() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 24,
        runAlignment: WrapAlignment.start,
        children: medicineList
            .map((e) => FlatButton(
                  child: Text(
                    e,
                    style: TextStyle(
                        color: _curMedicine == e ? Colors.white : Colors.black),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: _curMedicine == e
                      ? Colors.indigo
                      : Colors.grey.withOpacity(0.3),
                  onPressed: () {
                    setState(() {
                      _curMedicine = e;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  // 输入药品名
  Widget _buildInputMedicine() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InputTextTile(
        controller: _medicineController,
        label: "药品名",
        placeHolder: "请输入药品名",
        autoFocus: true,
      ),
    );
  }

  // 计量输入
  Widget _buildInputDosage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InputTextTile(
        controller: _dosageController,
        label: "剂量  (默认：50)",
        placeHolder: "",
        inputType: TextInputType.number,
      ),
    );
  }

  // 单位输入
  Widget _buildInputUnit() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InputTextTile(
        controller: _unitController,
        label: "单位  (默认：mg)",
        placeHolder: "请输入单位",
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 42),
      child: CustomButton(
          onTap: () async {
            if (_curMedicine == "其它") {
              _curMedicine = _medicineController.text;
            }
            // 检查是否为空
            if (_curMedicine == null || _curMedicine.isEmpty) {
              showToast("请选择药品名", context);
              return;
            }
            if (_curMedicine == "其它") {
              showToast("请输入药品名", context);
              return;
            }
            String dosageValue = _dosageController.text;
            int dosage = 50;
            if (dosageValue != null && dosageValue.trim() != "") {
              dosage = int.parse(
                  _dosageController.text.isEmpty ? 50 : _dosageController.text);
            }

            String unit =
                _unitController.text.isEmpty ? "mg" : _unitController.text;
            String info = "$_curMedicine $dosage $unit";
            bool res = await showConfirmDialog(context, "提交确认", content: info);
            if (res) {
              Navigator.pop(context, [info]);
            }
          },
          title: "提交"),
    );
  }
}
