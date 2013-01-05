with Metax.Types;use Metax.Types;
with Metax.Bn;            use Metax.Bn;
with Metax.Dh;            use Metax.Dh;
with Metax.Sha2;          use Metax.Sha2;
with Metax.Rc4;           use Metax.Rc4;
with Metax.Rsa;           use Metax.Rsa;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Metax.Test is
   I   : Rc;
   Key : Byte_Array (1 .. 8) :=
     (16#1#,
      16#23#,
      16#45#,
      16#67#,
      16#89#,
      16#ab#,
      16#cd#,
      16#ef#);

begin
   I.Setup (Key);
   I.Crypt (Key, Key);
   for J in Key'Range loop
      Byte_Io.Put (Key (J), Base => 16);
   end loop;
   null;
end Metax.Test;
