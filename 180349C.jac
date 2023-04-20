walker count_number_of_females {
    // returns the upcoming birthdays of the family
    has anchor counter =0;

    root: take-->node::family_root;
    family_root: take-->node::person;
    person {

            if (gender=="females"){
            counter=counter+1;
            }
        }
    with exit {
               std.out(counter);
               report counter;
    }
} 