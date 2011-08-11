#include  <vpi_user.h>
#include  <strings.h>

static PLI_INT32 end_of_sim_cb(struct t_cb_data *x)
{
      vpi_printf("In VPI cbEndOfSimulation callback.\n");
      return 0;
}

static void cb_register()
{
      s_cb_data cb_data;
      bzero(&cb_data, sizeof(s_cb_data));
      cb_data.reason = cbEndOfSimulation;
      cb_data.cb_rtn = end_of_sim_cb;
      vpi_register_cb(&cb_data);
}

/*
 * This is a table of register functions. This table is the external
 * symbol that the simulator looks for when loading this .vpi module.
 */
void (*vlog_startup_routines[])() = {
      cb_register,
      0
};
