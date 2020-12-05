% Octave file for obtaining Assembly of reduced Substructure  
% ev is number of eigen value to be extracted
% m = mass % k = stiffness
mee= zeros(3*ev,3*ev); % e = internal node
mee(1:ev,1:ev) = a2;
mee(ev+1:2*ev,ev+1:2*ev) = a3;
mee(2*ev+1:end,2*ev+1:end) = a4;
size(mee);
meb = zeros(3*ev,43);    %b = boundary node
meb(1:ev,1:11) = b2;
meb(ev+1:2*ev,12:32) = b3;
meb(2*ev+1:end,33:43) = b4;
mbe = zeros(43,3*ev);
mbe(1:11,1:ev) = c2;
mbe(12:32,ev+1:2*ev) = c3;
mbe(33:43,2*ev+1:end) = c4;
mbb = zeros(43,43);
mbb(1:11,1:11) = d2;
mbb(12:32,12:32) = d3;
mbb(33:43,33:43) = d4;
kee= zeros(3*ev,3*ev);
kee(1:ev,1:ev) = a22;
kee(ev+1:2*ev,ev+1:2*ev) = a33;
kee(2*ev+1:end,2*ev+1:end) = a44;
kbb = zeros(43,43);
kbb(1:11,1:11) = d22;
kbb(12:32,12:32) = d33;
kbb(33:43,33:43) = d44;
%mbeta is assembly of 2, 3 and 4 substructure for Mass
mbeta = sparse(zeros((3*ev)+43,(3*ev)+43));
mbeta(1:3*ev,1:3*ev) = mee;
mbeta(3*ev+1:3*ev+43,1:3*ev) = mbe;
mbeta(1:3*ev,3*ev+1:3*ev+43) = meb;
mbeta(3*ev+1:3*ev+43,3*ev+1:3*ev+43) = mbb;
%kbeta is assembly of 2, 3 and 4 substructure for Stiffness
kbeta = sparse(zeros((3*ev)+43,(3*ev)+43));
kbeta(1:3*ev,1:3*ev) = kee;
kbeta(3*ev+1:3*ev+43,3*ev+1:3*ev+43) = kbb;
sz = size(Mstar,1);
%Overall Mass matrix assembly using substructure 1 and beta
MC = sparse(zeros(3*ev+43+sz,3*ev+43+sz));
MC(1:sz,1:sz) = Mstar;
MC(sz+1:end,sz+1:end) = mbeta;
%Overall Stiffness matrix assembly using substructure 1 and beta
KC = sparse(zeros((3*ev)+43+sz,(3*ev)+43+sz));
KC(1:sz,1:sz) = Kstar;
KC(sz+1:end,sz+1:end) = kbeta;
% Transformation matrix in CB method
Tmt = sparse(zeros((4*ev)+86,4*ev+43));
Tmt(1:ev,1:ev) = eye(ev);
Tmt(ev+1:ev+43,4*ev+1:4*ev+43) = eye(43);
Tmt(sz+1:4*ev+43,ev+1:4*ev) = eye(3*ev);
Tmt(4*ev+43+1:end,4*ev+1:end) = eye(43);
% Reduced dof system usin CB method
MRC = Tmt'*MC*Tmt;
KRC = Tmt'*KC*Tmt;
[VRC,DRC] = eigs(KRC,MRC,10,'sm');
%Partioned mass matrix corresponding to constraint mode
MCC = MRC(4*ev+1:4*ev+43,4*ev+1:4*ev+43);
%Partioned stiffness matrix corresponding to constraint mode
KCC = KRC(4*ev+1:4*ev+43,4*ev+1:4*ev+43);
[VCC,DCC] = eigs(KCC,MCC,ev,'sm');
%Transformation Matrix using CC modes
TCC = zeros(4*ev+43,5*ev);
TCC(1:ev,1:ev) = eye(ev);
TCC(ev+1:4*ev,ev+1:4*ev) = eye(3*ev);
TCC(4*ev+1:4*ev+43,4*ev+1:5*ev) = VCC;
%TCCT is Transpose of TCC
TCCT = zeros(5*ev,4*ev+43);
TCCT(1:ev,1:ev) = eye(ev);
TCCT(ev+1:4*ev,ev+1:4*ev) = eye(3*ev);
TCCT(4*ev+1:5*ev,4*ev+1:4*ev+43) = VCC';
%reduced Mass matrix after CC mode truncation
MOR = TCCT*MRC*TCC;
%reduced stiffness matrix after CC mode truncation
KOR = TCCT*KRC*TCC;
[VR,DR] = eigs(KOR,MOR,10,'sm');









