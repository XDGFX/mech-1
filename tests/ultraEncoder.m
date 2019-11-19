while 1
    setupUltrasonic
    
    if isinf(dist)
        
    elseif dist < 0.01
        
    elseif dist > 2
        
    else
        pos = dist * 1000;
    end
    
    setupEncoder
end