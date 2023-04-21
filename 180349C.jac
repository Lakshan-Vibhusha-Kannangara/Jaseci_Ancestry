
walker count_number_of_males {

     has anchor male_count =0;

     members = file.load_json(data_file)["members"];
    for member in members {
      if (member["gender"] == "Female") {
            male_count=male_count+1;
         }
     }
    with exit {
        std.out(male_count);
         report male_count;
    }
 }
