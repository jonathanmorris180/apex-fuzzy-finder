@isTest
public class EditOpTest {
  @isTest
  static void itCreatesEditOp() {
    EditOp editOp = new EditOp();
    editOp.dpos = 1;
    editOp.spos = 2;
    editOp.type = EditType.INS;
    String stringified = editOp.toString();
    System.assertEquals(
      'INS(2,1)',
      stringified,
      'EditOp was not stringified correctly'
    );
  }
}
