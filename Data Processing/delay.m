% Delaying the data 

function b=delay(x)
a=length(x);
i=2;
while i<590
  b(i)=x(i-1);
  i=i+1;
end
    
    