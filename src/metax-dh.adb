with Ada.Streams.Stream_IO;
with Ada.Streams.Stream_IO.C_Streams;
------------------------------------------------------------
--                         MetaX.dh                          --
------------------------------------------------------------
package body MetaX.Dh is
   package assio renames Ada.Streams.Stream_IO;
   package assiocs renames Ada.Streams.Stream_IO.C_Streams;
   package ics renames Interfaces.C_Streams;
   use type ics.FILEs;
   ------------------------------------------------------------
   --                         create                         --
   ------------------------------------------------------------
   function create return dh is
   begin
      return (context => DH_new);
   end create;
   ------------------------------------------------------------
   --                        from_pem                        --
   ------------------------------------------------------------
   function from_pem (path : string) return dh is
      f : assio.file_type;
      r : access ics.FILEs;
   begin
      assio.open(f, assio.in_file, path);
      r := assiocs.C_Stream(f);
      return (context => PEM_read_DHparams(r, null,null,null));
   end from_pem;
end MetaX.Dh;
