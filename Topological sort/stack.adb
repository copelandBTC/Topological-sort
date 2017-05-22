package body stack is
   max : integer := stack_max;
   top : integer range 0 .. max;
   overflow : boolean := false;
   underflow : boolean := false;
   stack_arr : array (0 .. max) of item;

   procedure set_max (new_max : in integer) is
   begin
      max := new_max;
   end set_max;

   procedure push (new_item : in item) is
   begin
      if (top < max) then
         underflow := false;
         top := top + 1;
         stack_arr (top) := new_item;
      else
         overflow := true;
         new_line;
         put_line("OVERFLOW: Stack is full; cannot add anymore.");
      end if;
   end push;

   function pop return item is
      blank : item;
   begin
      if (top > 0) then
         overflow := false;
         top := top - 1;
         return stack_arr(top + 1);
      else
         underflow := true;
         new_line;
         put_line("UNDERFLOW: Stack is empty; cannot pop anymore.");
         return blank;
      end if;
   end pop;

   function peek return item is
      blank : item;
   begin
      if is_empty then
         return blank;
      else
         return stack_arr (top);
      end if;
   end peek;

   function is_empty return boolean is
   begin
      if (top = 0) then
         return true;
      else
         return false;
      end if;
   end is_empty;

   function is_full return boolean is
   begin
      if (top = max) then
         return true;
      else
         return false;
      end if;
   end is_full;

   function is_overflow return boolean is
   begin
      if (overflow) then
         return true;
      else
         return false;
      end if;
   end is_overflow;

   function is_underflow return boolean is
   begin
      if (underflow) then
         return true;
      else
         return false;
      end if;
   end is_underflow;
end stack;
