with MetaX.Bn;
with MetaX.Types;
use MetaX.Types;
use MetaX.Bn;

with MetaX.dh;
with Ada.Integer_text_io;
use Ada.Integer_text_io;
procedure MetaX.Test is
   bi : constant byte_array := (1,1,1,1,1,1,3,1,1,1,1,1,1,1,5);
   a : bignumber := from_binary(bi);
   ci : byte_array (1..a.bytes_length);
begin
   put(a.bytes_length);
   ci := to_binary(a);
   a.clear;
   put(ci'length);
   for i in ci'range loop
      put(integer(ci(i)));
   end loop;
   a.free;
end MetaX.Test;

