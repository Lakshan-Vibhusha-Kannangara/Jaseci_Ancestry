walker count_number_of_adults {
    // returns the upcoming birthdays of the family
    has anchor counter =0;

    root: take-->node::family_root;
    family_root: take-->node::person;
    person {
            here::get_age_group;
            if (here.age_group=="adult"){
            counter=counter+1;
            }
        }
    with exit {
               std.out(counter);
               report counter;
    }
}