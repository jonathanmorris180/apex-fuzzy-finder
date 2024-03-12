public abstract class BasicAlgorithm implements Applicable {

    private ToStringFunction stringFunction;

    public BasicAlgorithm() {
        this.stringFunction = new DefaultStringFunction();
    }

    public BasicAlgorithm(ToStringFunction stringFunction) {
        this.stringFunction = stringFunction;
    }

    public abstract Integer apply(String s1, String s2, ToStringFunction stringProcessor);

    public Integer apply(String s1, String s2){

        return apply(s1, s2, this.stringFunction);

    }

    public BasicAlgorithm with(ToStringFunction stringFunction){
        setStringFunction(stringFunction);
        return this;
    }

    public BasicAlgorithm noProcessor(){
        this.stringFunction = new NoProcessToStringFunction();
        return this;
    }

    void setStringFunction(ToStringFunction stringFunction){
        this.stringFunction = stringFunction;
    }

    public ToStringFunction getStringFunction() {
        return stringFunction;
    }
}
