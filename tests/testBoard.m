writeDigitalPin(a.a, p.toggle.y, 0)
writeDigitalPin(a.a, p.toggle.x, 0)

for frq = 500:v.stepSize:v.frq
    playTone(a.a, p.ramp, frq, 1)
end

writeDigitalPin(a.a, p.toggle.y, 1)
writeDigitalPin(a.a, p.toggle.x, 1)

fprintf("Success!\n")