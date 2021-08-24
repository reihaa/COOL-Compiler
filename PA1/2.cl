class SortedList inherits IO {
    length : Int;
    firstListMember : ListMember;
    secondListMember : ListMember;
    currListMember : ListMember;
    
    init(a : Int) : SortedList {
        {
        length <- a;
        self;
        }
        
    };
    
    init_members() : SortedList {
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
    
    print() : Bool{
        {
            let u : Int <- 0, mem : ListMember <- firstListMember in {
                while u < length loop
                {
                    out_string("\n");
                   out_int(mem.get_data());
                   mem <- mem.get_next();
                   u <- u+1; 
                }
                pool;
                 out_string("\n");
            };
            true;
        }
    };
    
};
    
class ListMember inherits SortedList{
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
	l : SortedList;
	main(): Object {
		{
            l <- new SortedList;
			l.init(in_int());
            l.init_members();
            l.print();

			}
		};
};

