function dataOut = blockaverage(dataIn, Parameters)

fs = 1./mean(diff(dataIn{:,1}));
cutoff = Parameters(1).value;
tempDataOut = lowpass(dataIn{:,2:end},cutoff, fs, 'ImpulseResponse','iir','Steepness',0.75);
dataOut = dataIn;
dataOut{:,2:end} = tempDataOut;

end