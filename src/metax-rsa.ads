with Metax.C2a;

package Metax.Rsa is
   pragma Elaborate_Body;
   type Rsa is tagged limited private;
   function Create return Rsa;
   function Size (This : in Rsa) return Integer;

private
   type Rsa is tagged limited record
      Context : access C2a.Rsa_St;
   end record;
end Metax.Rsa;
