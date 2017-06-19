function initrand()
% Initialize random number generator to a fixed seed.
% This ensures that results are reproducible.

% try make different versions of matlab happy
try
  RandStream.setDefaultStream(RandStream('mt19937ar','seed',3));
catch
  rand('twister',3);
end
