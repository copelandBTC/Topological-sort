with top_sort;
with ada.text_io; use ada.text_io;

procedure main is
   -- For indexing purposes, I've placed a dummy at position 0
   type names is (Dummy, Tom, Bob, Sam, Joe, Betty, Mary);

   NA : integer;
   trans : integer;
   quit : natural range 0 .. 1 := 0;

   package int_io is new ada.text_io.integer_io (integer); use int_io;
   package names_io is new ada.text_io.enumeration_io (names); use names_io;

   procedure put_elem (name : in names) is
   begin
      new_line;
      put (name);
      new_line;
   end put_elem;

   procedure get_elem (J, K : out names) is
   begin
      new_line;
      put_line ("Please enter a preceeding name J, followed by a succeeding name K from the list below: ");
      new_line;
      put_line ("Tom, Bob, Sam, Joe, Betty, Mary");
      new_line;
      names_io.get (J);
      names_io.get(K);
      new_line;
   end get_elem;
begin
   new_line;
   put_line ("B OPTION: As there was no C data listed and no directive to do the D option, the following is strictly the B option data, as specified in the instructions.");
   new_line;

   while quit = 0 loop
      new_line;
      put_line ("How many tasks are there?");
      new_line;
      get (NA);

      new_line;
      put_line ("How many transactions are there?");
      new_line;
      get (trans);
      declare
         package sorter is new top_sort (names, NA, trans, get_elem, put_elem); use sorter;
      begin
         sorter.sort;

         new_line;
         put_line ("Would you like to go again? Enter '0' for yes, '1' for no: ");
         new_line;

         int_io.get (quit);

         if quit = 1 then
            new_line;
            put_line ("Program terminated.");
            new_line;

            exit;
         end if;
      end;
   end loop;
end main;
