clear t output

t = 0;

while t < 160
    
    for n = t(end):0.01:t(end) + 30
        output(size(t)) = 0;
        
        t = [t, n];
    end

    for n = t(end):0.01:t(end) + 30
        output(size(t)) = 1;
        
        t = [t, n];
    end

end

t(end) = [];


figure('Renderer', 'painters', 'Position', [0 0 500 100])

plot(t, output, 'Color', [0.7 0 0.2])
ylim([-0.2, 1.2])
xlim([0, 150])
xlabel('time / ms', 'Position',[75 -0.25]);
yticks([0, 1])
