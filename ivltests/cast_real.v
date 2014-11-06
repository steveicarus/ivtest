// Copyright (c) 2014 CERN
// Maciej Suminski <maciej.suminski@cern.ch>
//
// This source code is free software; you can redistribute it
// and/or modify it in source code form under the terms of the GNU
// General Public License as published by the Free Software
// Foundation; either version 2 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA


// Test casting integers to real

module cast_real();
initial begin
    // Initalization using an integer variable
    int i = 5;
    real a = real'(i);

    // ..and logic
    logic [3:0] l = 4'b1010;
    real b = real'(l);

    logic signed [3:0] sl = 4'b1010;
    real c = real'(sl);

    // Initialization using an integer constant
    real d = real'(11);
    real e = real'(-7);

    if (a != 5.0)
    begin
        $display("FAILED #1 a = %f", a);
        $finish();
    end

    if (b != 10.0)
    begin
        $display("FAILED #2 b = %f", b);
        $finish();
    end

    if (c != -6.0)
    begin
        $display("FAILED #3 c = %f", c);
        $finish();
    end

    if (d != 11.0)
    begin
        $display("FAILED #4 d = %f", d);
        $finish();
    end

    if (e != -7.0)
    begin
        $display("FAILED #5 e = %f", e);
        $finish();
    end

    $display("PASSED");
end
endmodule
