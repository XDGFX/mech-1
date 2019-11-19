writeDigitalPin(a, direction(1), 0)

frq = [0, 4000];
tPause = 0.3;
stepSize = 150;

writeDigitalPin(a, toggle, 1)
pulse = pwmPin;

while 1
    
    writeDigitalPin(a, direction(2), 0)
    
    for x = 0:stepSize:frq(2)
        playTone(a, pulse(1) , x, tPause);
    end
    
    playTone(a, pulse(1) , 0, tPause);
    
%     for x = frq(2):-stepSize:0
%         playTone(a, pulse(1) , x, tPause);
%     end
    
    playTone(a, pulse(1) , 0, tPause);
    pause(tPause)
    
    writeDigitalPin(a, direction(2), 1)
    
    for x = 0:stepSize:frq(2)
        playTone(a, pulse(1) , x, tPause);
    end
    
      playTone(a, pulse(1) , 0, tPause);
    
%     for x = frq(2):-stepSize:0
%         playTone(a, pulse(1) , x, tPause);
%     end
    
    playTone(a, pulse(1) , 0, tPause);
    pause(tPause)
    
end

% for x = 1:2
%
%     playTone(a, pulse(1) , frq, tPause);
%     pause(tPause)
%
%     writeDigitalPin(a, direction(1), 1)
%
%     playTone(a, pulse(1) , frq, tPause);
%     pause(tPause)
%
%     writeDigitalPin(a, direction(1), 0)
%
%
% end