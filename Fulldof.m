%Octave file for Full Degree of freedom system
%assembly of substructure 1, 2, 3 and 4 
MEE = sparse(zeros(1763,1763)); % E denote internal node
MEE(1:451,1:451) = M2ii;
MEE(452:1312,452:1312) = M3ii;
MEE(1313:1763,1313:1763) = M4ii;
MBB = sparse(zeros(43,43));
MBB(1:11,1:11) = M2bb;          % B denote Boundary node
MBB(12:32,12:32) = M3bb;
MBB(33:43,33:43) = M4bb;
MBB = MBB+Mbb;
% Assembling the Substructure for Mass matrix
MOrig = sparse(zeros(3105,3105));
MOrig(1:1299,1:1299) = Mii;
MOrig(1300:3062,1300:3062) = MEE;
MOrig(3063:3105,3063:3105) = MBB;

KEE = sparse(zeros(1763,1763));
KEE(1:451,1:451) = K2ii;
KEE(452:1312,452:1312) = K3ii;
KEE(1313:1763,1313:1763) = K4ii;
KBB = sparse(zeros(43,43));
KBB(1:11,1:11) = K2bb;
KBB(12:32,12:32) = K3bb;
KBB(33:43,33:43) = K4bb;
KBB = KBB+Kbb;
KEB = sparse(zeros(1763,43));
KEB(1:451,1:11) = K2ib;
KEB(452:1312,12:32) = K3ib;
KEB(1313:1763,33:43) = K4ib;
KBE = sparse(zeros(43,1763));
KBE(1:11,1:451) = K2bi;
KBE(12:32,452:1312) = K3bi;
KBE(33:43,1313:1763) = K4bi;
% Assembling the Substructure for stiffness matrix
KOrig = sparse(zeros(3105,3105));
KOrig(1:1299,1:1299) = Kii;
KOrig(1300:3062,1300:3062) = KEE;
KOrig(3063:3105,3063:3105) = KBB;
KOrig(1:1299,3063:3105) = Kib;
KOrig(1300:3062,3063:3105) = KEB;
KOrig(3063:3105,1:1299) = Kbi;
KOrig(3063:3105,1300:3062) = KBE;
%lowest 10 natural frequencies extracted
[VOrig DOrig] = eigs(KOrig,MOrig,10,'sm');


