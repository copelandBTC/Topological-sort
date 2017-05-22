with ada.text_io; use ada.text_io;
with ada.unchecked_conversion;

package body top_sort is
   type node;
   type node_ptr is access node;
   type node is tagged record
      suc : element;
      next : node_ptr;
   end record;

   type job_element is record
      count : integer := 0;
      top : node_ptr := null;
   end record;

   sort_struct : array (0 .. NA) of job_element;
   function int_to_elem is new ada.unchecked_conversion (integer, element);
   function elem_to_int is new ada.unchecked_conversion (element, integer);
   package int_io is new ada.text_io.integer_io(integer); use int_io;
   package elem_io is new ada.text_io.enumeration_io(element); use elem_io;

   procedure sort is
      P : node_ptr := new node;
      KN : integer;
      J : element;
      K : element;
      job_e : job_element;
      R : integer;
      F : integer;
      i : integer;                 -- counter for step 7
   begin
      -- Initialization
      KN := NA;
      for i in 1 .. NA loop
         sort_struct(i) := job_e;
      end loop;

      -- Part 2
      for i in 1 .. trans loop
         get(J, K);
         sort_struct(elem_to_int(K)).count := sort_struct(elem_to_int(K)).count + 1;
         P := new node;
         P.suc := K;
         P.next := sort_struct(elem_to_int(J)).top;
         sort_struct (elem_to_int(J)).top := P;
      end loop;

      -- Initialize output queue
      R := 0;
      sort_struct(0).count := 0;

      for i in 1 .. NA loop
         if sort_struct(i).count = 0 then
            sort_struct(R).count := i;
            R := i;
         end if;
      end loop;
      F := sort_struct(0).count;

      -- Part 4
      while F /= 0 loop
         -- Perform action F
         new_line;
         elem_io.put (int_to_elem(F));
         new_line;

         KN := KN - 1;
         P := sort_struct(F).top;
         sort_struct(F).top := null;

         while P /= null loop
            sort_struct (elem_to_int(P.suc)).count := sort_struct (elem_to_int(P.suc)).count - 1;
            if sort_struct(elem_to_int(P.suc)).count = 0 then
               sort_struct (R).count := elem_to_int (P.suc);
               R := elem_to_int (P.suc);
            end if;
            P := P.next;
         end loop;
         F := sort_struct(F).count;
      end loop;

      -- Part 5
      if KN = 0 then
         new_line;
         put_line ("Sorting is complete! No loops detected.");
         new_line;
         return;
      else
         new_line;
         put_line ("Loop detected!");
         new_line;

         for i in 1 .. NA loop
            sort_struct(i).count := 0;
         end loop;
      end if;

      -- Part 6
      for i in 1 .. NA loop
         P := sort_struct(i).top;
         sort_struct(i).top := null;
         while (P /= null) and then (sort_struct (elem_to_int(P.suc)).count = 0) loop
            sort_struct (elem_to_int(P.suc)).count := i;
            if P /= null then
               P := P.next;
            end if;
         end loop;
      end loop;

      -- Part 7
      i := 1;
      while sort_struct(i).count = 0 and then i < NA loop
         i := i + 1;
      end loop;

      -- Part 8
      loop
        P := new node;
         sort_struct(i).top := P;
         i := sort_struct(i).count;
         if sort_struct(i).top /= null then
            exit;
         end if;
      end loop;

      -- Part 9
      new_line;
      put_line ("Contents of the loop: ");
      while sort_struct(i).top /= null loop
         new_line;
         elem_io.put (int_to_elem(i));
         new_line;

         sort_struct(i).top := null;
         i := sort_struct(i).count;
      end loop;
   end sort;
end top_sort;
