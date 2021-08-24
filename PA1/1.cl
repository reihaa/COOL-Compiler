class Main inherits IO {
    pal(s : String) : Bool {
    let i : Int <- 0, j : Int <- 0 in {    
	while j < s.length() loop {
        if s.substr(j,1) = "("
        then i <- i+1
        else if s.substr(j,1) = ")"
        then i <- i-1
        else false
        --out_string("input string is invalid")
        fi fi;
        if i<0
        then false
        else out_string("")
        fi;
        j <- j+1;
       }
   pool;
   if i = 0
   then true
   else false
   fi;
   }
};

    main() : SELF_TYPE {
	{
	    out_string("enter a string\n");
	    if pal(in_string())
	    then out_string("Yes\n")
	    else out_string("No\n")
	    fi;
	}
    };
};
