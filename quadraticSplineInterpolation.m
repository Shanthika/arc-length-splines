%This function constructs a quadratic spline interpolation for a given set of data points by:
%1. Initializing the necessary coefficients
%2. Calculating the coefficients for each segment using continuity and smoothness conditions
%3. Evaluating the spline at specified points
%4. Each segment of the spline is a quadratic polynomial 


function yi = quadraticSplineInterpolation(x, y, xi)
    %If there are fewer than 3 points, interpolation cannot be performed,
    % so the function returns an empty vector yi
    n = length(x);
    if n < 3
        yi = [];
        return;
    end
    
    % Input validation: ensure inputs are column vectors
    x = x(:);
    y = y(:);
    xi = xi(:);
    
    % Initialize the vectors for coefficients
    a = y(1:end-1);
    b = zeros(n-1, 1);
    c = zeros(n-1, 1);

    % Calculate coefficients for each interval
    for i = 1:n-2
        b(i) = (y(i+1) - y(i)) / (x(i+1) - x(i)) - (x(i+1) - x(i)) * c(i);
        c(i+1) = (y(i+2) - y(i+1) - b(i) * (x(i+2) - x(i+1))) / ((x(i+2) - x(i+1))^2);
    end

    % For the last interval
    b(n-1) = (y(n) - y(n-1)) / (x(n) - x(n-1)) - (x(n) - x(n-1)) * c(n-1);

    % Perform the interpolation
    yi = zeros(size(xi));
    for k = 1:length(xi)
        % Find the interval containing xi(k)
        for i = 1:n-1
            if x(i) <= xi(k) && xi(k) <= x(i+1)
                yi(k) = a(i) + b(i) * (xi(k) - x(i)) + c(i) * (xi(k) - x(i))^2;
                break;
            end
        end
    end
end
