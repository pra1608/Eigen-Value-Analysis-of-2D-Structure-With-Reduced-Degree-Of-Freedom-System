%Octave file for obtaining Reduced Size of Substructure4
load SubStructure4 % Loading Substructure4
% Interface node Int41
a4 = [Int41(:,1)];
K4bb = K4(a4,a4);
K4ii = K4([1:a4(1)-1,a4(end)+1:end],[1:a4(1)-1,a4(end)+1:end]);
K4ib = K4([1:a4(1)-1,a4(end)+1:end],a4);
K4bi = K4(a4,[1:a4(1)-1,a4(end)+1:end]);
%rearranged K4 matrix
K4_rearranged = [K4ii K4ib;K4bi K4bb];
M4ii = M4([1:a4(1)-1,a4(end)+1:end],[1:a4(1)-1,a4(end)+1:end]);
M4ib = M4([1:a4(1)-1,a4(end)+1:end],a4);
M4bi = M4(a4,[1:a4(1)-1,a4(end)+1:end]);
M4bb = M4(a4,a4);
% Rearranged M4 mass matrix
M4_rearranged = [M4ii M4ib;M4bi M4bb];
%static Condensation matrix
shi4 = -inv(K4ii)*K4ib;
T4 = [shi4;eye(columns(shi4))];
[V4,D4,W4] = eigs(K4ii,M4ii,ev,'sm');
phi4 = [V4;zeros(columns(shi4),columns(V4))];
RM4 = sparse([phi4 T4]);
%Reduced Mass matrix
M4star = RM4'*M4_rearranged*RM4;
%Reduced stiness matrix
K4star = RM4'*K4_rearranged*RM4;
[V4s,D4s] = eigs(K4star,M4star,ev,'sm');
D4s =  sort(diag(D4s));
%partition of reduced M matrix
a4 = M4star(1:ev,1:ev);
b4 = M4star(1:ev,ev+1:end);
c4 = M4star(ev+1:end,1:ev);
d4 = M4star(ev+1:end,ev+1:end);
%partition of reduced K matrix
d44 = K4star(ev+1:end,ev+1:end);
a44 = K4star(1:ev,1:ev);

