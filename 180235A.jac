


// walker find_coming_birthday {
//     // returns the upcoming birthdays of the family
//     has max_return = 5;
//     has anchor birthday_order = [];

//     root: take-->node::family_root;
//     family_root: take-->node::person;
//     person {
//         if (!here.deceased) {
//             here::get_days_to_birthday;
//             here::get_age;
//             birthday_order.l::append([here.days_to_birthday, here.age, here.name]);
//         }
//     }
//     with exit {
//         birthday_order = std.sort_by_col(birthday_order, 0);
//         birthday_order = birthday_order[0:max_return];
//         std.out(birthday_order);
//         report birthday_order;
//     }

// }
