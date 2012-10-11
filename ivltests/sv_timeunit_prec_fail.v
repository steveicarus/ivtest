/*
 * Check the basic parsing and that the errors are caught.
 */

// A global timeunit and timeprecision are OK
timeunit 100us;
timeprecision 1us;

/*
 * Check the various timeunit/precision combinations (this is valid SV syntax).
 */
// A local time unit is OK.
module check_tu;
  timeunit 10us;
endmodule

// A local time precision is OK.
module check_tp;
  timeprecision 10us;
endmodule

// Both a local time unit and precision are OK.
module check_tup;
  timeunit 10us;
  timeprecision 10us;
endmodule

// Both a local time unit and precision are OK (check both orders).
module check_tpu;
  timeprecision 10us;
  timeunit 10us;
endmodule

/*
 * Now do the same with repeat declarations (this is valid SV syntax).
 */
// A local time unit is OK.
module check_tu_d;
  timeunit 10us;
  timeunit 10us;
endmodule

// A local time precision is OK.
module check_tp_d;
  timeprecision 10us;
  timeprecision 10us;
endmodule

// Both a local time unit and precision are OK.
module check_tup_d;
  timeunit 10us;
  timeprecision 10us;
  timeunit 10us;
  timeprecision 10us;
endmodule

// Both a local time unit and precision are OK (check both orders).
module check_tpu_d;
  timeprecision 10us;
  timeunit 10us;
  timeprecision 10us;
  timeunit 10us;
endmodule

// It is OK to redefine the global time unit and precision.
timeunit 100us;
timeprecision 1ns;

/*
 * Now test some error conditions.
 */
// A local time unit is OK, but a repeat must match.
module check_tu_d_e;
  timeunit 10us;
  timeunit 1us;
endmodule

// A local time precision is OK, but a repeat must match.
module check_tp_d_e;
  timeprecision 10us;
  timeprecision 1us;
endmodule

// A repeat time unit is only allowed if an initial one is given.
module check_tu_m_e;
  integer foo;
  timeunit 10us;
endmodule

// A repeat time precision is only allowed if an initial one is given.
module check_tp_m_e;
  integer foo;
  timeprecision 10us;
endmodule

// A local time unit is OK and a repeat is OK, but this is not a prec decl.
module check_tup_d_e;
  timeunit 10us;
  timeunit 10us;
  timeprecision 1us;
endmodule

// A local time prec is OK and a repeat is OK, but this is not a unit decl.
module check_tpu_d_e;
  timeprecision 1us;
  timeprecision 1us;
  timeunit 10us;
endmodule

// Check all the valid timeunit and time precision values.
timeunit 100s;
timeprecision 100s;
timeunit 10s;
timeprecision 10s;
timeunit 1s;
timeprecision 1s;
timeunit 100ms;
timeprecision 100ms;
timeunit 10ms;
timeprecision 10ms;
timeunit 1ms;
timeprecision 1ms;
timeunit 100us;
timeprecision 100us;
timeunit 10us;
timeprecision 10us;
timeunit 1us;
timeprecision 1us;
timeunit 100ns;
timeprecision 100ns;
timeunit 10ns;
timeprecision 10ns;
timeunit 1ns;
timeprecision 1ns;
timeunit 100ps;
timeprecision 100ps;
timeunit 10ps;
timeprecision 10ps;
timeunit 1ps;
timeprecision 1ps;
timeunit 100fs;
timeprecision 100fs;
timeunit 10fs;
timeprecision 10fs;
timeunit 1fs;
timeprecision 1fs;

/* Check some invalid values */

// Only a power of 10 is allowed.
timeunit 200s;
timeprecision 200s;
// Too many zeros (only allow 0 - 2).
timeunit 1000s;
timeprecision 1000s;
// This actually trips as an invalid scale of '2s'.
timeunit 12s;
timeprecision 12s;
// This needs to be checked. The base time_literal supports this, but
// for now timeunit/precision code does not.
timeunit 1_0s;
timeprecision 1_0s;

/* This fails because we have not defined a timeprecision or it is too large. */

// Check a missing global time precision.
`resetall
timeunit 1ns;
module no_gtp;
endmodule

// Check a global timeprecision that is too large.
`resetall
timeunit 1ns;
timeprecision 10ns;
module gtp_large;
endmodule

// Check a missing local time precision.
`resetall
module no_ltp;
  timeunit 1ns;
endmodule

// Check a local timeprecision that is too large.
`resetall
module ltp_large;
  timeunit 1ns;
  timeprecision 10ns;
endmodule


/* These should work since both the unit and precision are defined
 * before we have any module items. */

// A global timeprecision and local time units.
`resetall
timeprecision 10ps;

module gtp_ltu1;
  timeunit 1ns;
endmodule

module gtp_ltu2;
  timeunit 1us;
endmodule

// A global timeunit and local time precision.

`resetall
timeunit 1ns;

module gtu_ltp1;
  timeprecision 10ps;
endmodule

module gtu_ltp2;
  timeprecision 1ns;
endmodule
