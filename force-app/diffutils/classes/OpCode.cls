public class OpCode {

    public EditType type;
    public Integer sbeg, send;
    public Integer dbeg, dend;

    public override String toString() {
        return type.name() + '(' + sbeg + ',' + send + ','
                + dbeg + ',' + dend + ')';
    }
}
