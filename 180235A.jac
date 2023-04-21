walker find_remaining_years_to_be_80 {
    has max_return = 5;
    has anchor years = [];

    root: take-->node::family_root;
    family_root: take-->node::person;
    person {
        if (!here.deceased) {
            here::get_years_to_eighty;

            years.l::append([here.remaining_years, here.name]);
        }
    }
    with exit {
        years = std.sort_by_col(years, 0);
        years = years[0:max_return];
        std.out(years);
        report years;
    }
}