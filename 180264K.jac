
 walker No_OF_Millennials {

   has anchor count =0;

    root: take-->node::family_root;
    family_root: take-->node::person;
     person {
            here::get_age;
          if (here.age>27){
             if(here.age<42){
                     count+=1;
                    }
            }
        }
  with exit {
              std.out(count);
               report count;
     }
 }
