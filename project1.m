%Octave file for obtaining Reduced Size of Substructure1
format
load Substructure1 % Loading Substructure1
% Interface node Int12,Int13 and Int14
a = [Int12(:,1);Int13(:,1);Int14(:,1)];
Kbb = K1(a,a);
Kii = K1([1:a(1)-1,a(end)+1:end],[1:a(1)-1,a(end)+1:end]);
Kib = K1([1:a(1)-1,a(end)+1:end],a);
Kbi = K1(a,[1:a(1)-1,a(end)+1:end]);
%rearranged K1 matrix
K1_rearranged = [Kii Kib;Kbi Kbb];
Mii = M1([1:a(1)-1,a(end)+1:end],[1:a(1)-1,a(end)+1:end]);
Mib = M1([1:a(1)-1,a(end)+1:end],a);
Mbi = M1(a,[1:a(1)-1,a(end)+1:end]);
Mbb = M1(a,a);
% Rearranged M1 mass matrix
M1_rearranged = [Mii Mib;Mbi Mbb];
%static Condensation matrix
shi1 = -inv(Kii)*Kib;
T1 = [shi1;eye(columns(shi1))];
[V1,D1,W1] = eigs(Kii,Mii,ev,'sm');

phi1 = [V1;zeros(columns(shi1),columns(V1))];
RM1 = sparse([phi1 T1]);
%Reduced Mass matrix
Mstar = RM1'*M1_rearranged*RM1;
%Reduced stiness matrix
Kstar = RM1'*K1_rearranged*RM1;
[V1s,D1s] = eigs(Kstar,Mstar,ev,'sm');
D1s =  sort(diag(D1s));
%partition of reduced M matrix
a1 = Mstar(1:ev,1:ev);
b1 = Mstar(1:ev,ev+1:end);
c1 = Mstar(ev+1:end,1:ev);
d1 = Mstar(ev+1:end,ev+1:end);
%partition of reduced K matrix
d11 = Kstar(ev+1:end,ev+1:end);
a11 = Kstar(1:ev,1:ev);
