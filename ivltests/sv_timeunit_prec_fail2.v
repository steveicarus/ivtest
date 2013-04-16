/* * Check the basic parsing and that the errors are caught.
 */

// A global timeunit and timeprecision are OK
timeunit 100us/1us;

/*
 * Check the various timeunit/precision combinations (this is valid SV syntax).
 */
// Both a local time unit and precision are OK.
module check_tup;
  timeunit 10us/10us;
endmodule

/*
 * Now do the same with repeat declarations (this is valid SV syntax).
 */

// Both a local time unit and precision are OK.
module check_tup_d;
  timeunit 10us/10us;
  timeunit 10us/10us;
  timeunit 10us;
  timeprecision 10us;
endmodule

// It is OK to redefine the global time unit and precision.
timeunit 100us/1ns;

/*
 * Now test some error conditions.
 */
// A local time unit/precision is OK, but a repeat must match.
module check_tup_d_e;
  timeunit 10us/10us;
  timeunit 1us/1us;
  timeunit 1us;
  timeprecision 1us;
endmodule

// A repeat time unit/precision is only allowed if an initial one is given.
module check_tup_m_e;
  integer foo;
  timeunit 10us/10us;
endmodule

// A local time unit is OK and a repeat is OK, but this is not a prec decl.
module check_tu_d_e;
  timeunit 10us;
  timeunit 10us/1us;
endmodule

// A local time prec is OK and a repeat is OK, but this is not a unit decl.
module check_tp_d_e;
  timeprecision 1us;
  timeunit 10us/1us;
endmodule

// Check all the valid timeunit and time precision values.
timeunit 100s/100s;
timeunit 10s/10s;
timeunit 1s/1s;
timeunit 100ms/100ms;
timeunit 10ms/10ms;
timeunit 1ms/1ms;
timeunit 100us/100us;
timeunit 10us/10us;
timeunit 1us/1us;
timeunit 100ns/100ns;
timeunit 10ns/10ns;
timeunit 1ns/1ns;
timeunit 100ps/100ps;
timeunit 10ps/10ps;
timeunit 1ps/1ps;
timeunit 100fs/100fs;
timeunit 10fs/10fs;
timeunit 1fs/1fs;

/* Check some invalid values */

// Only a power of 10 is allowed.
timeunit 200s/200s;
// Too many zeros (only allow 0 - 2).
timeunit 1000s/1000s;
// This actually trips as an invalid scale of '2s'.
timeunit 12s/12s;
// This needs to be checked. The base time_literal supports this, but
// for now timeunit/precision code does not.
timeunit 1_0s/1_0s;

/* This fails because we have not defined a timeprecision or it is too large. */

// Check a global timeprecision that is too large.
`resetall
timeunit 1ns/10ns;
module gtp_large;
endmodule

// Check a local timeprecision that is too large.
`resetall
module ltp_large;
  timeunit 1ns/10ns;
endmodule
