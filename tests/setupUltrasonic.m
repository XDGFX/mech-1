if ~exist("u", "var")
    u = ultrasonic(a, "D34", "D36");
    fprintf("ultrasonic created successfully\n")
end

dist = readDistance(u);
fprintf("   |   Distance = %.2f\n", dist)