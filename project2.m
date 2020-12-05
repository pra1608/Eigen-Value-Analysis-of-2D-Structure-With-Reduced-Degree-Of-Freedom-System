%Octave file for obtaining Reduced Size of Substructure2
load SubStructure2   % Loading Substructure2
% Interface node Int21;
a2 = [Int21(:,1)];
K2bb = K2(a2,a2);
K2ii = K2([1:a2(1)-1,a2(end)+1:end],[1:a2(1)-1,a2(end)+1:end]);
K2ib = K2([1:a2(1)-1,a2(end)+1:end],a2);
K2bi = K2(a2,[1:a2(1)-1,a2(end)+1:end]);
%rearranged K2 matrix
K2_rearranged = [K2ii K2ib;K2bi K2bb];
M2ii = M2([1:a2(1)-1,a2(end)+1:end],[1:a2(1)-1,a2(end)+1:end]);
M2ib = M2([1:a2(1)-1,a2(end)+1:end],a2);
M2bi = M2(a2,[1:a2(1)-1,a2(end)+1:end]);
M2bb = M2(a2,a2);
% Rearranged M2 mass matrix
M2_rearranged = [M2ii M2ib;M2bi M2bb];
%static Condensation matrix
shi2 = -inv(K2ii)*K2ib;
T2 = [shi2;eye(columns(shi2))];
[V2,D2,W2] = eigs(K2ii,M2ii,ev,'sm');
phi2 = [V2;zeros(columns(shi2),columns(V2))];
RM2 = sparse([phi2 T2]);
%Reduced Mass matrix
M2star = RM2'*M2_rearranged*RM2;
%Reduced stiness matrix
K2star = RM2'*K2_rearranged*RM2;
[V2s,D2s] = eigs(K2star,M2star,ev,'sm');
D2s =  sort(diag(D2s));
%partition of reduced M matrix
a2 = M2star(1:ev,1:ev);
b2 = M2star(1:ev,ev+1:end);
c2 = M2star(ev+1:end,1:ev);
d2 = M2star(ev+1:end,ev+1:end);
%partition of reduced K matrix
d22 = K2star(ev+1:end,ev+1:end);
a22 = K2star(1:ev,1:ev);