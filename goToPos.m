function [v] = goToPos(a, p, v, position, ramp)
% Sends gantry to pos = [x, y] as fast as possible

% Extract target data from input variable
target.x = position(1);
target.y = position(2);

% for d = ["x", "y"]
%     if target.(d) > v.gantry.(d)
%         target.(d) = v.gantry.(d);
%         fprintf("Target %s too large, defaulting to: %.f\n", d, v.gantry.(d))
%     elseif target.(d) < 0
%         target.(d) = 0;
%         fprintf("Target %s too small, defaulting to: 0\n", d)
%     end
% end

[dist, start] = distPosDir;

% Assign shortest distance variable to 's' and longest to 'l'
if dist.x < dist.y
    s = "x";
    l = "y";
else
    s = "y";
    l = "x";
end

% Check if both are close enough to the same
if abs(dist.(s) - dist.(l)) < v.CE
    % Enable both axes
    playTone(a.a, p.ramp, 0, 0.1) % Clear playtone pin
    writeDigitalPin(a.a, p.enable.(s), 0)
    writeDigitalPin(a.a, p.enable.(l), 0)
    
    %travel to one
    outputRamp(s, 1)
    
    % Do corrections
    correctPos
else
    % Enable both axes
    playTone(a.a, p.ramp, 0, 0.1) % Clear playtone pin
    writeDigitalPin(a.a, p.enable.(s), 0)
    writeDigitalPin(a.a, p.enable.(l), 0)
    
    % Travel to s
    outputRamp(s, 1)
    
    % Disable s axis
    writeDigitalPin(a.a, p.enable.(s), 1)
    
    % Clear playtone pin
    playTone(a.a, p.ramp, 0, 0.1)
    
    % Relearn distance and start positions
    [dist, start] = distPosDir;
    
    % Travel to l
    outputRamp(l, 0)
    
    % Do corrections
    correctPos
end

    function outputRamp(d, b)
        
        % Check if both axes need to be checked
        if b
            getPosDim = "b";
        else
            getPosDim = d;
        end
        
        % Initial frequency
        frq = v.minFrq;
        
        % While less than halfway to target
        while abs(v.pos.(d) - start.(d)) < dist.(d) / 2
            
            % Update position
            v = getPos(a, v, getPosDim);
            
            % Ramp playtone
            playTone(a.a, p.ramp, frq, 0.1)
            
            % Increase frequency
            if frq < v.frq && (~exist("ramp", "var") || ramp)
                frq = frq + v.m;
            end
        end
        
        % Save peak frequency
        peakFrq = frq - v.minFrq;
        
        while abs(v.pos.(d) - start.(d)) < dist.(d)
            
            % Update position
            v = getPos(a, v, getPosDim);
            
            % Calculate remaining distance
            distLeft.(d) = abs(target.(d) - v.pos.(d));
            
            % Ramp playtone
            playTone(a.a, p.ramp, frq, 0.1)
            
            % Reduce frequency squared to distance left
            if ~exist("ramp", "var") || ramp
                frq = v.minFrq + peakFrq * (distLeft.(d) * 2 / dist.(d))^1;
            end
        end
        
        v = getPos(a, v);
        
    end

    function [dist, start] = distPosDir
        
        % Read current position
        v = getPos(a, v);
        
        % Calculate distance required to travel
        dist.x = abs(target.x - v.pos.x);
        dist.y = abs(target.y - v.pos.y);
        
        % Determine start positions
        start.x = v.pos.x;
        start.y = v.pos.y;
        
        % Determine required direction
        for d = ["x", "y"]
            if target.(d) > v.pos.(d) % Target in positive direction
                
                v.direction.(d) = 1;
                writeDigitalPin(a.a, p.direction.(d), v.direction.(d))
                
            else % Target in negative direction
                
                v.direction.(d) = 0;
                writeDigitalPin(a.a, p.direction.(d), v.direction.(d))
            end
        end
        
        % Update current position after direction change
        v = getPos(a, v);
        
    end

    function correctPos
        [dist, ~] = distPosDir;
        
        while dist.x > v.CE && dist.y > v.CE
            
            
            % Disable both axes
            writeDigitalPin(a.a, p.enable.x, 1)
            writeDigitalPin(a.a, p.enable.y, 1)
            
            for d = ["x", "y"]
                % Update current position
                v = getPos(a, v);
                
                % Enable d axis
                playTone(a.a, p.ramp, 0, 0.1) % Clear playtone pin
                writeDigitalPin(a.a, p.enable.(d), 0)
                
                % Play time to reach desired pos
                playTime = dist.(d) / (2 * v.minFrq);
                
                % Playtone to reach desired pos
                playTone(a.a, p.ramp, v.minFrq / 2, playTime * 2)
                
                pause(playTime)
                
                writeDigitalPin(a.a, p.enable.(d), 1)
                
                v = getPos(a, v);
                
            end
            
            [dist, ~] = distPosDir;
        end
    end

end