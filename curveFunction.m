function [curveX, curveY] = curveFunction(points, totalArcLength)
    % Input: 
    % points - Nx2 matrix where each row is a point [x, y]
    % totalArcLength - desired total arc length of the curve
    
    % Output:
    % curveX, curveY - vectors of x and y coordinates of the curve
    
    % Number of points
    n = size(points, 1);
    
    % Calculate distances between consecutive points
    distances = sqrt(sum(diff(points).^2, 2));
    
    % Calculate cumulative arc length
    cumulativeArcLength = [0; cumsum(distances)];
    
    % Normalize cumulative arc length to range from 0 to 1
    normalizedArcLength = cumulativeArcLength / cumulativeArcLength(end);
    
    % Desired number of points on the curve
    numCurvePoints = 100; % Change as needed
    
    % Interpolated arc length for the curve
    curveArcLength = linspace(0, 1, numCurvePoints);
    
    % Interpolated x and y coordinates
    curveX = interp1(normalizedArcLength, points(:, 1), curveArcLength, 'spline');
    curveY = interp1(normalizedArcLength, points(:, 2), curveArcLength, 'spline');
    
    % Scale the curve to the desired total arc length
    scale = totalArcLength / cumulativeArcLength(end);
    curveX = curveX*scale;
    curveY = curveY*scale;

    % Plot the curve
    figure;
    plot(curveX, curveY);
    hold on;
    title('Curve Interpolation using Arc-Length and Points');
    xlabel('X');
    ylabel('Y');
    grid on;
    hold off;
end

