#
# Module for processing command line arguments, etc.
#

package Environment;

use strict;
use warnings;

our $VERSION = '1.00';

use base 'Exporter';

our @EXPORT = qw(get_regress_fn get_ivl_version);

use constant DEF_REGRESS_FN => './regress.list';  # Default regression list.

#
# Get the name of the regression list file. Either the default
# or the file specified in the command line arguments.
#
sub get_regress_fn {
    my $regress_fn = DEF_REGRESS_FN;

    # Is there a command line argument (alternate regression list)?
    if ($#ARGV != -1) {
        $regress_fn = $ARGV[0];
        -e "$regress_fn" or
            die "Error: command line regression file $regress_fn doesn't exist.\n";
        -f "$regress_fn" or
            die "Error: command line regression file $regress_fn is not a file.\n";
        -r "$regress_fn" or
            die "Error: command line regression file $regress_fn is not ".
            "readable.\n";
    }
    if ($#ARGV > 0) {
        warn "Warning: only using first argument to script.\n";
    }

    return $regress_fn;
}

#
# Get the current version from iverilog.
#
sub get_ivl_version {
    if (`iverilog -V` =~ /^Icarus Verilog version (\d+\.\d+)/) {
        return $1;
    }
    else {
        die "Failed to get version from iverilog -V output";
    }
}

1;  # Module loaded OK
