if dirn
    
    % update position with change between old count and current count
    pos = pos + (readCount(encoder) - count);
    
    % update current count
    [count,~] = readCount(encoder);
    
    
else
    
    % update position with change between old count and current count
    pos = pos - (readCount(encoder) - count);
    
    % update current count
    [count,~] = readCount(encoder);
    
end