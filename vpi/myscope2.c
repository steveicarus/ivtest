
/*
 */
# include  <veriuser.h>
# include  <assert.h>

static char * instance = 0;
static int sn_calltf(int user_data, int reason)
{
      int high_time, low_time;

      io_printf("... sn_calltf(reason=%d)\n", reason);
      low_time = tf_igetlongtime(&high_time,instance);
      io_printf("high_time=%d, low_time=%d\n", high_time, low_time);
      return 0;
}

int ise_vls_misc(int data, int reason, int paramvc)
{
      io_printf("... ise_vls_misc(reason=%d)\n", reason);
      if (reason != reason_endofcompile)
	    return sn_calltf(data, reason);
      else
	    return 0;
}

int ise_startup(int data, int reason)
{
      instance = tf_getinstance();
      io_printf("... ise_startup(reason=%d)\n", reason);
      tf_isynchronize(instance);
      return 1;
}

static s_tfcell sn[2] = {
      { usertask, 0, ise_startup, 0, sn_calltf, ise_vls_misc,"$sn"},
      {0}
};

static void veriusertfs_register(void)
{
      veriusertfs_register_table(sn);
}

void (*vlog_startup_routines[])() = {
      &veriusertfs_register,
      0
};
