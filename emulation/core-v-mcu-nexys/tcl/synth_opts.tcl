# set to none to maintain design hierarchy, otherwise set to rebuilt
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]

set_property STEPS.SYNTH_DESIGN.ARGS.NO_RETIMING [get_runs synth_1]

set_property STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS [get_runs synth_1]

set_property STEPS.SYNTH_DESIGN.ARGS.RESOURCE_SHARING off [get_runs synth_1]