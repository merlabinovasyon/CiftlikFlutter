import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBirthBuzagiPage extends StatefulWidget {
  const AddBirthBuzagiPage({super.key});

  @override
  State<AddBirthBuzagiPage> createState() => _AddBirthBuzagiPageState();
}

class _AddBirthBuzagiPageState extends State<AddBirthBuzagiPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _count1Controller = TextEditingController();
  final TextEditingController _count2Controller = TextEditingController();

  String? _selectedAnimal;
  String? _selectedKoc;
  String? _selectedBuzagi;
  String? _selected1Buzagi;
  String? _selected2Buzagi;
  String? _selectedGender1;
  String? _selectedGender2;
  String? _selectedGender3;
  bool _isTwin = false;
  bool _isTriplet = false;

  final List<String> _animals = ['Hayvan 1', 'Hayvan 2', 'Hayvan 3'];
  final List<String> _boga = ['Boğa 1', 'Boğa 2', 'Boğa 3'];
  final List<String> _buzagi = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final List<String> _buzagi1 = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final List<String> _genders = ['Erkek', 'Dişi'];

  @override
  void dispose() {
    _dobController.dispose();
    _timeController.dispose();
    _countController.dispose();
    _count1Controller.dispose();
    _count2Controller.dispose();
    super.dispose();
  }

  void _showSelectionSheet(BuildContext context, String title, List<String> options, Function(String) onSelected) {
    if (title == 'Cinsiyet *') {
      _showSimpleSelectionSheet(context, title, options, onSelected);
      return;
    }

    TextEditingController searchController = TextEditingController();
    List<String> filteredOptions = List.from(options);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            searchController.addListener(() {
              setState(() {
                filteredOptions = options
                    .where((option) => option.toLowerCase().contains(searchController.text.toLowerCase()))
                    .toList();
              });
            });

            bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

            return FractionallySizedBox(
              heightFactor: isKeyboardVisible ? 0.8 : 0.5,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              labelText: 'Filtrelemek için yazmaya başlayın',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredOptions.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shadowColor: Colors.cyan,
                                elevation: 4.0,
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                child: ListTile(
                                  title: Text(filteredOptions[index]),
                                  onTap: () {
                                    onSelected(filteredOptions[index]);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSimpleSelectionSheet(BuildContext context, String title, List<String> options, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 25),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: Colors.cyan,
                            elevation: 4.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            child: ListTile(
                              title: Text(options[index]),
                              onTap: () {
                                onSelected(options[index]);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectionField(String label, String? value, List<String> options, Function(String) onSelected) {
    return InkWell(
      onTap: () {
        _showSelectionSheet(context, label, options, onSelected);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: Icon(Icons.keyboard_arrow_down),
        ),
        child: value == null ? Text('Seç') : Text(value),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    DateTime initialDateTime = DateTime.now();
    if (_timeController.text.isEmpty) {
      _timeController.text =
      "${initialDateTime.hour.toString().padLeft(2, '0')}:${initialDateTime.minute.toString().padLeft(2, '0')}";
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lütfen saat ve dakika seçiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: initialDateTime,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      _timeController.text =
                      "${newDateTime.hour.toString().padLeft(2, '0')}:${newDateTime.minute.toString().padLeft(2, '0')}";
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCounterPicker(BuildContext context, TextEditingController controller) {
    if (controller.text.isEmpty) {
      controller.text = '1';
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lütfen buzağı tipini seçiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      controller.text = (index + 1).toString();
                    });
                  },
                  children: List<Widget>.generate(5, (int index) {
                    return Center(
                      child: Text((index + 1).toString()),
                    );
                  }),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetTwinValues() {
    _selected1Buzagi = null;
    _selectedGender2 = null;
    _count1Controller.clear();
    _resetTripletValues();
  }

  void _resetTripletValues() {
    _selected2Buzagi = null;
    _selectedGender3 = null;
    _count2Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Center(
          child: Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('resimler/logo_v2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.notifications, size: 35),
                onPressed: () {},
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text(
                'Yeni doğan buzağı/buzağılarınızın bilgilerini giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Card(
                shadowColor: Colors.cyan,
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Buzağı ağırlık:  kg',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildSelectionField('Doğuran Hayvan *', _selectedAnimal, _animals, (value) {
                setState(() {
                  _selectedAnimal = value;
                });
              }),
              SizedBox(height: 16),
              _buildSelectionField('Boğanız *', _selectedKoc, _boga, (value) {
                setState(() {
                  _selectedKoc = value;
                });
              }),
              SizedBox(height: 16),
              _buildDateField('Doğum Yaptığı Tarih *', _dobController),
              SizedBox(height: 16),
              _buildTimeField('Doğum Zamanı', _timeController),
              SizedBox(height: 24),
              Text('1. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField('Küpe No *', 'GEÇİCİ_NO_16032'),
              SizedBox(height: 16),
              _buildTextField('Devlet Küpe No *', 'GEÇİCİ_NO_16032'),
              SizedBox(height: 16),
              _buildSelectionField('Irk *', _selectedBuzagi, _buzagi, (value) {
                setState(() {
                  _selectedBuzagi = value;
                });
              }),
              SizedBox(height: 16),
              _buildTextField('Hayvan Adı', ''),
              SizedBox(height: 16),
              _buildSelectionField('Cinsiyet *', _selectedGender1, _genders, (value) {
                setState(() {
                  _selectedGender1 = value;
                });
              }),
              SizedBox(height: 16),
              _buildCounterField('Buzağı Tipi', _countController),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('İkiz', style: TextStyle(fontSize: 18)),
                  Transform.scale(
                    scale: 0.9,
                    child: CustomSwitch(
                      value: _isTwin,
                      onChanged: (value) {
                        setState(() {
                          _isTwin = value;
                          if (!value) {
                            _isTriplet = false;
                            _resetTwinValues();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (_isTwin) ...[
                SizedBox(height: 24),
                Text('2. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                _buildTextField('Küpe No *', ''),
                SizedBox(height: 16),
                _buildTextField('Devlet Küpe No *', 'GEÇİCİ_NO_16032'),
                SizedBox(height: 16),
                _buildSelectionField('Irk *', _selected1Buzagi, _buzagi1, (value) {
                  setState(() {
                    _selected1Buzagi = value;
                  });
                }),
                SizedBox(height: 16),
                _buildTextField('Hayvan Adı', ''),
                SizedBox(height: 16),
                _buildSelectionField('Cinsiyet *', _selectedGender2, _genders, (value) {
                  setState(() {
                    _selectedGender2 = value;
                  });
                }),
                SizedBox(height: 16),
                _buildCounterField('Buzağı Tipi', _count1Controller),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Üçüz', style: TextStyle(fontSize: 18)),
                    Transform.scale(
                      scale: 0.9,
                      child: CustomSwitch(
                        value: _isTriplet,
                        onChanged: (value) {
                          setState(() {
                            _isTriplet = value;
                            if (!value) {
                              _resetTripletValues();
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
              if (_isTriplet) ...[
                SizedBox(height: 24),
                Text('3. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                _buildTextField('Küpe No *', ''),
                SizedBox(height: 16),
                _buildTextField('Devlet Küpe No *', 'GEÇİCİ_NO_16032'),
                SizedBox(height: 16),
                _buildSelectionField('Irk *', _selected2Buzagi, _buzagi1, (value) {
                  setState(() {
                    _selected2Buzagi = value;
                  });
                }),
                SizedBox(height: 16),
                _buildTextField('Hayvan Adı', ''),
                SizedBox(height: 16),
                _buildSelectionField('Cinsiyet *', _selectedGender3, _genders, (value) {
                  setState(() {
                    _selectedGender3 = value;
                  });
                }),
                SizedBox(height: 16),
                _buildCounterField('Buzağı Tipi', _count2Controller),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen $label girin';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.keyboard_arrow_down), // İkon ekleme
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () {
        _showTimePicker(context);
      },
    );
  }

  Widget _buildCounterField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.keyboard_arrow_down), // İkon ekleme
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () {
        _showCounterPicker(context, controller);
      },
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.value ? Colors.cyan : Colors.grey,
          border: Border.all(
            color: widget.value ? Colors.cyan : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  border: Border.all(
                    color: widget.value ? Colors.cyan : Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}