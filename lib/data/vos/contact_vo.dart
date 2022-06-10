class ContactVO {
  String? id;
  String? profileUrl;
  String? name;
  String? label;
  bool showTopAlphabetBar;
  String? alphabet;
  int? contactsCount;

  ContactVO({
    this.id,
    this.profileUrl,
    this.name,
    this.label,
    this.showTopAlphabetBar = false,
    this.alphabet,
    this.contactsCount,
  });

  @override
  String toString() {
    return 'ContactVO{id: $id, profileUrl: $profileUrl, name: $name, label: $label, showTopAlphabetBar: $showTopAlphabetBar}';
  }
}
