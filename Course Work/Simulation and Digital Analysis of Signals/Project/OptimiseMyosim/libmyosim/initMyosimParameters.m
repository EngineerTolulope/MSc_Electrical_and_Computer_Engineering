% Initialise sane Myosim parameters for quick signal generation.

function parameters = initMyosimParameters

parameters.create.current.NSFAP_min = 50;
parameters.create.current.NSFAP_max = 100;
parameters.create.current.MMUAP = 50;

parameters.create.current.dist_init = -220;
parameters.create.current.dist_disp = 5;
parameters.create.current.prox_init = 180;
parameters.create.current.prox_disp = 5;
parameters.create.current.ip = 5;

parameters.create.current.depth_min = 10;
parameters.create.current.depth_init = 20;
parameters.create.current.depth_disp = 5;
parameters.create.current.align_min = -10;
parameters.create.current.align_init = 10;
parameters.create.current.align_disp = 5;

parameters.create.current.Rlimb = 40;

parameters.create.current.geometry.method = 1;
parameters.create.current.geometry.geoopt = 2;
parameters.create.current.geometry.sdx = 7;
parameters.create.current.geometry.sdy = 7;
parameters.create.current.geometry.fib_dia = 0.05;


parameters.create.current.cv_init = 4;
parameters.create.current.cv_disp = 0.15;

parameters.create.current.Fr_min = 10;
parameters.create.current.Fr_max = 35;
parameters.create.current.C = 0.15;

parameters.create.current.CH = 30:10:40;
parameters.create.current.PERSP = 0;

parameters.create.current.fs = 1;
parameters.create.current.T = 5;
parameters.create.current.Ts = 5;

parameters.create.current.ap.enable = 0;
parameters.create.current.ap.amp.enable = 0;
parameters.create.current.ap.amp.gain = 1000;
parameters.create.current.ap.filt_params.enable = 0;
parameters.create.current.ap.filt_params.hpf_fc = 20;
parameters.create.current.ap.filt_params.hpf_ord = 2;
parameters.create.current.ap.filt_params.lpf_fc = 500;
parameters.create.current.ap.filt_params.lpf_ord = 2;
parameters.create.current.ap.aa_filt_params.enable = 0;
parameters.create.current.ap.aa_filt_params.fc = 1000;
parameters.create.current.ap.aa_filt_params.ord = 2;
parameters.create.current.ap.quant.enable = 0;
parameters.create.current.ap.quant.numbits = 16;
parameters.create.current.ap.quant.min_amp = -5000;
parameters.create.current.ap.quant.max_amp = 5000;
parameters.create.current.ap.baseline.enable = 0;
parameters.create.current.ap.baseline.fcp = 1000;
parameters.create.current.ap.baseline.p0 = 1.02e-13;
parameters.create.current.ap.baseline.pli_vals = [2.00148170581556e-13, ...
                                                  2.94353682600533e-15, ...
                                                  5.09123978361558e-14, ...
                                                  1.84206722600305e-15, ...
                                                  1.09148624373301e-14];
parameters.create.current.config = 'sngdiff';
parameters.create.current.Nch = length(parameters.create.current.CH) - 1;
