function [ePEF, eFVC, eFEV1,eFEV1per] = expectedVals(sex, H, A)

if strcmp(sex, 'Male')
% Men 
    ePEF = exp((0.544*log(A))-(.0151*A)-(74.7/H)+5.48)/60;
    eFVC  = 0.1524*H*0.393701 - 0.0214*A - 4.6500; %height is being requested in cm but equation requires inches
    eFEV1 = 0.1052*H*0.393701 - 0.0244*A - 2.1900;
elseif strcmp(sex, 'Female')
% Women 
    ePEF = exp((0.376*log(A))-(0.012*A)-(58.8/H)+5.63)/60;
    eFVC  = 0.1247*H*0.393701 - 0.0216*A - 3.5900;
    eFEV1 = 0.0869*H*0.393701 - 0.0255*A - 1.5780;
end
if(A < 18)
    ePEF = (H - 100) * 5 + 100;
end

% All
 eFEV1per = eFEV1/eFVC*100;


%Crapo Standards for Predicted PFT Values (PVC, PEV1, FEV1%)
%http://www.hopkinsmedicine.org/pftlab/predeqns.html

%Balasubramanian (2002) Indian Pediatr 39:104-6 [PubMed] (PEF; pediatric)



end

