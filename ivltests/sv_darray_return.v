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


// Test for dynamic arrays used as the function return type.

module sv_darray_return();
typedef logic[7:0] byte_array [];

function byte_array make_array();
    byte_array tmp;
    tmp = new[3];
    tmp[0] = 13;
    tmp[1] = 14;
    tmp[2] = 15;
    return tmp;
endfunction

initial begin
    byte_array a;
    a = make_array();

    if($size(a) != 3 || a[0] !== 13 || a[1] !== 14 || a[2] !== 15) begin
        $display("FAILED");
        $finish();
    end

    $display("PASSED");
end
endmodule
