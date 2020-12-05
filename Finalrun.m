clear;clc;clf;
fileID = fopen('2DStructure.txt', 'w')
% Selected No Eigen Modes
Ev = [6;10;14;20;26]';
%10 lowest natural Frequencies for CMS (Craig Bampton)
CBNatF = zeros(10,length(Ev));

%10 lowest natural Frequencies for Reduced order Model
CCNatF = zeros(10,length(Ev));
for i =1:length(Ev)
  ev = Ev(i);
  project1 % Reduced Substructure 1 using CB Method
  project2;   % Reduced Substructure 2 using CB Method
  project3;   % Reduced Substructure 3 using CB Method
  project4;   % Reduced Substructure 4 using CB Method
  comb;       % Assembled Substructure 1, 2, 3 and 4 using CC modes
  CCNatF(:,i) = sort(diag(DR));
  CBNatF(:,i) = sort(diag(DRC));
end
Fulldof;
OrigF = sort(diag(DOrig)); %Natural Frequecies for Full DOF system 
fprintf(fileID,'**************************************************\n')
fprintf(fileID,"Eigen values for Reduced model using CB method\n")
fprintf(fileID,'**************************************************\n')
fprintf(fileID,'%4i %4i %4i %4i %4i\n',CBNatF.')

display(CBNatF);
fprintf(fileID,'*************************************************\n')
fprintf(fileID,"Eigen values for Reduced model using CC mode\n")
fprintf(fileID,'***********************************************\n')
fprintf(fileID,'%4i %4i %4i %4i %4i\n',CCNatF.')
fprintf(fileID,'*************************************************\n')
display(CCNatF);

fprintf(fileID,"Eigen values for full dof system\n")
fprintf(fileID,'*************************************************\n')
fprintf(fileID,'%d\n',OrigF)
display(OrigF);

EOCC = (OrigF - CCNatF); % Error Analysis between Full dof and ROM model
EOCB = (OrigF - CBNatF); % Error Analysis between Full dof and CB model
fprintf(fileID,'**************************************************\n')
fprintf(fileID,"Error b/w Eigen values for CB and Full DOF system\n")
fprintf(fileID,'***********************************************\n')
fprintf(fileID,'%4i %4i %4i %4i %4i\n',EOCB.')
fprintf(fileID,'***********************************************\n')
fprintf(fileID,"Error b/w Eigen values for ROM and Full DOF system\n")
fprintf(fileID,'***********************************************\n')
fprintf(fileID,'%4i %4i %4i %4i %4i\n',EOCC.')
fprintf(fileID,'***********************************************\n')
percentageEOCC = ((OrigF - CCNatF)./OrigF)*100;
percentageEOCB = ((OrigF - CBNatF)./OrigF)*100;
subplot(121)
plot(Ev,EOCB,'LineWidth',2)
legend('1','2','3','4','5','6','7','8','9','10')
xlabel('Selected eigen mode')
ylabel('Eigen Values corresponding the selected modes')
title('Craig Bampton Method')
subplot(122)
plot(Ev,EOCC,'LineWidth',2)
legend('1','2','3','4','5','6','7','8','9','10')
xlabel('Selected eigen mode')
ylabel('Eigen Values corresponding the selected modes')
title('ROM model usig Constraint Mode')
fclose(fileID)

