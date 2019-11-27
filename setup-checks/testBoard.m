writeDigitalPin(a.a, p.enable.y, 0)
writeDigitalPin(a.a, p.enable.x, 0)

for frq = 500:10:v.frq
    playTone(a.a, p.ramp, frq, 1)
end

writeDigitalPin(a.a, p.enable.y, 1)
writeDigitalPin(a.a, p.enable.x, 1)

pause(1)



fprintf("Success!\n")