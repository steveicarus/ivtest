module top;
  reg [80*8:1] simp_str, info_str;
  real ver, subver;
  initial begin
    ver = $simparam("simulatorVersion");
    subver = $simparam("simulatorSubversion");
    // For 0.9 only use one digit.
    if (ver > 0.89) $swrite(simp_str, "%0.1f.%0.0f", ver, subver);
    // For the rest 0.10 and above use two digits.
    else $swrite(simp_str, "%0.2f.%0.0f", ver, subver);
    $get_version(info_str);
    if (simp_str !== info_str) begin
      $display("FAILED");
      $display("$simparam         version: '%0s'", simp_str);
      $display("vpi_get_vlog_info version: '%0s'", info_str);
    end else $display("The two versions matched!");
  end
endmodule
