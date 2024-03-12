public interface IExtractedResult extends Comparable {
    String getString();
    void setString(String str);
    Integer getScore();
    Integer getIndex();
    String toString();
    Integer compareTo(Object o);
}
