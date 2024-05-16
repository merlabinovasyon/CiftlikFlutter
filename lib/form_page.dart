import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_provider.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Örneği'),
      ),
      body: PageView(
        controller: provider.pageController,
        onPageChanged: (index) {
          provider.currentPage = index; // Setter kullanarak currentPage'i güncelle
        },
        children: [
          FormStep(
            icon: Icons.person,
            title: 'Adım 1',
            content: Step1Content(), isLastStep: true,isFirstStep: true,
          ),
          FormStep(
            icon: Icons.info,
            title: 'Adım 2',
            content: Step2Content(), isLastStep: true,isFirstStep: false,
          ),
          FormStep(
            icon: Icons.check,
            title: 'Adım 3',
            content: Step3Content(), isLastStep: false, isFirstStep: false,
          ),
        ],
      ),
    );
  }
}

class FormStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget content;
  final bool isFirstStep;
  final bool isLastStep;

  FormStep({
    required this.icon,
    required this.title,
    required this.content,
    required this.isFirstStep,
    required this.isLastStep,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.blue),
          SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 32),
          content,
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: isFirstStep ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
            children: [
              if (!isFirstStep)
                ElevatedButton(
                  onPressed: () {
                    provider.previousPage();
                  },
                  child: Text('Önceki'),
                ),
              if (isLastStep)
                ElevatedButton(
                  onPressed: () {
                    provider.nextPage();
                  },
                  child: Text('Sonraki'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}



class Step1Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              CheckboxListTile(
                title: Text('Agree to terms'),
                value: false,
                onChanged: (value) {
                  // Checkbox durumunun değişmesi durumunda yapılacak işlemler
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Form gönderme butonuna basıldığında yapılacak işlemler
                },
                child: Text('Kaydol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Step2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Burası adım 2 içeriği');
  }
}

class Step3Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Burası adım 3 içeriği');
  }
}
