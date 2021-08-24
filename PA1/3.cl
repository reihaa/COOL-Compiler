
class List inherits IO {
    length : Int;
    firstListMember : ListMember;
    secondListMember : ListMember;
    currListMember : ListMember;
    
    init(a : Int) : List {
        {
        length <- a;
        self;
        }
        
    };
    
    init_members() : List {
        {
            firstListMember <- (new ListMember).init(in_int());
            currListMember <- firstListMember;
            let i : Int <- 0 in {
                while (i< length-1) loop
                {
                    secondListMember <- (new ListMember).init(in_int());
                    currListMember.dnext(secondListMember);
                    currListMember <- secondListMember;
                    i <- i+1;
                }
                pool;
            };
            self;
        }
    };
    
    print_count() : Bool{
        {
            let count : Int <- 1, u : Int <- 0, mem : ListMember <- firstListMember in {
                while u < length-1 loop
                {
                    if mem.get_data() = mem.get_next().get_data()
                    then count <- count - 1
                    else out_string("")
                    fi;
                    count <- count + 1;
                   mem <- mem.get_next();
                   u <- u+1; 
                }
                pool;
                 out_int(count);
            };
            true;
        }
    };
    
};
    
class ListMember inherits List{
    data : Int;
    next : ListMember;
    pre : ListMember;
    z : Bool;
    init(a : Int) : ListMember{
        {
            data <- a;
            z <- false;
            self;
        }

    };
    
    dnext(b : ListMember): Bool {
        {
            if b.get_data() < self.get_data()
            then {
                let i : Int <- self.get_data() in {
                self.change_data(b.get_data());
                b.change_data(i);
                if self.get_z()
                    then self.get_pre().dnext(self)
                else(out_string(""))
                fi;
                };
                
            }
            else(out_string(""))
            fi;
            next <- b;
            b.set_pre(self);
            true;
        }
    };
    
    get_data() : Int { data };
    
    get_z():Bool{z};
    
    set_pre(d : ListMember) : Bool {
        {
        z <- true;
        pre <- d;
        true;
        }
    };
    get_pre(): ListMember{ pre };
    
    get_next(): ListMember{ next };
    
    change_data(b : Int) : Bool {
        {
        data <- b;
        true;
        }
    };
};



class Main inherits IO {
	l : List;
	main(): Object {
		{
            l <- new List;
			l.init(in_int());
            l.init_members();
            l.print_count();

			}
		};
};

















