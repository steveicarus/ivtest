module top;
  reg [80*8:1] simp_str, info_str;
  real ver, subver;
  initial begin
    ver = $simparam("simulatorVersion");
    subver = $simparam("simulatorSubversion");
    $swrite(simp_str, "%0.2f.%0.0f", ver, subver);
    $get_version(info_str);
    if (simp_str !== info_str) begin
      $display("FAILED");
      $display("$simparam         version: '%0s'", simp_str);
      $display("vpi_get_vlog_info version: '%0s'", info_str);
    end else $display("The two versions matched!");
  end
endmodule
