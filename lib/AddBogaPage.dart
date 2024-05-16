import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBogaPage extends StatefulWidget {
  const AddBogaPage({super.key});

  @override
  State<AddBogaPage> createState() => _AddBogaPageState();
}

class _AddBogaPageState extends State<AddBogaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _count1Controller = TextEditingController();
  final TextEditingController _count2Controller = TextEditingController();
  String? _selectedBoga;
  final List<String> _boga = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

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
                        SizedBox(height: 10),
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
                  'Lütfen boğa tipini seçiniz',
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
                'Boğanızın bilgilerini giriniz.',
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
                    'Boğa ağırlık:  kg',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildTextField('Küpe No *', 'GEÇİCİ_NO_16032'),
              SizedBox(height: 16),
              _buildTextField('Devlet Küpe No *', 'GEÇİCİ_NO_16032'),
              SizedBox(height: 16),
              _buildSelectionField('Irk *', _selectedBoga, _boga, (value) {
                setState(() {
                  _selectedBoga = value;
                });
              }),
              SizedBox(height: 16),
              _buildTextField('Hayvan Adı', ''),
              SizedBox(height: 16),
              _buildCounterField('Boğa Tipi', _countController),
              SizedBox(height: 16),
              _buildDateField('Boğanın Kayıt Tarihi *', _dobController),
              SizedBox(height: 16),
              _buildTimeField('Boğanın Kayıt Zamanı', _timeController),
              SizedBox(height: 16),
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