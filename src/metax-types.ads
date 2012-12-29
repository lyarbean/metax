with Interfaces;
with Interfaces.C;
package MetaX.Types is
   subtype u08 is interfaces.unsigned_8;
   subtype u16 is interfaces.unsigned_16;
   subtype u32 is interfaces.unsigned_32;
   subtype u64 is interfaces.unsigned_64;
   type byte_array is array (integer range <>) of aliased u08;
   pragma Convention (C, byte_Array);
   for byte_Array'Component_Size use Interfaces.C.char'Size;
end MetaX.Types;
