
clear;
clc;


% Table Parameters

n = 10;
A = full(gallery('tridiag', n));


%Creation of b based on a known solution

x_exact = (1:n)'/n;
b = A*x_exact;


% Method

ID = diag(diag(A))^-1;

x0 = zeros(n,1);
tol = 1e-5;
max_num_loops = 10000;

for i = 1:max_num_loops
  x = x0 + ID*(b-A*x0);
  
  if (norm(b-A*x)<(tol*norm(b)))
    break
  end
  x0 = x;
end

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  