% Loading Substructure3
load SubStructure3 % Loading Substructure3
% Interface node Int31,
a3 = [Int31(:,1)];
K3bb = K3(a3,a3);
K3ii = K3([1:a3(1)-1,a3(end)+1:end],[1:a3(1)-1,a3(end)+1:end]);
K3ib = K3([1:a3(1)-1,a3(end)+1:end],a3);
K3bi = K3(a3,[1:a3(1)-1,a3(end)+1:end]);
%rearranged K3 matrix
K3_rearranged = [K3ii K3ib;K3bi K3bb];
M3ii = M3([1:a3(1)-1,a3(end)+1:end],[1:a3(1)-1,a3(end)+1:end]);
M3ib = M3([1:a3(1)-1,a3(end)+1:end],a3);
M3bi = M3(a3,[1:a3(1)-1,a3(end)+1:end]);
M3bb = M3(a3,a3);
% Rearranged M1 mass matrix
M3_rearranged = [M3ii M3ib;M3bi M3bb];
%static Condensation matrix
shi3 = -inv(K3ii)*K3ib;
T3 = [shi3;eye(columns(shi3))];
[V3,D3,W3] = eigs(K3ii,M3ii,ev,'sm');
phi3 = [V3;zeros(columns(shi3),columns(V3))];
RM3 = sparse([phi3 T3]);
%Reduced Mass matrix
M3star = RM3'*M3_rearranged*RM3;
%Reduced stiness matrix
K3star = RM3'*K3_rearranged*RM3;
[V3s,D3s] = eigs(K3star,M3star,ev,'sm');
D3s =  sort(diag(D3s));
%partition of reduced M matrix
a3 = M3star(1:ev,1:ev);
b3 = M3star(1:ev,ev+1:end);
c3 = M3star(ev+1:end,1:ev);
d3 = M3star(ev+1:end,ev+1:end);
%partition of reduced K matrix
d33 = K3star(ev+1:end,ev+1:end);
a33 = K3star(1:ev,1:ev);
