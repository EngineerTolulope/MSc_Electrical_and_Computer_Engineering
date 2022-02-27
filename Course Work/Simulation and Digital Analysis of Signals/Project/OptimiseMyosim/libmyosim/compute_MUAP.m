function struc_data = compute_MUAP(struc_data, current)
Npersp = length(current.PERSP);
current.depth_max = current.depth_init;
current.align_max = current.align_init;
% Initialize MUAP structure: MUAP.sig, MUAP.params, MUAP.SFAP

struc_data.signals.MUAP(1:current.MMUAP, 1) = struct('sig',zeros(1,current.Nch, Npersp), ...
    'params', struct('depth_init', 0, ...
    'depth_disp', current.depth_disp, ...
    'align_init', 0, ...
    'align_disp', current.align_disp, ...
    'cv_init', [], ...
    'cv_disp', current.cv_disp, ...
    'dist_init', current.dist_init, ...
    'dist_disp', current.dist_disp, ...
    'prox_init', current.prox_init, ...
    'prox_disp', current.prox_disp, ...
    'ip', current.ip, ...
    'Fr', [], ...
    'C', current.C, ...
    'fs', current.fs,...
    'CH',current.CH, ...
    'NSFAP', 0), ...
    'SFAP', struct('sig', zeros(1,current.Nch, Npersp,1), ...
    'params',struct) );


current.PICKEDLOCS=[];
for mm = 1:current.MMUAP% for each motor unit to be created
    switch current.geometry.method
        case 1 %Raghu geometry
            %=====================Modified by STPR=====================%
            %Date: 12 May 2016.
            %New method to pick Motor Unit centres, and fibre locations,
            %based on cartesian coordinates and the function 'randpts()'.
            %The centre of the limb is at (0,Rlimb). However, the Y axis is
            %flipped. Normally going UP on the Y axis, we should get
            %increasing positive values and vice versa. However it is not
            %the case here. To make it easier to understand, first flip the
            %Y axis and then shift the centre of the limb to (0,0). All
            %other points are defined with respect to this centre. X axis
            %need not be modified.
            % The transformation is:
            % X  =  x;
            % Y  =  Rlimb-y;
            % (X,Y) = new coordinates,
            % (x,y) = old coordinates.
            %Initialise the parameters.
            %Parameters defining the limb.
            h1=0;
            k1=0;
            len_maj1=2*current.Rlimb;
            len_min1=len_maj1;
            %Parameters defining the motor unit ellipse. Flipping the axis results
            %in the minimum and maximum values being reversed.
            if(current.MMUAP==1)
                min_depth=current.Rlimb-current.depth_max;
                max_depth=min_depth;
                max_align=current.align_max;
                min_align=max_align;
            else
                min_depth=current.Rlimb-current.depth_max;
                max_depth=current.Rlimb-current.depth_min;
                min_align=current.align_min;
                max_align=current.align_max;
            end
            k2=(max_depth+min_depth)/2;
            h2=(min_align+max_align)/2;
            len_min2=max_depth-min_depth;
            len_maj2=max_align-min_align;

            %Increment value/Step size.
            %Our plane of interest is quantised with this value.
            
            delta=0.1;
            
            %We call randpts to determine Motor Unit centres. Note that
            %since Motor Unit is not actually a physical entity, they can
            %share the same centres as long as dispersion is big enough. So
            %we do not necessarily need different points for the centre.
            [~,MUAP_centres]=randpts([h1,k1,len_maj1,len_min1,0],[h2,k2,len_maj2,len_min2,0],[],1,[-current.Rlimb,delta,current.Rlimb,0,delta,current.Rlimb],[]);
            if(isempty(MUAP_centres))
                close(wbm)
                msgbox('Motor Unit Centres cannot be outside the limb. Please change the values and try again.','Geometry Error','error');
                set(gcbo,'Value',0);
                error('Stopping Simulation due to geometry error.')
            end
            %Reverse the transformation
            %(y=Rlimb-Y;x=X;)
            MUAP_centres(:,2)=current.Rlimb-MUAP_centres(:,2);
            struc_data.signals.MUAP(mm,1).params.depth_init = MUAP_centres(:,2);
            struc_data.signals.MUAP(mm,1).params.align_init = MUAP_centres(:,1);
            current.NSFAP = randi([current.NSFAP_min,current.NSFAP_max],1);
            current.MUAPCENTRE=[MUAP_centres(1),MUAP_centres(2)];%Pass centre of ellipse to the function.
            struc_data.signals.MUAP(mm,1).params.NSFAP = current.NSFAP;
            % Get SFAP signals and parameters for all instants
            [current.PICKEDLOCS,sfap] = compute_SFAP(current);
            if(isempty(sfap))
                close(wbm)
                msgbox('Availble fibres cannot physically fit in the area specified. Please change the values of the parameters and try again.','Geometry Error','error');
                set(gcbo,'Value',0);
                error('Stopping Simulation due to geometry error.')
            end
            %====================End of Modification by STPR==========================%
        case 2% Rogers geometry.
            % Choose random depth and alignment for multiple MUAPs
            if (current.MMUAP>1)
                a = (current.depth_max - current.depth_min)/2; % depth radius
                b = (current.align_max - current.align_min)/2; % alignment radius
                depth_center_gr = current.depth_min + a; % depth of center of ellipse
                align_center_gr = current.align_min + b; % alignment of center of ellipse
                
                phigr = rand*2*pi;  % random angle within elliptical group of motor units
                if a == 0 && b == 0 % if all MUs have the same depth and align
                    rgr = 0;
                elseif a==0
                    rgr = rand*b;
                    phigr = randi([0,1], 1)*pi+pi/2;
                elseif b==0
                    rgr = rand*a;
                    phigr = randi([0,1], 1)*pi;
                else
                    rgr = rand*sqrt( a^2*b^2 / (b^2*cos(phigr)^2 + a^2*sin(phigr)^2));    % random radius within...
                end                                                                        % motor units
                current.depth_init = depth_center_gr - rgr*cos(phigr);
                current.align_init = align_center_gr + rgr*sin(phigr);
            end %Nmu>1
            
            current.NSFAP = randi([current.NSFAP_min,current.NSFAP_max],1);
            
            struc_data.signals.MUAP(mm,1).params.depth_init = current.depth_init;
            struc_data.signals.MUAP(mm,1).params.align_init = current.align_init;
            struc_data.signals.MUAP(mm,1).params.NSFAP = current.NSFAP;
            [~,sfap] = compute_SFAP(current);
    end
    
    struc_data.signals.MUAP(mm,1).params = struc_data.signals.MUAP(mm,1).params;
    struc_data.signals.MUAP(mm,1).params.cv_init = current.cv_init;
    %=====================Modified by STPR=====================%
    %Date: 12 September 2016.
    %Change Fr to randi([Fr_min,Fr_max]);
    %The change is reflected everywhere in the code.
    %randi version (Integer version)
    struc_data.signals.MUAP(mm,1).params.Fr = randi([current.Fr_min,current.Fr_max],1,1);
    %rand version: This will produce a non integer value of Fr. Enable
    %this if required and comment the above line.
    %handles.signals.MUAP(mm,1).params.Fr =(current.Fr_max-Current.Fr_min)*rand(1,1)+Current.Fr_min;
    struc_data.signals.MUAP(mm,1).SFAP = sfap(:,1);
    struc_data.signals.MUAP(mm,1).sig = sum( cat(4,struc_data.signals.MUAP(mm,1).SFAP.sig), 4 );  % sum SFAP to get MUAP
    
end % for mm = 1:current.MMUAP
