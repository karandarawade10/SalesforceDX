public class fibonacci {
    
    
    public static void fib(integer fin){
        integer a=0; integer b=1;integer c=0;
        For(integer i=0;i<fin;i++){
            
            c=a+b;    // 0+1  1+1   a=1 b=1  //  a=1 b=2  // a=2 b=3
            a=b;
            b=c;
            
            system.debug(c);  //2 
        }
    }
}