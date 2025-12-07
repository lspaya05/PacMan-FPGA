// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due: 09/30/2025
// Class: EE 371

// This file is a package containing the 7 Segment patterns for numbers 0-9 and letters A-Z.
//      To use in some file use the import statement: 'import Seg7_pkg::*'

// This package has no parameters and no inputs. All the outputs for the patterns are 7 bits long.

// Note G --> 6, I --> 1, O --> 0, S --> 5, Z --> 2

package Seg7_pkg;
    typedef enum logic [6:0] {
        ZERO   = 7'b1000000,
        ONE    = 7'b1111001,    
        TWO    = 7'b0100100,
        THREE  = 7'b0110000,
        FOUR   = 7'b0011001,
        FIVE   = 7'b0010010,
        SIX    = 7'b0000010,
        SEVEN  = 7'b1111000,
        EIGHT  = 7'b0000000,
        NINE   = 7'b0010000,
        A      = 7'b0001000,
        B      = 7'b0000011,
        C      = 7'b1000110,
        D      = 7'b0100001,
        E      = 7'b0000110,
        F      = 7'b0001110,
        H      = 7'b0001001,
        J      = 7'b1110001,
        K      = 7'b0001111,
        L      = 7'b1000111,
        M      = 7'b1101010,
        N      = 7'b1001000,
        P      = 7'b0001100,
        Q      = 7'b0011000,
        R      = 7'b1001110,
        T      = 7'b0000111,
        U      = 7'b1000001,
        V      = 7'b1100011,
        W      = 7'b1010101,
        X      = 7'b0111001,
        Y      = 7'b0010001
        } Seg7Disp; // typedef enum
endpackage //Seg7_pkg