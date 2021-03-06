%DEMRBF1 Demonstrate simple regression using a radial basis function network.
%
%	Description
%	The problem consists of one input variable X and one target variable
%	T with data generated by sampling X at equal intervals and then
%	generating target data by computing SIN(2*PI*X) and adding Gaussian
%	noise. This data is the same as that used in demmlp1.
%
%	Three different RBF networks (with different activation functions)
%	are trained in two stages. First, a Gaussian mixture model is trained
%	using the EM algorithm, and the centres of this model are used to set
%	the centres of the RBF.  Second, the output weights (and biases) are
%	determined using the pseudo-inverse of the design matrix.
%
%	See also
%	DEMMLP1, RBF, RBFFWD, GMM, GMMEM
%

%	Copyright (c) Christopher M Bishop, Ian T Nabney (1996, 1997)


% Generate the matrix of inputs x and targets t.
randn('state', 42);
rand('state', 42);
ndata = 20;			% Number of data points.
noise = 0.2;			% Standard deviation of noise distribution.
x = [0:1/(ndata - 1):1]';
t = sin(2*pi*x) + noise*randn(ndata, 1);

clc
disp('This demonstration illustrates the use of a Radial Basis Function')
disp('network for regression problems.  The data is generated from a noisy')
disp('sine function.')
disp(' ')
disp('Press any key to continue.')
pause
% Set up network parameters.
nin = 1;			% Number of inputs.
nhidden = 5;			% Number of hidden units.
nout = 1;			% Number of outputs.

clc
disp('We assess the effect of three different activation functions.')
disp('First we create a network with Gaussian activations.')
disp(' ')
disp('Press any key to continue.')
pause
% Create and initialize network weight and parameter vectors.
net = rbf(nin, nhidden, nout, 'gaussian');

disp('A two-stage training algorithm is used: it uses a small number of')
disp('iterations of EM to position the centres, and then the pseudo-inverse')
disp('of the design matrix to find the second layer weights.')
disp(' ')
disp('Press any key to continue.')
pause
disp('Error values from EM training.')
% Use fast training method
options = foptions;
options(1) = 1;		% Display EM training
options(14) = 10;	% number of iterations of EM
net = rbftrain(net, options, x, t);
disp(' ')
disp('Press any key to continue.')
pause
clc
disp('The second RBF network has thin plate spline activations.')
disp('The same centres are used again, so we just need to calculate')
disp('the second layer weights.')
disp(' ')
disp('Press any key to continue.')
pause
% Create a second RBF with thin plate spline functions
net2 = rbf(nin, nhidden, nout, 'tps');

% Re-use previous centres rather than calling rbftrain again
net2.c = net.c;
[y, act] = rbffwd(net2, x);

% Solve for new output weights and biases from RBF activations
temp = pinv([act ones(ndata, 1)]) * t;
net2.w2 = temp(1:nhidden, :);
net2.b2 = temp(nhidden+1, :);

disp('The third RBF network has r^4 log r activations.')
disp(' ')
disp('Press any key to continue.')
pause
% Create a third RBF with r^4 log r functions
net3 = rbf(nin, nhidden, nout, 'r4logr');

% Overwrite weight vector with parameters from first RBF
net3.c = net.c;
[y, act] = rbffwd(net3, x);

temp = pinv([act ones(ndata, 1)]) * t;
net3.w2 = temp(1:nhidden, :);
net3.b2 = temp(nhidden+1, :);

clc
disp('Now we plot the data, underlying function, and network outputs')
disp('on a single graph to compare the results.')
disp(' ')
disp('Press any key to continue.')
pause
% Plot the data, the original function, and the trained network functions.
plotvals = [0:0.01:1]';
y = rbffwd(net, plotvals);
y2 = rbffwd(net2, plotvals);
y3 = rbffwd(net3, plotvals);
fh1 = figure;

plot(x, t, 'ob')
hold on
axis([0 1 -1.5 1.5])
[fx, fy] = fplot('sin(2*pi*x)', [0 1]);
plot(fx, fy, '-r', 'LineWidth', 2)
plot(plotvals, y, '--g', 'LineWidth', 2)
plot(plotvals, y2, 'k--', 'LineWidth', 2)
plot(plotvals, y3, '-.c', 'LineWidth', 2)
legend('data', 'function', 'Gaussian RBF', 'Thin plate spline RBF', ...
  'r^4 log r RBF');
hold off

disp(' ')
disp('Press any key to end.')
pause
close(fh1);
clear all;
