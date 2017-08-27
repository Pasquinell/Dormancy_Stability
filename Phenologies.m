function PH = Phenologies()

global  m  EPD_identity

 EPD_setOne = zeros(m,1);
 EPD_setOne(EPD_identity) = 1 ;
 


%Nota: este codigo no se esta ocupando ahora. (v5_2014_11_18_grande)

if v1 == 1
%     zeros(m,1)
%     [0; 0]
    DESFh = zeros(m,1); % [0 ; 0] ;
    DESFf = [zeros(m-1,1); varBif];  %zeros(m,1) + [0;varBif];
    PH{1} = @(t) spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16).*EPD_setOne; %f(t)
%    PH{2} = @(t) spulse(2*(t/52.18+0.5+.01-DESFh-floor(t/52.18+0.5+.01-DESFh)),16) .*EPD_setOne; %h(t)
    PH{2} = @(t) [ones(m,1)]; %[1;1]; %spulse(2*(t/52.18+1/2+.01-DESFh-floor(t/52.18+1/2+.01-DESFh)),16) .*EPD_setOne; %h(t)
elseif v1 == 2
    DESFh = [zeros(m-1,1); varBif];  %zeros(m,1) + [0 ; varBif] ;
    DESFf = zeros(m,1) ; %+ [0;0];
    PH{1} =@(t)  [1;1]; %spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16).*EPD_setOne; %f(t)
    PH{2} = @(t)  spulse(2*(t/52.18+1/2+.01-DESFh-floor(t/52.18+1/2+.01-DESFh)),16) .*EPD_setOne; %h(t)
elseif v1 == 3
    DESFh = zeros(m,1) ; %+ [0 ; 0] ;
    DESFf = [varBif;zeros(m-1,1)];  %zeros(m,1) + [varBif;0];
    PH{1} =@(t) [0;1]+[1;0].*spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16).*EPD_setOne; %f(t)
    PH{2} = @(t) [0;1]+[1;0].*spulse(2*(t/52.18+1/2+.01-DESFh-floor(t/52.18+1/2+.01-DESFh)),16) .*EPD_setOne; %h(t)
elseif v1 == 4
    DESFh = zeros(m,1) ; %+ [0 ; 0] ;
    DESFf = [zeros(m-1,1); varBif];  % zeros(m,1) + [0;varBif];
    PH{1} =@(t) [1;0]+[0;1].*spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16).*EPD_setOne; %f(t)
    PH{2} = @(t) [1;0]+[0;1].*spulse(2*(t/52.18+1/2+.01-DESFh-floor(t/52.18+1/2+.01-DESFh)),16) .*EPD_setOne; %h(t)
elseif v1 == 5
    DESFh = zeros(m,1) ; %+ [0 ; 0] ;
    DESFf = [varBif;zeros(m-1,1)];   % zeros(m,1) + [varBif;0];
    PH{1} =@(t) [0;1]+[1;0].*spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16).*EPD_setOne; %f(t)
    PH{2} = @(t) [1;0]+[0;1].*spulse(2*(t/52.18+1/2+.01-DESFh-floor(t/52.18+1/2+.01-DESFh)),16) .*EPD_setOne; %h(t)
elseif v1 == 6    
    DESFh = zeros(m,1) ; %+ [0 ; 0] ;
    DESFf = [zeros(m-1,1); varBif];  %zeros(m,1) + [0;varBif];
    PH{1} =@(t) [1;0]+[0;1].*spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16).*EPD_setOne; %f(t)
    PH{2} = @(t) [0;1]+[1;0].*spulse(2*(t/52.18+1/2+.01-DESFh-floor(t/52.18+1/2+.01-DESFh)),16) .*EPD_setOne; %h(t)
end

end

