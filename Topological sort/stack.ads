with ada.text_io; use ada.text_io;
with unchecked_conversion;

generic
   stack_max : integer;
   type item is private;
package stack is
   procedure set_max (new_max : in integer);
   procedure push (new_item : in item);
   function pop return item;
   function peek return item;
   function is_empty return boolean;
   function is_full return boolean;
   function is_overflow return boolean;
   function is_underflow return boolean;
end stack;
