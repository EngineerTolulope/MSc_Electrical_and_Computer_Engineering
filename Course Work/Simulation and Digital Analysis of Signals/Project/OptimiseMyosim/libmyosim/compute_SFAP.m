% COMPUTE SFAP --------------------------------------------------------------------------------
function [mask_selected,SFAP] = compute_SFAP(current)
Nch = length(current.CH);
Npersp = length(current.PERSP);
dt = 1 / current.fs;
% Initialize parameters structure
params(1:current.NSFAP) = struct('dist', current.dist_init, ...
    'prox', current.prox_init, ...
    'cv', current.cv_init, ...
    'ip', 0, ...
    'Ts', current.Ts, ...
    'depth', 0, ...
    'align', 0);
% Setting fibre parameters
if current.NSFAP == 1            % no dispersion if only one fiber
    current.depth_disp = 0;
    current.align_disp = 0;
    current.cv_disp = 0;
    current.dist_disp = 0;
    current.prox_disp = 0;
    current.ip = 0;
end
% randpts () function already has inherent capability to calculate number
% of different points, call it once with the required number of fibres
% instead of repeatedly calling it in the loop below.
if(current.geometry.method==1)
    %========================Modified by STPR============================%
    %Date: 12 May 2016. Same technique as was used in MUAP function. Define
    %the ellipses. In this case, the ellipses to consider are the area
    %covered by the limb and the Motor Unit. Translate the axes and flip
    %the Y axis to make it easier to work with.
    h1=0;
    k1=0;
    len_maj1=2*current.Rlimb;
    len_min1=len_maj1;
    k2=current.Rlimb-current.MUAPCENTRE(2);
    h2=current.MUAPCENTRE(1);
    len_min2=2*current.depth_disp;
    len_maj2=2*current.align_disp;
    %Increment value. This is the minimum value the plane is quantised
    %into. In this case, diameter of fibre. Typically 0.05 - 0.1 mm.
    delta=current.geometry.fib_dia;
    % Pick a random rotation of the fibre ellipse. We do not need any
    % rotation.
    theta=0;
    %Define gaussian paramteres, we are interested in the motor unit
    %ellipse, so we can centre the Gaussian curve about the ellipse and set
    %some stdev value. Select higher stdev values for tighter spread, or
    %vice versa. This is necessary because the fibres are distributed in a
    %Gaussian manner in the motor unit territory. It slows down the
    %process, but is closer to practical cases.
    if(current.geometry.geoopt==1)
        mean1=h2;
        mean2=k2;
        std1=current.geometry.sdx;
        std2=current.geometry.sdx;
        %Gaussian Dist.
        [mask_selected,Fibre_Locs]=randpts([h1,k1,len_maj1,len_min1,0],[h2,k2,len_maj2,len_min2,theta],[mean1,std1,mean2,std2],current.NSFAP,[-current.Rlimb,delta,current.Rlimb,0,delta,current.Rlimb],current.PICKEDLOCS);
    else
        %Uniform Dist.
        [mask_selected,Fibre_Locs]=randpts([h1,k1,len_maj1,len_min1,0],[h2,k2,len_maj2,len_min2,theta],[],current.NSFAP,[-current.Rlimb,delta,current.Rlimb,0,delta,current.Rlimb],current.PICKEDLOCS);
    end

    if(isempty(Fibre_Locs))
        SFAP=[];
        return
    end
    %Reverse the transformation (y=Rlimb-Y;x=X;)
    Fibre_Locs(:,2)=current.Rlimb-Fibre_Locs(:,2);
else
    mask_selected=[];
end
for n = 1:current.NSFAP
    if current.NSFAP > 1
        params(n).dist = current.dist_init+current.dist_disp*(2*rand-1);
        %params(n).dist = d.dist_init+2*d.dist_disp*rand(1)-d.dist_disp; %
        %fibre distal length in mm
        params(n).prox = current.prox_init+current.prox_disp*(2*rand-1); % fibre proximal length in mm
        %params(n).prox = d.prox_init+2*d.prox_disp*rand(1)-d.prox_disp; %
        %fibre proximal length in mm
        params(n).cv = current.cv_init+current.cv_disp*(2*rand-1);                  % fibre conduction velocity (uniform distrubution)
        %params(n).cv = d.cv_disp*randn+d.cv_init;                      %
        %fibre conduction velocity (normal distribution) Q: GENERATES ERROR
        %WHEN VALUE DISTRIBUTED EXCEEDS +/-1
        params(n).ip = 2*current.ip*rand(1)-current.ip;                             % innervation point location
    end
    switch current.geometry.method
        case 1%Raghu Geometry
            %current.NSFAP number of fibre locations are already calculated
            %above.
            params(n).depth = Fibre_Locs(n,2);
            params(n).align = Fibre_Locs(n,1);
        case 2%Rogers Geometry
            % cylindrical model depth based on radius and angle
            phimu = 2*pi*rand;      % random angle within elliptical motor unit
            % Calculate radius within motor unit
            if current.depth_disp == 0 && current.align_disp == 0
                rmu = 0;
            elseif current.depth_disp == 0
                rmu = rand*current.align_disp;
                phimu=pi*randi([0,1],1)+pi/2; %sets angle to 90 or 270 degrees
            elseif current.align_disp == 0
                rmu = rand*current.depth_disp;
                phimu=pi*randi([0,1],1); %sets angle to 0 or 180 degrees
            else
                rmu = rand*sqrt( current.depth_disp^2*current.align_disp^2 / (current.align_disp^2*cos(phimu)^2 + current.depth_disp^2*sin(phimu)^2));  % random radius within elliptical motor unit Q:  IS THSI CORRECT??
            end
            
            adj = (current.Rlimb-current.depth_init)+rmu*cos(phimu);
            opp = current.align_init + rmu*sin(phimu);
            r = sqrt(opp^2 + adj^2);
            if r == 0 % for fiber exactly at center of limb
                phi = 0;
            else
                phi = asin(opp/r);
            end
            if adj < 0, phi = pi - phi; end % account for all 4 quadrants
            params(n).depth = current.Rlimb - r*cos(phi);
            params(n).align = r*sin(phi);
            params(n).r=r;
            params(n).phi=phi;
    end
end % for n = 1:NSFAP

% Calculating an SFAP according to J Cueto Generate source

ts = (0:dt:current.Ts-dt)';     % setting time scale

% Updated by STPR, 14-March-2017
% Corrected the equation.
V_source = 0.4;

dVm_dt = V_source.*(51.*2.*-64.*(V_source.*ts-0.54).*exp(-64.*(V_source.*ts-0.54).^2)...
    + 72.*2.*-28.41.*(V_source.*ts-0.66).*exp(-28.41.*(V_source.*ts-0.66).^2)...
    + 18.*2.*-11.09.*(V_source.*ts-0.86).*exp(-11.09.*(V_source.*ts-0.86).^2));

%Replicate the source to match the given number of channels.
dVm_dt=repmat(dVm_dt(:),1,Nch);
NdVm=size(dVm_dt,1);

cv = [params.cv];   % each row is fiber
%=============Modified by STPR=========================================%
%STPR: Removed all time varying stuff. STPR: Initialise the structure first
%before calling it every loop
SFAP(current.NSFAP,1)=struct('sig',[],'params',[]);
% Create SFAP for each time instant

% Generating filter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STPR: Added innervation point, previous models missed it.
Td = abs(([params.dist]+[params.ip]) ./ cv);   %time to propagate distally (msec)
Tp = abs(([params.prox]-[params.ip]) ./ cv);   %time to propagate proximally (msec)

tf = (0:dt:max([Td,Tp]))';  % sets time scale of tissue filter (msec)
Ntf = length(tf);

% Setup time vector accounting for channel delays
temp = repmat(tf,1,Nch);
CH = repmat(current.CH,Ntf,1);
[SFAP(1:current.NSFAP).sig] = deal(zeros(Ntf+NdVm-1,current.Nch,Npersp));
for n = 1:current.NSFAP
    SFAP(n,1).params = params(n);
    Id = find(tf<=Td(n),1,'last'); %index for distal propagation time
    Ip = find(tf<=Tp(n),1,'last'); %index for proximal propagation
    delay = CH / SFAP(n,1).params.cv;
    tmpd = temp(1:Id,:)+delay(1:Id,:);
    tmpp = temp(1:Ip,:)-delay(1:Ip,:);
    % calculate SFAP at each perspective
    for per = 1:length(current.PERSP)
        %=====================Modified by STPR==========================%
        % Date: 30 May 2016 STPR: Initialise the filter array inside the
        % loop to erase previous records.
        hd = zeros(Ntf,Nch); % initializing the filter to zero
        hp = hd;
        switch current.geometry.method
            case 1%Raghu Geometry
                % Phi is the angle with respect to the Y axis (i.e Depth
                % axis). Convert it angle with respect to X axis. Total
                % angle= pi; one of the angle is always pi/2. So the other
                % angle becomes: (pi-pi/2-phi) = pi/2-phi.
                phi=pi/2-current.PERSP(per)*pi/180;
                %Depth and alignment of the fibre. Translate it to make
                %things easier.
                X1=params(n).align;
                Y1=current.Rlimb-params(n).depth;
                % The point where the tangent meets the circle at a certain
                % angle 'phi' with respect to the X axis is given by
                % (R*cos(phi),R*sin(phi)); Assuming centre at (0,0).
                X2=current.Rlimb*cos(phi);
                Y2=current.Rlimb*sin(phi);
                % True depth is the Euclidean distance between the centre
                % of the fibre and the point of intersection of tangent and
                % the circle.
                truedepth=sqrt((X2-X1)^2+(Y2-Y1)^2);
                
            case 2% Rogers Geometry
                theta = current.PERSP(per)*pi/180;
                truedepth = sqrt(current.Rlimb^2 - 2*current.Rlimb*params(n).r*cos(theta-params(n).phi)+params(n).r^2);
        end
        
        %=======================Modified by STPR==========================%
        % Date: 2/December/2016:
        % Include Anisotropy (ratio of longitudinal to transversal
        % conductivities.
        % Wang 2006, Van Veen 1993 used 5.
        % Cueto 2002 used 6 in his paper and Plonsey 1974 used 11.2.
        % Note: Changing this drastically affects power spectrum.
        
        anisotropy_K0=5;
        
        % Setting the filter according to Jose (Checked model - confirmed,
        % DM 2012)
        hd(1:Id,:) = tmpd ./ (anisotropy_K0.*(truedepth/SFAP(n,1).params.cv)^2 + tmpd.^2).^(3/2);
        hp(1:Ip,:) = tmpp ./ (anisotropy_K0.*(truedepth/SFAP(n,1).params.cv)^2 + tmpp.^2).^(3/2);
        H = hd+hp;
        
        
        %=======================Modified by STPR==========================%
        %Date: 10 November 2016. Corrected code to use proper convolution
        %procedure. Convolution results in a signal of length (L+M-1),
        %Assuming original signals were  oflengths L and M. If proper zero
        %padding is not done before multiplication in frequency domain, the
        %result will be aliased. In order to do convolution properly, first
        %pad the two signals so that the length is greater than (L+M-1),
        %then take the FFT, multiply the FT and take the IFFT.
        
        
        %Find the length of the source and filter.
        
        
        %Now multiply padded fft and take inverse to obtain convolution.
        
        conv_res = ifft(fft(dVm_dt,Ntf+NdVm-1).*fft(H,Ntf+NdVm-1));
        
        %=======================Modified by STPR==========================%
        % Date:16 December 2016
        
        % Added computation of K1, propoer scaling of SFAP.
        % Note: As of today, the scale seems like it is a 1000x off.
        % Accounting for that too.
        % Parameters values from Van Veen 1992. Plonsey's paper seems to
        % indicate values close to this.
        
        sigma_I=0.450;                                          %(Ohm.m)^-1
        sigma_E=2.5;                                            %(Ohm.m)^-1
        V_source=4;                                             %mm/msec
        fib_rad=current.geometry.fib_dia/2;                     %mm
        
        K1=(1/8)*(sigma_I/sigma_E)*((fib_rad/V_source)^2);       %msec^2
        
        %Introducing calibration factor: Calibrate output to some
        %reasonable level of amplitudes.
        calibration_factor=500;
        
        sfap=calibration_factor*K1.*conv_res.*dt;                    %mv
        
        switch current.config
            case 'monopolar'
                SFAP(n,1).sig(:,:,per) = sfap;
            case 'sngdiff'
                SFAP(n,1).sig(:,:,per) = diff(sfap,1,2);
            case 'dbldiff'
                SFAP(n,1).sig(:,:,per) = diff(sfap,2,2);
        end
    end % for per
end % for n = 1:current.NSFAP