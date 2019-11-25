addpath("D:/midi/matlab-midi-master/src");
addpath("D:/midi");
song = readmidi("D:/midi/in.mid");
score = midiInfo(song, 0);

note = 5;
white = 15;
fs = 44100;
len = ceil((score(end, 6) + white) * fs);
y = zeros(len, 1);
timbre = rand(8192, 1) - 0.5; 

for i = 1:rows(score)
  tbegin = score(i, 5);
  tend = score(i, 6);
  pit = score(i, 3);
  freq = midi2freq(pit);
  
  
  
  x = karplus_strong((tend - tbegin) * note, freq, fs, timbre);
  
  nbegin = max(1, round(tbegin * fs));
  y(nbegin:nbegin + length(x) - 1) = y(nbegin:nbegin + length(x) - 1) + x;
  
  disp(i / rows(score) * 100);
  fflush(stdout);
end

y = y / max(abs(y));

audiowrite('D:/midi/out.wav',y,fs);
%sound(y,fs);