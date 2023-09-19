enum RadioValue {item1, item2, item3, item4}

class RadioQuestion {
  final String question;
  RadioValue? selectedRadio;

  RadioQuestion(this.question, this.selectedRadio);
}