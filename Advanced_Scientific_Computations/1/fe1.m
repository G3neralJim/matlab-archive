clc;
clear;

% Problem Parameters
% Nodes per dimension
N = 10;

% Interval per dimension
n = N-1;

% Number of elements
ne = 2*n^2;
% Number of nodes
nc = n^2;

% Step
h = 1/n;


% Coordinate matrix
coords = zeros(nc,2);
for i = 1:N
  for j = 1:N
    coords((i-1)*N+j, :) = [(j-1)*h, (i-1)*h];
  endfor
endfor


% Local-to-global matrix
numbering = reshape(1:N^2, N, N)';
l2g = zeros(ne,3);
k = 1;

for i = 1:n
  for j = 1:n
    l2g(k,:) = [numbering(i,j), numbering(i, j+1), numbering(i+1, j)];
    l2g(k+1,:) = [numbering(i+1,j+1), numbering(i+1, j), numbering(i, j+1)];
    k = k + 2;
  endfor
endfor

% Assemble the global stiffness matrix
M = spalloc(N^2, N^2, 5*N^2);
Me = zeros(3,3);


for e = 1:ne
  y12 = coords(l2g(e,1), 2) - coords(l2g(e,2),2);
  y23 = coords(l2g(e,2), 2) - coords(l2g(e,3),2);
  y31 = coords(l2g(e,3), 2) - coords(l2g(e,1),2);
  y21 = coords(l2g(e,2), 2) - coords(l2g(e,1),2);

  x31 = coords(l2g(e,3), 1) - coords(l2g(e,1),1);
  x32 = coords(l2g(e,3), 1) - coords(l2g(e,2),1);
  x21 = coords(l2g(e,2), 1) - coords(l2g(e,1),1);
  x13 = coords(l2g(e,1), 1) - coords(l2g(e,3),1);

  Ae = (x21*y31-x31*y21)/2;

  Me(1,1) = -(y23*y23+x32*x32)/(4*Ae);
  Me(1,2) = -(y23*y31+x32*x13)/(4*Ae);
  Me(1,3) = -(y23*y12+x32*x21)/(4*Ae);
  Me(2,1) = Me(1,2);
  Me(2,2) = -(y31^2+x13^2)/(4*Ae);
  Me(2,3) = -(y31*y12+x13*x21)/(4*Ae);
  Me(3,1) = Me(1,3);
  Me(3,2) = Me(2,3);
  Me(3,3) = -(y12^2 + x21^2)/(4*Ae);


  for i = 1:3
    for j = 1:3
      M(l2g(e,i), l2g(e,j)) = M(l2g(e,i), l2g(e,j)) + Me(i,j);
    endfor
  endfor
endfor

% Assemble the right hand side vector
F = zeros(N^2,1);
Fe = zeros(3,1);
f = @(x,y) 2*pi^2*sin(pi*x).*sin(pi*y);

for e = 1:ne
  x31 = coords(l2g(e,3), 1) - coords(l2g(e,1),1);
  x21 = coords(l2g(e,2), 1) - coords(l2g(e,1),1);
  y31 = coords(l2g(e,3), 2) - coords(l2g(e,1),2);
  y21 = coords(l2g(e,2), 2) - coords(l2g(e,1),2);
  x1 = coords(l2g(e,1),1);
  y1 = coords(l2g(e,1),2);

  x = @(k,e) x1 + x21*k + x31*e;
  y = @(k,e) y1 + y21*k + y31*e;
  Ae = (x21*y31 - x31*y21)/2;

  Fe(1) = 2 * Ae * integral2(@(k,e) (1-k-e).*f(x(k,e),y(k,e)), 0,1, 0, @(k) 1-k);
  Fe(2) = 2 * Ae * integral2(@(k,e) (k).*f(x(k,e),y(k,e)), 0,1, 0, @(k) 1-k);
  Fe(3) = 2 * Ae * integral2(@(k,e) (e).*f(x(k,e),y(k,e)), 0,1, 0, @(k) 1-k);
  for i = 1:3
    F(l2g(e,i)) = F(l2g(e,i)) + Fe(i);
  endfor
endfor


% Find boundaries
numbering(2:end-1, 2:end-1) = 0;
boundaries = find(numbering);

% Remove lines and columns
M(boundaries, :) = [];
M(:, boundaries) = [];
F(boundaries) = [];

% Solve and plot
x = M\F;
mesh(reshape(x,n-1,n-1));














