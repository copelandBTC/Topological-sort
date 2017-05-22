generic
   type element is (<>);        -- element J or K
   NA : integer;                -- Number of action
   trans : integer;             -- Number of transactions
   with procedure get (J, K : out element);
   with procedure put (job : in element);
package top_sort is
   procedure sort;
end top_sort;
