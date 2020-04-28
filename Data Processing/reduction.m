% Reducing the amount of samples

function b=reduction(t)
i=1;
while i<590
    b(i)=t(i*10);
    i=i+1;
end