function [frq] = createFrqCurve(v, dist)
%% Creates output frequency curve to reach specified distance

% distance traveled = area under curve
% area under curve = peak frq * x / 2
% peak frq = x / 2 * m

% if dist / 2 * v.m < v.frq
%     f = dist / 2 * v.m;
% else
%     f = v.frq;
% end

% area under curve = x^2 * m/ 4

% Area under curve actually
% dist^2 * m

% distance = x^2 * m / 4

% First assume peak frequency is not reached
% Triangular profile
xMax = round(2 * (dist / v.m)^0.5 * 2 * v.SCF);

if xMax * v.m / 2 > v.frq
    % Peak frequency is surpassed
    % Re-calculate with trapezoidal
    disp("too high")
    
    % Convert distance using SCF
    xMax = round((dist^2 / (2*v.frq) + dist * v.frq * v.m) * v.SCF / 800000);
    
end

% Create profile x dimensions
x = 1:xMax;

h1 = 1:round(xMax / 2);
h2 = round(xMax / 2) + 1:xMax;

% Create triangle profile
frq(h1) = v.m .* x(h1);
frq(h2) = flip(v.m .* x(1:length(h2)));

% Limit values above v.frq
frq(frq > v.frq) = v.frq;

plot(x, frq)