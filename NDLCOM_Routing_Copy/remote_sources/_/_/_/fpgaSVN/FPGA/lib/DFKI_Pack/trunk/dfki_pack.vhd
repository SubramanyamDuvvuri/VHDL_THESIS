--! @file dfki_pack.vhd
--! @defgroup group_vhdl_packages VHDL-Packages
--! @addtogroup group_vhdl_packages
--! @{
--!
--! @brief DFKI VHDL Package
--!
--! This package provides some standard functions which are often used in FPGA projects.
--! To include this package in your design, add the following lines to the libraries section of your
--! vhdl file:\n\n
--! <code>
--! > library work \n
--! > use work.dfki_pack.all;
--! </code>
--! \n\n
--! <small>
--! Copyright (c): German Research Center for Artificial Intelligence (DFKI)\n
--! Project: All
--! </small>
---------------------------------------------------------------------------------
--! $LastChangedRevision:: 3789                                                $:
--! $LastChangedBy:: hhanff                                                    $:
--! $LastChangedDate:: 2015-01-21 13:02:05 +0100 (Wed, 21 Jan 2015)            $:
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

package dfki_pack is
  constant DEBUG_DFKI_PACK_C : boolean := not false;
  --constant DEBUG_DFKI_PACK_C  : boolean := not true;

  type byte_array_t is array (natural range <>) of std_logic_vector(7 downto 0);


--! @brief detects positive edges
  --!
  --! To detect positive edges on a signal other than a clock signal, this function can be used.
  --! Input is a 2 bit wide std_logic_vector. \n
  --! This function has to be called from within a process in the following way:
  --! <code>
  --! output_s <= detect_pos_edge_func(input_s);\n
  --! </code>
  --! \n The signal input_s contains 2 bits. Bit 0 is the undelayed input signal. Bit 1 is the input
  --! signal delayed by 1 clock cycle. Inside this function both bits are anded:\n
  --! <code>
  --! signal_s(0) and not signal_s(1);
  --! </code>
  function detect_pos_edge_func (
    signal signal_s : std_logic_vector(1 downto 0))
    return std_logic;
  --! Same as the detect_pos_edge_func function, but detects negative edges.
  function detect_neg_edge_func (
    signal signal_s : std_logic_vector(1 downto 0))
    return std_logic;

  --! This function increments a std_ulogic vector by '1'. The function was created due to the fact
  --! incrementing a std_logic_vector using the numeric_std library is hard to read and annyoing to
  --! write.
  function incr_f (arg1 : std_ulogic_vector) return std_ulogic_vector;
  --! This function decrements a std_ulogic vector by '1'. The function was created due to the fact
  --! incrementing a std_logic_vector using the numeric_std library is hard to read and annyoing to
  --! write.
  function decr_f (arg1 : std_ulogic_vector) return std_ulogic_vector;
  --! This function increments a std_logic vector by '1'. The function was created due to the fact
  --! incrementing a std_logic_vector using the numeric_std library is hard to read and annyoing to
  --! write.
  function incr_f (arg1 : std_logic_vector) return std_logic_vector;
  --! This function decrements a std_logic vector by '1'. The function was created due to the fact
  --! incrementing a std_logic_vector using the numeric_std library is hard to read and annyoing to
  --! write.
  function decr_f (arg1 : std_logic_vector) return std_logic_vector;

  --! The following functions subtract arg2 from arg1
  --! result = arg1 - arg2
  --! or add arg2 and arg1.
  --! result = arg1 + arg2
  --! The functions were created due to the fact that adding / subtracting std_logic_vectors using
  --! the numeric_std library is hard to read and annyoing to write.
  function unsigned_sub_f (arg1 : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector;
  function signed_sub_f (arg1   : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector;
  function unsigned_add_f (arg1 : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector;
  function signed_add_f (arg1   : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector;

--! @brief Turns revision strings to std_logic vectors
  --!
  --! The following types and functions are supposed to convert an svn revision string into an \n
  --! array of 8-Bit characters.\n
  --! To use this, declare the following constant in your design:\n
  --! <code>
  --!   constant REVISION_C : string(1 to REVISION_STRING_LENGTH_C) := "$Rev           $"; -- 16
  --! chars between '"' and '"'
  --! </code>
  --! \n and enable the corresponding svn property for that file:\n
  --! <code>
  --! > svn propset svn:keywords "Revision" ./<your_design_name>.vhd
  --! </code>
  --! \n In your top level vhdl module you need to declare the following signal:\n
  --! <code>
  --!   signal revision_vec_s : char_array_t; -- See sheet_metal_hand_top.vhd
  --! for an example
  --! </code>
  --! \n which can then be used to store the revision string:\n
  --! <code>
  --!   revision_vec_s <= str2std(REVISION_C);
  --! </code>
  --! \n Now you might want to send this string via UART, CAN, ...\n
  --! The length of the revision string is set to 16 characters.\n
  constant REVISION_STRING_LENGTH_C : positive := 16;
  --! The character type
  subtype char_t is std_logic_vector (7 downto 0);
  --! An array of characters in  std_logic_vector format
  type char_array_t is array (natural range <>) of char_t;
  --! Converts characters to std_logic_vectors
  function char2std (c              : character) return std_logic_vector;
  --! Converts strings to std_logic_vectors
  function str2std(data             : string) return char_array_t;

  --! @brief converts std_logic in std_logic_vector(0 downto 0) and vice versa
  function vectorize(s : in std_logic) return std_logic_vector;
  function scalarize(v : in std_logic_vector) return std_logic;

  --! Returns the first bit of a std_logic_vector whicht is set to '1'
  function decode_bit_position_f (sig : std_logic_vector) return natural;

  --! Implementation of a low pass filter as a function.
  --! Be carefull. If you use this in synthesized code, you should take care
  --! that the "OLD_VALUE_WEIGHT_C" constant is not too high as this would result
  --! in giant std_logic_vectors.
  function lowpass_filter_f (
    constant OLD_VALUE_WEIGHT_C : in integer;  -- The weight for the old value
    old_value                   : in std_logic_vector;  -- The old value
    sample                      : in std_logic_vector)  -- The new sample
    return std_logic_vector;            -- The output of the filter.

  function to_slv(Arg  : integer; Length : integer) return std_logic_vector;
  function to_uint(Arg : std_logic_vector) return integer;
  --function to_sslv(Arg : integer; Length : integer) return std_logic_vector;
  function to_sint(Arg : std_logic_vector) return integer;

  -- Purpose: The default resize function from numeric_std truncates the leftmost
  -- bits when assigning a larger unsigned to a smaller unsigened. This is not
  -- always desired. This function will look at the bits which have no space in
  -- the target vector. If those bits are /= 0, the target vector will be set to
  -- all '1'. If the uppermost bits are = 0, the LSBs are assigned.
  function resize_to_smaller_vector (Arg : unsigned; NEW_SIZE : natural) return unsigned;

  -- Purpose: Reflects the bits in a slv. The MSBit of Arg will be the LSBit of
  -- the returned vector
  function rev_slv_bitwise (constant Arg      : std_logic_vector) return std_logic_vector;
  -- Purpose: Reflects the bytes in a slv. The MSByte of Arg will be the LSByte of
  -- the returned vector
  function rev_slv_bytewise (constant Arg     : std_logic_vector) return std_logic_vector;
  -- Purpose: Reflects the bits inside the bytes in a slv. The MSBit of MSByte of Arg will be the
  -- LSBit of the MSByte of the returned vector
  function rev_slv_bits_in_byte (constant Arg : std_logic_vector) return std_logic_vector;
  -- Purpose: ?
  function reflect_bits (constant Arg         : std_logic_vector; constant Length : integer) return std_logic_vector;

  function to_std_logic_f (constant int   : integer) return std_logic;
  function to_std_logic_f (constant const : boolean) return std_logic;
  function to_boolean_f (constant const   : std_logic) return boolean;
  function to_int_f (constant const       : boolean) return integer;

  function hex_to_bin (constant hex : character) return integer;

end package dfki_pack;

package body dfki_pack is

  -- purpose: detect positive edges on signals
  function detect_pos_edge_func (
    signal signal_s : std_logic_vector(1 downto 0))
    return std_logic is
  begin  -- detect_pos_edge_func
    return signal_s(0) and not signal_s(1);
  end detect_pos_edge_func;

  -- purpose: detect negative edges on signals
  function detect_neg_edge_func (
    signal signal_s : std_logic_vector(1 downto 0))
    return std_logic is
  begin  -- detect_neg_edge_func
    return not signal_s(0) and signal_s(1);
  end detect_neg_edge_func;

  function incr_f (Arg1 : std_ulogic_vector) return std_ulogic_vector is
  begin
    return std_ulogic_vector(unsigned(Arg1) + 1);
  end incr_f;

  function decr_f (Arg1 : std_ulogic_vector) return std_ulogic_vector is
  begin
    return std_ulogic_vector(unsigned(Arg1) - 1);
  end decr_f;

  function incr_f (Arg1 : std_logic_vector) return std_logic_vector is
  begin
    return std_logic_vector(unsigned(Arg1) + 1);
  end incr_f;

  function decr_f (Arg1 : std_logic_vector) return std_logic_vector is
  begin
    return std_logic_vector(unsigned(Arg1) - 1);
  end decr_f;

  function unsigned_sub_f (Arg1 : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector is
  begin
    return std_logic_vector(unsigned(Arg1) - unsigned(Arg2));
  end unsigned_sub_f;

  function signed_sub_f (Arg1 : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector is
  begin
    return std_logic_vector(unsigned(Arg1) - unsigned(Arg2));
  end signed_sub_f;

  function unsigned_add_f (Arg1 : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector is
  begin
    return std_logic_vector(unsigned(Arg1) + unsigned(Arg2));
  end unsigned_add_f;

  function signed_add_f (Arg1 : std_logic_vector; arg2 : std_logic_vector) return std_logic_vector is
  begin
    return std_logic_vector(unsigned(Arg1) + unsigned(Arg2));
  end signed_add_f;

  function char2std (c : character) return std_logic_vector is
    variable Return_Value : std_logic_vector(7 downto 0);
  begin
    Return_Value := std_logic_vector(to_unsigned(character'pos (c), Return_Value'length));
    return(Return_Value);
  end char2std;

  function str2std (data : string) return char_array_t is
    variable result : char_array_t(0 to data'length-1);
    variable j      : integer;
  begin
    j := data'length -1;
    for i in data'range loop
      result(j) := char2std(data(i));
      j         := j -1;
    end loop;
    return result;
  end function;

  function vectorize(s : in std_logic) return std_logic_vector is
    variable v : std_logic_vector(0 downto 0);
  begin
    v(0) := s;
    return v;
  end;

  function scalarize(v : in std_logic_vector) return std_logic is
  begin
    assert (v'length = 1)
      report("scalarize: output must be single bit!")
      severity failure;
    return v(v'left);
  end;


-- purpose: Returns the position of the leftmost '1' in a std_logic_vector
--          When no '1' was found the function will return 0. Thus an input vector of
--          "0010" would return 2..
-- inputs : std_logic_vector, rst_s
-- outputs:
  function decode_bit_position_f (sig : std_logic_vector) return natural is
    variable var_v          : std_logic_vector(sig'range)       := sig;
    variable bit_position_v : natural range sig'high+1 downto 0 := 0;

  begin
    assert DEBUG_DFKI_PACK_C report "decode_bit_position_f: started! " severity note;
    if to_integer(unsigned(var_v)) = 0 then
      assert DEBUG_DFKI_PACK_C report "decode_bit_position_f: parameter is 0! " severity note;
      return 0;
    end if;

    assert DEBUG_DFKI_PACK_C report "decode_bit_position_f: Starting decode process" severity note;
--    while var_v /= (var_v'range others => 0) loop -- This does not work here... why?
--    while to_integer(unsigned(var_v)) /= 0 loop  -- This won't work because integer has to be < 2**32!
    while unsigned(var_v) /= 0 loop
      assert DEBUG_DFKI_PACK_C report "decode_bit_position_f: Shifted one time" severity note;
      bit_position_v := bit_position_v + 1;
--      var_v          := std_logic_vector(unsigned(var_v) srl 1);
      var_v          := std_logic_vector(unsigned(var_v) / 2);  -- shift right one bit
    end loop;
    assert DEBUG_DFKI_PACK_C report "decode_bit_position_f: Finished decode process" severity note;

    return bit_position_v;
  end;

  function lowpass_filter_f (constant OLD_VALUE_WEIGHT_C : in integer; old_value : in std_logic_vector; sample : in std_logic_vector) return std_logic_vector is
    variable sum1 : std_logic_vector(sample'length + integer(ceil(log2(real(OLD_VALUE_WEIGHT_C)))) -1 downto 0);
    variable sum2 : std_logic_vector(sample'length + integer(ceil(log2(real(OLD_VALUE_WEIGHT_C)))) -1 downto 0);
    variable sum3 : std_logic_vector(sample'length + integer(ceil(log2(real(OLD_VALUE_WEIGHT_C)))) -1 downto 0);
  begin
    --  pragma translate_off
    assert DEBUG_DFKI_PACK_C report "old_value " & integer'image(to_integer(unsigned(old_value)));
    assert DEBUG_DFKI_PACK_C report "sample " & integer'image(to_integer(unsigned(sample)));
    -- pragma translate_on
    -- Weight the old value
    sum1 := std_logic_vector(resize((OLD_VALUE_WEIGHT_C-1)*unsigned(old_value), sum1'length));
    --  pragma translate_off
    assert DEBUG_DFKI_PACK_C report "sum1 " & integer'image(to_integer(unsigned(sum1)));
    -- pragma translate_on
    -- Add the new value
    sum2 := std_logic_vector(unsigned(sum1) + unsigned(sample));
    -- pragma translate_off
    assert DEBUG_DFKI_PACK_C report "sum2 " & integer'image(to_integer(unsigned(sum2)));
    -- pragma translate_on
    -- Devide by weight to reduce size
    sum3 := std_logic_vector(unsigned(sum2) / OLD_VALUE_WEIGHT_C);
    -- pragma translate_off
    assert DEBUG_DFKI_PACK_C report "sum3 " & integer'image(to_integer(unsigned(sum3)));
    -- pragma translate_on
    return sum3;
  end;

  function to_slv(Arg : integer; Length : integer) return std_logic_vector is
  begin
    return std_logic_vector(to_unsigned(Arg, Length));
  end to_slv;

  function to_uint(Arg : std_logic_vector) return integer is
  begin
    return to_integer(unsigned(Arg));
  end to_uint;

  --function to_sslv(Arg : integer; Length : integer) return std_logic_vector is
  --begin
  --  return std_logic_vector(to_signed(Arg, Length));
  --end to_sslv;

  function to_sint(Arg : std_logic_vector) return integer is
  begin
    return to_integer(signed(Arg));
  end to_sint;

  function resize_to_smaller_vector (
    Arg      : unsigned;
    NEW_SIZE : natural)
    return unsigned is
    constant ARG_LEFT                    : integer                       := ARG'length-1;
    alias XARG                           : unsigned(ARG_LEFT downto 0) is ARG;
    variable RESULT                      : unsigned(NEW_SIZE-1 downto 0) := (others => '0');
    -- Exemplar synthesis directives :
    attribute SYNTHESIS_RETURN of RESULT : variable is "FEED_THROUGH";
  begin  -- function resize_to_smaller_vector
    --if (NEW_SIZE < 1) then return (others => '0');
    --end if;
    --if ARG_LEFT = 0 then return RESULT;
    --end if;
    if (NEW_SIZE < ARG'length) then
      if unsigned(XARG(XARG'left downto ARG'left+1)) /= 0 then
        RESULT := (others => '1');
      else
        RESULT(RESULT'left downto 0) := XARG(RESULT'left downto 0);
      end if;
    else
    --Not defined. Use numeric_std resize funcion
    end if;
    return RESULT;

  end function resize_to_smaller_vector;

  function rev_slv_bitwise (constant Arg : std_logic_vector)
    return std_logic_vector is
    variable result : std_logic_vector(Arg'range) := (others => '0');
  begin  -- function rev_slv_bitwise
    if Arg'length mod 2 /= 0 then
      report "rev_slv_bitwise: Arg'length must be a multiple of 2!"
        severity failure;
    --severity warning;
    end if;

    for i in Arg'range loop
      result(result'left-i) := Arg(i);
    end loop;  -- i
    return result;
  end function rev_slv_bitwise;

  function rev_slv_bytewise (constant Arg : std_logic_vector)
    return std_logic_vector is
    variable result : std_logic_vector(Arg'range) := (others => '0');
  begin  -- function rev_slv_bytewise
    if Arg'length mod 8 /= 0 then
      report "rev_slv_bytewise: Arg'length must be a multiple of 8!"
        severity failure;
    --severity warning;
    end if;

    for i in Arg'length/8-1 downto 0 loop
      result(((i+1)*8)-1 downto ((i+1)*8)-8) := Arg(Arg'length-i*8-1 downto Arg'length-i*8-8);
    end loop;
    return result;
  end function rev_slv_bytewise;

  function rev_slv_bits_in_byte (constant Arg : std_logic_vector)
    return std_logic_vector is
    variable result : std_logic_vector(Arg'range)  := (others => '0');
    variable byte   : std_logic_vector(7 downto 0) := (others => '0');
  begin  -- function rev_slv_bytewise
    if Arg'length mod 8 /= 0 then
      report "rev_slv_bits_in_byte: Arg'length must be a multiple of 8!"
        severity failure;
    --severity warning;
    end if;

    for i in Arg'length/8-1 downto 0 loop
      byte                                   := Arg(((i+1)*8)-1 downto ((i+1)*8)-8);
      result(((i+1)*8)-1 downto ((i+1)*8)-8) := rev_slv_bitwise(byte);
    end loop;
    return result;
  end function rev_slv_bits_in_byte;

  function reflect_bits (constant Arg : std_logic_vector; constant Length : integer)
    return std_logic_vector is
    variable result : std_logic_vector(Arg'range)         := (others => '0');
    variable byte   : std_logic_vector(7 downto 0)        := (others => '0');
    variable j      : std_logic_vector(Length-1 downto 0) := (others => '0');
    variable i      : std_logic_vector(Length-1 downto 0) := (others => '0');
  begin  -- function rev_slv_bytewise
    --if Arg'length mod 8 /= 0 then
    --  report "rev_slv_bits_in_byte: Arg'length must be a multiple of 8!"
    --    severity failure;
    ----severity warning;
    --end if;

    j(0)        := '1';
    i(length-1) := '1';
    while to_integer(unsigned(i)) /= 1 loop
      if to_integer(unsigned((Arg and i))) /= 0 then
        result := result or j;
      end if;
      j := std_logic_vector(unsigned(j) sll 1);
      i := std_logic_vector(unsigned(i) srl 1);
    end loop;

    return result;
  end function reflect_bits;

  -- Converts an ingeter (0 or 1) value to a std_logic.
  function to_std_logic_f (constant int : integer) return std_logic is
  begin
    case int is
      when 0 =>
        return '0';
      when 1 =>
        return '1';
      when others =>
        return '-';
    end case;
    return '-';
  end;

  -- Converts a boolean (0 or 1) value to a std_logic.
  function to_std_logic_f (constant const : boolean) return std_logic is
  begin
    case const is
      when true =>
        return '1';
      when false =>
        return '0';
      when others =>
        return '-';
    end case;
    return '-';
  end;

  -- Converts a std_logic ('0' or '1') value to a boolean value
  function to_boolean_f (constant const : std_logic) return boolean is
  begin
    case const is
      when '0' =>
        return false;
      when '1' =>
        return true;
      when others =>
        return false;
    end case;
    return false;
  end;

  -- Converts an boolean (0 or 1) value to a std_logic.
  function to_int_f (constant const : boolean) return integer is
  begin
    case const is
      when true =>
        return 1;
      when false =>
        return 0;
      when others =>
        return -1;
    end case;
    return -1;
  end;

  -- Function: hex_to_bin
  -- Usage:
  -- Reading a single hex character e.g. 'a' or '1' is trivial.
  -- Reading a hexadecimal string of characters is performed in bram_tb.vhd.
  function hex_to_bin (constant hex : character)
    return integer is
    variable erg : integer := 0;
  begin
    case hex is
      when '0' => erg := 0;
      when '1' => erg := 1;
      when '2' => erg := 2;
      when '3' => erg := 3;
      when '4' => erg := 4;
      when '5' => erg := 5;
      when '6' => erg := 6;
      when '7' => erg := 7;
      when '8' => erg := 8;
      when '9' => erg := 9;
      when 'A' | 'a' => erg := 10;
      when 'B' | 'b' => erg := 11;
      when 'C' | 'c' => erg := 12;
      when 'D' | 'd' => erg := 13;
      when 'E' | 'e' => erg := 14;
      when 'F' | 'f' => erg := 15;
      when others =>
        report "### function hex_to_bin: character '" & hex & "' is not a hexadecimal value###"
          severity failure;
    end case;
    return erg;
  end hex_to_bin;

end package body dfki_pack;
--! @}
