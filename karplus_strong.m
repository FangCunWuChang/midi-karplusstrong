function y = karplus_strong(t = 2,f = 300,fs = 44100, timbre = rand(8192, 1) - 0.5)
  
  N = round(fs * t);
  p = fs / f;
  l = ceil(p);
  np = floor(N / p) - 1;
  part = timbre(1:l);
  part = part - mean(part);
  y = zeros(N, 1);
  
  r = 0.5;
  
  for i = 1:np
    part = (part * r + [part(end);part(1:end - 1)] * (1 - r));
    pos = floor((i - 1) * p + 1);
    y(pos:pos + l - 1) = part;
  end
   
  y = y .* linspace(1, 0, length(y))';