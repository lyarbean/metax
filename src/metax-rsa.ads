with System;
with Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C_Streams;
with Metax.Types;
with Metax.C2a;

package Metax.Rsa is
   pragma Elaborate_Body;
   use Metax.Types;
   use Metax.C2a;
   use Interfaces.C;

   type Rsa is tagged limited private;
   function Create return Rsa;
   function Size (This : in Rsa) return Integer;

private
   type Rsa is tagged limited record
      Context : access Rsa_St;
   end record;
   Error : exception;
end Metax.Rsa;
