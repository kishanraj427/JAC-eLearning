import 'package:flutter_test/flutter_test.dart';
import 'package:jac_elearning/models/Subject.dart';

void main() {
  group('Subject Model', () {
    test('should create a Subject with clas and subjectName', () {
      final subject = Subject(clas: '10th', subjectName: 'Mathematics');

      expect(subject.clas, '10th');
      expect(subject.subjectName, 'Mathematics');
    });

    test('should allow updating fields', () {
      final subject = Subject(clas: '9th', subjectName: 'Science');

      subject.clas = '10th';
      subject.subjectName = 'Physics';

      expect(subject.clas, '10th');
      expect(subject.subjectName, 'Physics');
    });

    test('should handle different class formats', () {
      final subjects = [
        Subject(clas: '09th', subjectName: 'Hindi'),
        Subject(clas: '12th/Science', subjectName: 'Chemistry'),
        Subject(clas: '11th/Commerce', subjectName: 'Accountancy'),
        Subject(clas: '11th/Arts', subjectName: 'History'),
      ];

      expect(subjects[0].clas, '09th');
      expect(subjects[1].clas, '12th/Science');
      expect(subjects[2].clas, '11th/Commerce');
      expect(subjects[3].clas, '11th/Arts');
    });
  });
}
