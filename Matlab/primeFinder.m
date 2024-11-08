

function output = primeFinder(vector)
output = [];
i = 1;

for n = vector
    if isprime(n)
      output = [output ; i]; 
    end
    i = i + 1;
end

end