import {*} with "./graph.jac";
import {*} with "./180661B.jac";
import {*} with "./180235A.jac";
import {*} with "./180349C.jac";
import {*} with "./180264K.jac";


walker create_familytree {
    // creates a familytree from a json file
    has data_file = "familytree.json";
    has famly_members = [];

    root {
        families = file.load_json(data_file)["families"];
        for family in families {
            spawn here ++> node::family_root(
                id = family["uid"],
                family_name = family["family_name"]
            );
        }
        take-->node::family_root;
    }

    family_root {
        family_id = here.id;
        members = file.load_json(data_file)["members"];
        filtered_members = [];
        for member in members {
            if (member["family_id"] == family_id) {
                filtered_members.list::append(member);
            }
        }
        for member in filtered_members {
            family_member = spawn here +[member]+> node::person(
                id = member["uid"],
                family_id = member["family_id"],
                name = member["name"],
                date_of_birth = member["date_of_birth"],
                profession = member["profession"],
                gender = member["gender"],
                deceased = member["deceased"],
                parents = member["parents"],
                children = member["children"],
                spouse = member["spouse"]
            );
            famly_members.list::append(family_member);
        }
    }

    with exit {
        for member_1 in famly_members {
            for member_2 in famly_members {
                if (member_1.id  == member_2.id): continue;
                if (member_1.spouse == member_2.id and member_2.spouse == member_1.id) {
                    member_1 +[married]+> member_2;
                }
                if (member_1.id in member_2.children): member_1 +[child]+> member_2;
            }
        }
    }
}
walker count_number_of_males {
    // returns the upcoming birthdays of the family
    has anchor male_count =0;

    members = file.load_json(data_file)["members"];
    for member in members {
        if (member["gender"] == "Male") {
            male_count=male_count+1;
        }
    }
    with exit {
        std.out(male_count);
        report male_count;
    }
}



walker find_coming_birthday {
    // returns the upcoming birthdays of the family
    has max_return = 5;
    has anchor birthday_order = [];

    root: take-->node::family_root;
    family_root: take-->node::person;
    person {
        if (!here.deceased) {
            here::get_days_to_birthday;
            here::get_age;
            here::get_age_group;
            birthday_order.l::append([here.days_to_birthday, here.age, here.name,here.age_group]);
        }
    }
    with exit {
        birthday_order = std.sort_by_col(birthday_order, 0);
        birthday_order = birthday_order[0:max_return];
        std.out(birthday_order);
        report birthday_order;
    }
}