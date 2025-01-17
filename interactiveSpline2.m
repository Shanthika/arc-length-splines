
% interactiveSpline: This script provides an interactive tool for creating and modifying splines within a MATLAB figure. 
% Users can add control points by clicking within the figure window, and remove the nearest control point by pressing the 'r' key. 
% The spline is dynamically updated as control points are added or removed, offering a visual and intuitive way to shape the spline. 
% The script uses MATLAB's built-in 'spline' function to compute the smooth curve that passes through the control points, 
% and plots both the spline and control points for easy manipulation.
% The MATLAB's built-in 'spline' function is cubic spline
% Jul 17, 2024

function interactiveSpline
    % Initialize figure and axis
    fig = figure('Name', 'Interactive Spline', 'NumberTitle', 'off');
    ax = axes('Parent', fig);
    hold on;
    xlim([0 1]);
    ylim([0 1]);

    % Data storage for control points
    controlPoints = [];
    splinePlot = plot(NaN, NaN, 'b-', 'LineWidth', 2);
    controlPointPlot = plot(NaN, NaN, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % Set the callbacks for mouse click and key press
    set(fig, 'WindowButtonDownFcn', @addPoint);
    set(fig, 'KeyPressFcn', @removePoint);

    % Callback function to add a point
    function addPoint(~, ~)
        cp = get(ax, 'CurrentPoint');
        x = cp(1, 1);
        y = cp(1, 2);
        controlPoints = [controlPoints; x, y];
        updateSpline();
    end

    % Callback function to remove a point
    function removePoint(~, event)
        if isempty(controlPoints)
            return;
        end
        if strcmp(event.Key, 'r') % Press 'r' to remove the closest point
            cp = get(ax, 'CurrentPoint');
            x = cp(1, 1);
            y = cp(1, 2);
            distances = sqrt((controlPoints(:,1) - x).^2 + (controlPoints(:,2) - y).^2);
            [~, idx] = min(distances);
            controlPoints(idx, :) = [];
            updateSpline();
        end
    end

    % Function to update the spline plot
    function updateSpline
        if size(controlPoints, 1) < 2
            set(splinePlot, 'XData', NaN, 'YData', NaN);
            set(controlPointPlot, 'XData', controlPoints(:,1), 'YData', controlPoints(:,2));
            return;
        end
        % Calculate and plot the spline
        t = linspace(1, size(controlPoints, 1), 100);
        xx = spline(1:size(controlPoints, 1), controlPoints(:,1), t);
        yy = spline(1:size(controlPoints, 1), controlPoints(:,2), t);
        set(splinePlot, 'XData', xx, 'YData', yy);
        set(controlPointPlot, 'XData', controlPoints(:,1), 'YData', controlPoints(:,2));
    end
end
