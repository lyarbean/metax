with System;
package body MetaX.Bn is
   function BN_num_bits (a : access constant bignum_st) return int;
   pragma Import (C, BN_num_bits, "BN_num_bits");

   function BN_bin2bn (s : byte_array; len : int; ret : access bignum_st) return access bignum_st;
   pragma Import (C, BN_bin2bn, "BN_bin2bn");

   procedure BN_bn2bin (a : access constant bignum_st; to : in out byte_array);
   pragma Import (C, BN_bn2bin, "BN_bn2bin");

   procedure BN_free (a : access bignum_st);
   pragma Import (C, BN_free, "BN_free");

   procedure BN_clear (a : access bignum_st);
   pragma Import (C, BN_clear, "BN_clear");

   procedure BN_clear_free (a : access bignum_st);
   pragma Import (C, BN_clear_free, "BN_clear_free");

   function bytes_length(number : bignumber) return integer is
   begin
      return integer(BN_num_bits(number.number)+7)/8;
   end bytes_length;

   function to_binary(number : bignumber) return byte_array is
      binary : byte_array (1..bytes_length(number));
   begin
      BN_bn2bin(number.number, binary);
      return binary;
   end to_binary;

   function from_binary(binary: byte_array) return bignumber is
   begin
      return (number => BN_bin2bn(binary, binary'length,null));
   end from_binary;

   procedure clear(number : bignumber) is
   begin
      BN_clear(number.number);  
   end clear;

   procedure free(number : bignumber) is
   begin
      BN_free(number.number);  
   end free;

   procedure clear_free(number : bignumber) is
   begin
      BN_clear_free(number.number);
   end clear_free;
end MetaX.Bn;
